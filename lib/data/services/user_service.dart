import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../models/user_model.dart';
import '../models/progress_model.dart';
import 'storage_service.dart';

class UserService extends ChangeNotifier {
  final StorageService _storageService;
  UserModel? _currentUser;
  ProgressModel? _progress;
  bool _isLoading = false;
  
  final _uuid = Uuid();
  
  UserService(this._storageService) {
    _loadUser();
  }
  
  // Getters
  UserModel? get currentUser => _currentUser;
  ProgressModel? get progress => _progress;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _currentUser != null;
  bool get hasQuitDate => _currentUser?.quitDate != null;
  
  // Load user from storage
  Future<void> _loadUser() async {
    _isLoading = true;
    notifyListeners();
    
    _currentUser = _storageService.getUserData();
    _progress = _storageService.getProgress();
    
    _isLoading = false;
    notifyListeners();
  }
  
  // Create new user
  Future<void> createUser({
    required String name,
    required int age,
    required String gender,
    String? email,
    required VapingHistoryModel vapingHistory,
    required List<String> motivationFactors,
    DateTime? quitDate,
    Map<String, dynamic>? preferences,
    bool privacyPolicyAccepted = false,
  }) async {
    _isLoading = true;
    notifyListeners();
    
    final userId = _uuid.v4();
    final now = DateTime.now();
    
    // Add privacy policy acceptance to preferences
    final userPreferences = preferences ?? {};
    userPreferences['privacyPolicyAccepted'] = privacyPolicyAccepted;
    userPreferences['privacyPolicyAcceptedDate'] = now.toIso8601String();
    
    final user = UserModel(
      id: userId,
      name: name,
      age: age,
      gender: gender,
      email: email,
      createdAt: now,
      updatedAt: now,
      vapingHistory: vapingHistory,
      motivationFactors: motivationFactors,
      quitDate: quitDate,
      preferences: userPreferences,
    );
    
    // Create initial progress if quit date is set
    if (quitDate != null) {
      final progress = ProgressModel(
        userId: userId,
        quitDate: quitDate,
        dailySavings: _calculateDailySavings(vapingHistory),
        achievedMilestones: {},
        currentStreak: 0,
        longestStreak: 0,
        achievements: [],
      );
      
      await _storageService.saveProgress(progress);
      _progress = progress;
    }
    
    await _storageService.saveUserData(user);
    await _storageService.saveOnboardingComplete(true);
    _currentUser = user;
    
    _isLoading = false;
    notifyListeners();
  }
  
  // Update user profile - combined method for profile screen
  Future<void> updateProfile({
    String? name,
    String? email,
    String? gender,
    DateTime? quitDate,
    int? dailyFrequency,
    int? nicotineStrength,
    double? yearsVaping,
    String? deviceType,
  }) async {
    if (_currentUser == null) return;
    
    _isLoading = true;
    notifyListeners();
    
    // Update vaping history if any of those fields changed
    VapingHistoryModel? updatedVapingHistory;
    if (dailyFrequency != null || nicotineStrength != null || yearsVaping != null || deviceType != null) {
      final currentHistory = _currentUser!.vapingHistory;
      updatedVapingHistory = VapingHistoryModel(
        dailyFrequency: dailyFrequency ?? currentHistory.dailyFrequency,
        nicotineStrength: nicotineStrength ?? currentHistory.nicotineStrength,
        yearsVaping: yearsVaping ?? currentHistory.yearsVaping,
        deviceType: deviceType ?? currentHistory.deviceType,
        commonTriggers: currentHistory.commonTriggers,
        previousQuitAttempts: currentHistory.previousQuitAttempts,
      );
    }
    
    // Update user profile
    await updateUserProfile(
      name: name,
      gender: gender,
      email: email,
      vapingHistory: updatedVapingHistory,
    );
    
    // Update quit date if provided
    if (quitDate != null) {
      await setQuitDate(quitDate);
    }
    
    _isLoading = false;
    notifyListeners();
  }
  
  // Update user profile
  Future<void> updateUserProfile({
    String? name,
    int? age,
    String? gender,
    String? email,
    VapingHistoryModel? vapingHistory,
    List<String>? motivationFactors,
    Map<String, dynamic>? preferences,
  }) async {
    if (_currentUser == null) return;
    
    _isLoading = true;
    notifyListeners();
    
    final updatedUser = _currentUser!.copyWith(
      name: name ?? _currentUser!.name,
      age: age ?? _currentUser!.age,
      gender: gender ?? _currentUser!.gender,
      email: email ?? _currentUser!.email,
      vapingHistory: vapingHistory ?? _currentUser!.vapingHistory,
      motivationFactors: motivationFactors ?? _currentUser!.motivationFactors,
      preferences: preferences ?? _currentUser!.preferences,
      updatedAt: DateTime.now(),
    );
    
    // Update daily savings if vaping history changed
    if (vapingHistory != null && _progress != null) {
      final updatedProgress = _progress!.copyWith(
        dailySavings: _calculateDailySavings(vapingHistory),
      );
      
      await _storageService.saveProgress(updatedProgress);
      _progress = updatedProgress;
    }
    
    await _storageService.saveUserData(updatedUser);
    _currentUser = updatedUser;
    
    _isLoading = false;
    notifyListeners();
  }
  
