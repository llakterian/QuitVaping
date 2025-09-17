import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/mcp_model.dart';
import '../models/user_model.dart';
import '../models/motivation_model.dart';
import 'mcp_manager_service.dart';
import 'storage_service.dart';

/// AI-powered motivation system using Postman AI Agent Builder
/// Provides personalized motivational content, mood analysis, and milestone celebrations
class MotivationService extends ChangeNotifier {
  final MCPManagerService _mcpManager;
  final StorageService _storageService;


  // State management
  List<MotivationalContent> _motivationalContent = [];
  MoodState _currentMood = MoodState.neutral;
  List<UserActivity> _recentActivity = [];
  UserLearningProfile _learningProfile = const UserLearningProfile();
  bool _isGeneratingContent = false;
  String? _lastError;

  // Timers for periodic updates
  Timer? _moodAnalysisTimer;
  Timer? _contentRefreshTimer;
  Timer? _milestoneCheckTimer;

  // Stream controllers for real-time updates
  final StreamController<MotivationalContent> _contentController = 
      StreamController<MotivationalContent>.broadcast();
  final StreamController<MoodState> _moodController = 
      StreamController<MoodState>.broadcast();
  final StreamController<MilestoneEvent> _milestoneController = 
      StreamController<MilestoneEvent>.broadcast();

  MotivationService(this._mcpManager, this._storageService);

  // Getters
  List<MotivationalContent> get motivationalContent => _motivationalContent;
  MoodState get currentMood => _currentMood;
  List<UserActivity> get recentActivity => _recentActivity;
  UserLearningProfile get learningProfile => _learningProfile;
  bool get isGeneratingContent => _isGeneratingContent;
  String? get lastError => _lastError;

  // Streams
  Stream<MotivationalContent> get contentStream => _contentController.stream;
  Stream<MoodState> get moodStream => _moodController.stream;
  Stream<MilestoneEvent> get milestoneStream => _milestoneController.stream;

  /// Initialize the motivation system
  Future<void> initialize() async {
    try {
      // Load cached data
      await _loadCachedData();
      
      // Start periodic updates
      _startPeriodicUpdates();
      
      // Listen to MCP manager streams
      _setupMCPListeners();
      
      // Generate initial content
      await _generateInitialContent();
      
      debugPrint('MotivationService initialized successfully');
    } catch (e) {
      _lastError = 'Failed to initialize motivation system: $e';
      debugPrint(_lastError);
    }
  }

  /// Load cached data from storage
  Future<void> _loadCachedData() async {
    try {
      // Load learning profile
      final profileData = _storageService.getSetting('learning_profile');
      if (profileData != null) {
        _learningProfile = UserLearningProfile.fromJson(jsonDecode(profileData));
      }

      // Load recent activity
      final activityData = _storageService.getSetting('recent_activity');
      if (activityData != null) {
        final List<dynamic> activities = jsonDecode(activityData);
        _recentActivity = activities
            .map((a) => UserActivity.fromJson(a))
            .toList();
      }

      // Load cached motivational content
      final contentData = _storageService.getSetting('motivational_content');
      if (contentData != null) {
        final List<dynamic> content = jsonDecode(contentData);
        _motivationalContent = content
            .map((c) => MotivationalContent.fromJson(c))
            .toList();
      }
    } catch (e) {
      debugPrint('Error loading cached data: $e');
    }
  }

  /// Setup MCP manager listeners
  void _setupMCPListeners() {
    _mcpManager.motivationStream.listen((response) {
      _handleMotivationResponse(response);
    });
  }

  /// Start periodic updates
  void _startPeriodicUpdates() {
    // Mood analysis every 30 minutes
    _moodAnalysisTimer = Timer.periodic(const Duration(minutes: 30), (_) {
      _analyzeMoodFromActivity();
    });

    // Content refresh every 2 hours
    _contentRefreshTimer = Timer.periodic(const Duration(hours: 2), (_) {
      _refreshMotivationalContent();
    });

    // Milestone check every hour
    _milestoneCheckTimer = Timer.periodic(const Duration(hours: 1), (_) {
      _checkForMilestones();
    });
  }

  /// Generate initial motivational content
  Future<void> _generateInitialContent() async {
    final user = _storageService.getUserData();
    if (user == null) return;

    await generatePersonalizedContent(user);
  }

  /// Generate personalized motivational content
  Future<void> generatePersonalizedContent(UserModel user) async {
    if (_isGeneratingContent) return;

    _isGeneratingContent = true;
    _lastError = null;
    notifyListeners();

    try {
      final context = await _buildAIWorkflowContext(user);
      final response = await _mcpManager.generateMotivationContent(context);
      
      if (response.error == null) {
        await _processMotivationResponse(response);
      } else {
        _lastError = response.error;
      }
    } catch (e) {
      _lastError = 'Failed to generate content: $e';
      debugPrint(_lastError);
    } finally {
      _isGeneratingContent = false;
      notifyListeners();
    }
  }

  /// Build AI workflow context
  Future<AIWorkflowContext> _buildAIWorkflowContext(UserModel user) async {
    // Get external factors
    final externalFactors = await _getExternalFactors();
    
    // Get available interventions based on user preferences
    final availableInterventions = _getAvailableInterventions(user);

    return AIWorkflowContext(
      userId: user.id,
      currentMood: _currentMood,
      recentActivity: _recentActivity,
      externalFactors: externalFactors,
      availableInterventions: availableInterventions,
      learningData: _learningProfile,
    );
  }

  /// Get external factors (weather, time, etc.)
  Future<ExternalFactors> _getExternalFactors() async {
    try {
      // Get weather data if location is available
      String? weather;
      final location = _storageService.getSetting('user_location');
      if (location != null) {
        final weatherResponse = await _mcpManager.getWeatherData(location);
        if (weatherResponse.error == null) {
          weather = weatherResponse.data['weather']?.toString();
        }
      }

      return ExternalFactors(
        weather: weather,
        location: location,
        timeOfDay: _getTimeOfDay(),
        additionalFactors: {
          'dayOfWeek': DateTime.now().weekday,
          'isWeekend': DateTime.now().weekday >= 6,
        },
      );
    } catch (e) {
      debugPrint('Error getting external factors: $e');
      return ExternalFactors(
        timeOfDay: _getTimeOfDay(),
        additionalFactors: {
          'dayOfWeek': DateTime.now().weekday,
          'isWeekend': DateTime.now().weekday >= 6,
        },
      );
    }
  }

  /// Get available interventions based on user preferences
  List<InterventionType> _getAvailableInterventions(UserModel user) {
    final preferences = user.preferences;
    final List<InterventionType> interventions = [];

    // Default interventions
    interventions.addAll([
      InterventionType.breathing,
      InterventionType.motivation,
      InterventionType.distraction,
    ]);

    // Add community if user opted in
    if (preferences['community_support'] == true) {
      interventions.add(InterventionType.community);
    }

    // Add NRT if user is using it
    if (preferences['using_nrt'] == true) {
      interventions.add(InterventionType.nrt);
    }

    return interventions;
  }