  // Set or update quit date
  Future<void> setQuitDate(DateTime quitDate) async {
    if (_currentUser == null) return;
    
    _isLoading = true;
    notifyListeners();
    
    final updatedUser = _currentUser!.copyWith(
      quitDate: quitDate,
      updatedAt: DateTime.now(),
    );
    
    // Create or update progress
    if (_progress == null) {
      final progress = ProgressModel(
        userId: _currentUser!.id,
        quitDate: quitDate,
        dailySavings: _calculateDailySavings(_currentUser!.vapingHistory),
        achievedMilestones: {},
        currentStreak: 0,
        longestStreak: 0,
        achievements: [],
      );
      
      await _storageService.saveProgress(progress);
      _progress = progress;
    } else {
      final updatedProgress = _progress!.copyWith(
        quitDate: quitDate,
      );
      
      await _storageService.saveProgress(updatedProgress);
      _progress = updatedProgress;
    }
    
    await _storageService.saveUserData(updatedUser);
    _currentUser = updatedUser;
    
    _isLoading = false;
    notifyListeners();
  }
  
  // Record a relapse
  Future<void> recordRelapse(DateTime date) async {
    if (_progress == null) return;
    
    _isLoading = true;
    notifyListeners();
    
    await _storageService.addRelapse(date);
    _progress = _storageService.getProgress();
    
    _isLoading = false;
    notifyListeners();
  }
  
  // Update user preferences
  Future<void> updatePreferences(Map<String, dynamic> newPreferences) async {
    if (_currentUser == null) return;
    
    _isLoading = true;
    notifyListeners();
    
    final currentPreferences = Map<String, dynamic>.from(_currentUser!.preferences);
    currentPreferences.addAll(newPreferences);
    
    final updatedUser = _currentUser!.copyWith(
      preferences: currentPreferences,
      updatedAt: DateTime.now(),
    );
    
    await _storageService.saveUserData(updatedUser);
    _currentUser = updatedUser;
    
    _isLoading = false;
    notifyListeners();
  }
  
  // Calculate dependency level
  String getDependencyLevel() {
    if (_currentUser == null) return 'Unknown';
    return _currentUser!.dependencyLevel;
  }
  
  // Get time since quitting
  Map<String, int> getTimeSinceQuitting() {
    if (_currentUser == null || _currentUser!.quitDate == null) {
      return {
        'days': 0,
        'hours': 0,
        'minutes': 0,
      };
    }
    
    return {
      'days': _currentUser!.daysSinceQuitting,
      'hours': _currentUser!.hoursSinceQuitting % 24,
      'minutes': _currentUser!.minutesSinceQuitting % 60,
    };
  }
  
  // Create default progress for a user
  ProgressModel createDefaultProgress(UserModel user) {
    return ProgressModel(
      userId: user.id,
      quitDate: user.quitDate ?? DateTime.now(),
      dailySavings: _calculateDailySavings(user.vapingHistory),
      achievedMilestones: {},
      currentStreak: 0,
      longestStreak: 0,
      achievements: [],
    );
  }
  
  // Calculate daily savings based on vaping habits
  double _calculateDailySavings(VapingHistoryModel vapingHistory) {
    // Simple calculation based on device type and frequency
    double costPerDay = 0.0;
    
    switch (vapingHistory.deviceType) {
      case 'Disposable':
        // Assuming disposables cost around $10 and last 1-3 days depending on usage
        costPerDay = 10.0 * (vapingHistory.dailyFrequency / 20);
        break;
      case 'Pod System':
        // Assuming pods cost around $5 and e-liquid costs around $20 per week
        costPerDay = 5.0 / 3.0 + 20.0 / 7.0;
        break;
      case 'Mod':
        // Assuming coils cost around $3 each and last 1 week, and e-liquid costs around $20 per week
        costPerDay = 3.0 / 7.0 + 20.0 / 7.0;
        break;
      default:
        // Default calculation
        costPerDay = 5.0;
    }
    
    // Adjust based on frequency (higher usage = higher cost)
    costPerDay *= (vapingHistory.dailyFrequency / 10);
    
    // Ensure minimum daily cost
    return costPerDay < 1.0 ? 1.0 : costPerDay;
  }
  
  // Log out user (clear data)
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();
    
    await _storageService.clearAllData();
    _currentUser = null;
    _progress = null;
    
    _isLoading = false;
    notifyListeners();
  }
}