  /// Process motivation response from MCP
  Future<void> _processMotivationResponse(MCPResponse response) async {
    try {
      final data = response.data;
      
      // Extract motivational content
      if (data['content'] != null) {
        final content = MotivationalContent.fromJson(data['content']);
        _motivationalContent.insert(0, content);
        
        // Keep only recent content (last 20 items)
        if (_motivationalContent.length > 20) {
          _motivationalContent = _motivationalContent.take(20).toList();
        }
        
        _contentController.add(content);
        await _cacheMotivationalContent();
      }

      // Update learning profile if provided
      if (data['learning_update'] != null) {
        _updateLearningProfile(data['learning_update']);
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Error processing motivation response: $e');
    }
  }

  /// Handle motivation response from MCP stream
  void _handleMotivationResponse(MCPResponse response) {
    if (response.responseType == MCPResponseType.motivation) {
      _processMotivationResponse(response);
    }
  }

  /// Analyze mood from recent activity
  Future<void> _analyzeMoodFromActivity() async {
    try {
      final user = _storageService.getUserData();
      if (user == null) return;

      // Get recent cravings to analyze mood
      final cravings = _storageService.getCravings()
          .where((c) => DateTime.now().difference(c.timestamp).inHours < 24)
          .toList();

      MoodState newMood = MoodState.neutral;

      if (cravings.isNotEmpty) {
        final avgIntensity = cravings
            .map((c) => c.intensity)
            .reduce((a, b) => a + b) / cravings.length;

        if (avgIntensity >= 8) {
          newMood = MoodState.struggling;
        } else if (avgIntensity >= 6) {
          newMood = MoodState.anxious;
        } else if (avgIntensity <= 3) {
          newMood = MoodState.positive;
        }
      } else {
        // No recent cravings - positive mood
        newMood = MoodState.motivated;
      }

      if (newMood != _currentMood) {
        _currentMood = newMood;
        _moodController.add(_currentMood);
        
        // Generate mood-appropriate content
        await generatePersonalizedContent(user);
        
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error analyzing mood: $e');
    }
  }

  /// Refresh motivational content
  Future<void> _refreshMotivationalContent() async {
    final user = _storageService.getUserData();
    if (user != null) {
      await generatePersonalizedContent(user);
    }
  }

  /// Check for milestones and celebrate
  Future<void> _checkForMilestones() async {
    try {
      final user = _storageService.getUserData();
      final progress = _storageService.getProgress();
      
      if (user == null || progress == null || user.quitDate == null) return;

      final hoursSinceQuitting = DateTime.now().difference(user.quitDate!).inHours;

      // Check for milestone achievements
      final milestones = _getMilestoneDefinitions();
      
      for (final milestone in milestones) {
        final key = milestone['key'] as String;
        final hours = milestone['hours'] as int;
        
        if (hoursSinceQuitting >= hours && 
            !progress.achievedMilestones.containsKey(key)) {
          
          // Mark milestone as achieved
          final updatedMilestones = Map<String, bool>.from(progress.achievedMilestones);
          updatedMilestones[key] = true;
          
          final updatedProgress = progress.copyWith(
            achievedMilestones: updatedMilestones,
          );
          
          await _storageService.saveProgress(updatedProgress);
          
          // Generate celebration message
          await _celebrateMilestone(user.id, milestone);
        }
      }
    } catch (e) {
      debugPrint('Error checking milestones: $e');
    }
  }

  /// Generate celebration message for milestone
  Future<void> _celebrateMilestone(String userId, Map<String, dynamic> milestone) async {
    try {
      final response = await _mcpManager.generateCelebrationMessage(
        userId, 
        milestone['description'] as String,
      );
      
      if (response.error == null && response.data['celebration'] != null) {
        final celebration = MilestoneEvent.fromJson({
          ...response.data['celebration'],
          'milestone': milestone,
          'timestamp': DateTime.now().toIso8601String(),
        });
        
        _milestoneController.add(celebration);
      }
    } catch (e) {
      debugPrint('Error generating celebration: $e');
    }
  }

  /// Get milestone definitions
  List<Map<String, dynamic>> _getMilestoneDefinitions() {
    return [
      {'key': '20_minutes', 'hours': 0, 'description': '20 minutes smoke-free'},
      {'key': '8_hours', 'hours': 8, 'description': '8 hours smoke-free'},
      {'key': '24_hours', 'hours': 24, 'description': '1 day smoke-free'},
      {'key': '48_hours', 'hours': 48, 'description': '2 days smoke-free'},
      {'key': '72_hours', 'hours': 72, 'description': '3 days smoke-free'},
      {'key': '1_week', 'hours': 168, 'description': '1 week smoke-free'},
      {'key': '2_weeks', 'hours': 336, 'description': '2 weeks smoke-free'},
      {'key': '1_month', 'hours': 720, 'description': '1 month smoke-free'},
      {'key': '3_months', 'hours': 2160, 'description': '3 months smoke-free'},
      {'key': '6_months', 'hours': 4320, 'description': '6 months smoke-free'},
      {'key': '1_year', 'hours': 8760, 'description': '1 year smoke-free'},
    ];
  }

  /// Update learning profile based on user interactions
  void _updateLearningProfile(Map<String, dynamic> update) {
    try {
      final effectiveness = Map<String, double>.from(_learningProfile.interventionEffectiveness);
      final preferences = Map<String, int>.from(_learningProfile.preferredInterventions);
      final personalizedData = Map<String, dynamic>.from(_learningProfile.personalizedData);

      // Update intervention effectiveness
      if (update['effectiveness'] != null) {
        final effectivenessUpdate = Map<String, double>.from(update['effectiveness']);
        effectiveness.addAll(effectivenessUpdate);
      }

      // Update preferences
      if (update['preferences'] != null) {
        final preferencesUpdate = Map<String, int>.from(update['preferences']);
        preferences.addAll(preferencesUpdate);
      }

      // Update personalized data
      if (update['personalized_data'] != null) {
        personalizedData.addAll(update['personalized_data']);
      }

      _learningProfile = UserLearningProfile(
        interventionEffectiveness: effectiveness,
        preferredInterventions: preferences,
        personalizedData: personalizedData,
      );

      _cacheLearningProfile();
    } catch (e) {
      debugPrint('Error updating learning profile: $e');
    }
  }

  /// Record user activity for mood analysis
  void recordActivity(String activityType, Map<String, dynamic> data) {
    final activity = UserActivity(
      activityType: activityType,
      timestamp: DateTime.now(),
      data: data,
    );

    _recentActivity.insert(0, activity);
    
    // Keep only recent activity (last 50 items)
    if (_recentActivity.length > 50) {
      _recentActivity = _recentActivity.take(50).toList();
    }

    _cacheRecentActivity();
    
    // Trigger mood analysis if significant activity
    if (['craving_logged', 'relapse', 'milestone_reached'].contains(activityType)) {
      _analyzeMoodFromActivity();
    }
  }

  /// Get time of day string
  String _getTimeOfDay() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) return 'morning';
    if (hour >= 12 && hour < 17) return 'afternoon';
    if (hour >= 17 && hour < 21) return 'evening';
    return 'night';
  }

  /// Cache methods
  Future<void> _cacheLearningProfile() async {
    await _storageService.saveSetting(
      'learning_profile', 
      jsonEncode(_learningProfile.toJson()),
    );
  }

  Future<void> _cacheRecentActivity() async {
    await _storageService.saveSetting(
      'recent_activity',
      jsonEncode(_recentActivity.map((a) => a.toJson()).toList()),
    );
  }

  Future<void> _cacheMotivationalContent() async {
    await _storageService.saveSetting(
      'motivational_content',
      jsonEncode(_motivationalContent.map((c) => c.toJson()).toList()),
    );
  }

  /// Dispose resources
  @override
  void dispose() {
    _moodAnalysisTimer?.cancel();
    _contentRefreshTimer?.cancel();
    _milestoneCheckTimer?.cancel();
    
    _contentController.close();
    _moodController.close();
    _milestoneController.close();
    
    super.dispose();
  }
}

