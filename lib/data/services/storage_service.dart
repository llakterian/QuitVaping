import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../models/user_model.dart';
import '../models/craving_model.dart';
import '../models/progress_model.dart';
import '../models/ai_model.dart';

class StorageService {
  static const String _userBoxName = 'user_box';
  static const String _cravingsBoxName = 'cravings_box';
  static const String _progressBoxName = 'progress_box';
  static const String _aiBoxName = 'ai_box';
  static const String _settingsBoxName = 'settings_box';
  
  static final Uuid _uuid = Uuid();
  
  // Initialize Hive storage
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_userBoxName);
    await Hive.openBox(_cravingsBoxName);
    await Hive.openBox(_progressBoxName);
    await Hive.openBox(_aiBoxName);
    await Hive.openBox(_settingsBoxName);
  }
  
  // User data operations
  Future<void> saveUserData(UserModel user) async {
    final box = Hive.box(_userBoxName);
    await box.put('user_profile', jsonEncode(user.toJson()));
  }
  
  UserModel? getUserData() {
    final box = Hive.box(_userBoxName);
    final userData = box.get('user_profile');
    if (userData == null) return null;
    
    try {
      return UserModel.fromJson(jsonDecode(userData));
    } catch (e) {
      debugPrint('Error parsing user data: $e');
      return null;
    }
  }
  
  Future<void> updateQuitDate(DateTime quitDate) async {
    final user = getUserData();
    if (user == null) return;
    
    final updatedUser = user.copyWith(
      quitDate: quitDate,
      updatedAt: DateTime.now(),
    );
    
    await saveUserData(updatedUser);
  }
  
  Future<void> saveOnboardingComplete(bool isComplete) async {
    final box = Hive.box(_settingsBoxName);
    await box.put('onboarding_complete', isComplete);
  }
  
  bool isOnboardingComplete() {
    final box = Hive.box(_settingsBoxName);
    return box.get('onboarding_complete', defaultValue: false);
  }
  
  // Craving data operations
  Future<String> saveCraving(CravingModel craving) async {
    final box = Hive.box(_cravingsBoxName);
    final id = craving.id.isEmpty ? _uuid.v4() : craving.id;
    final cravingWithId = craving.copyWith(id: id);
    
    final cravings = getCravings();
    cravings.add(cravingWithId);
    
    await box.put('cravings', jsonEncode(cravings.map((c) => c.toJson()).toList()));
    return id;
  }
  
  List<CravingModel> getCravings() {
    final box = Hive.box(_cravingsBoxName);
    final cravingsData = box.get('cravings');
    
    if (cravingsData == null) return [];
    
    try {
      final List<dynamic> decodedData = jsonDecode(cravingsData);
      return decodedData
          .map((data) => CravingModel.fromJson(data))
          .toList();
    } catch (e) {
      debugPrint('Error parsing cravings data: $e');
      return [];
    }
  }
  
  Future<void> updateCraving(CravingModel craving) async {
    final box = Hive.box(_cravingsBoxName);
    final cravings = getCravings();
    
    final index = cravings.indexWhere((c) => c.id == craving.id);
    if (index != -1) {
      cravings[index] = craving;
      await box.put('cravings', jsonEncode(cravings.map((c) => c.toJson()).toList()));
    }
  }
  
  Future<void> deleteCraving(String id) async {
    final box = Hive.box(_cravingsBoxName);
    final cravings = getCravings();
    
    cravings.removeWhere((c) => c.id == id);
    await box.put('cravings', jsonEncode(cravings.map((c) => c.toJson()).toList()));
  }
  
  // Progress tracking operations
  Future<void> saveProgress(ProgressModel progress) async {
    final box = Hive.box(_progressBoxName);
    await box.put('progress', jsonEncode(progress.toJson()));
  }
  
  ProgressModel? getProgress() {
    final box = Hive.box(_progressBoxName);
    final progressData = box.get('progress');
    if (progressData == null) return null;
    
    try {
      return ProgressModel.fromJson(jsonDecode(progressData));
    } catch (e) {
      debugPrint('Error parsing progress data: $e');
      return null;
    }
  }
  
  Future<void> addRelapse(DateTime date) async {
    final progress = getProgress();
    if (progress == null) return;
    
    final relapses = progress.relapses ?? [];
    relapses.add(date);
    
    final updatedProgress = progress.copyWith(
      relapses: relapses,
      currentStreak: 0, // Reset current streak
    );
    
    await saveProgress(updatedProgress);
  }
  
  Future<void> addAchievement(AchievementModel achievement) async {
    final progress = getProgress();
    if (progress == null) return;
    
    final achievements = List<AchievementModel>.from(progress.achievements);
    achievements.add(achievement);
    
    final updatedProgress = progress.copyWith(achievements: achievements);
    await saveProgress(updatedProgress);
  }
  
  // AI data operations
  Future<void> saveChatMessages(List<AIChatMessage> messages) async {
    final box = Hive.box(_aiBoxName);
    await box.put('chat_messages', jsonEncode(messages.map((m) => m.toJson()).toList()));
  }
  
  List<AIChatMessage> getChatMessages() {
    final box = Hive.box(_aiBoxName);
    final messagesData = box.get('chat_messages');
    
    if (messagesData == null) return [];
    
    try {
      final List<dynamic> decodedData = jsonDecode(messagesData);
      return decodedData
          .map((data) => AIChatMessage.fromJson(data))
          .toList();
    } catch (e) {
      debugPrint('Error parsing chat messages: $e');
      return [];
    }
  }
  
  Future<void> saveAIRecommendation(AIRecommendation recommendation) async {
    final box = Hive.box(_aiBoxName);
    final recommendations = getAIRecommendations();
    recommendations.add(recommendation);
    
    await box.put('recommendations', jsonEncode(recommendations.map((r) => r.toJson()).toList()));
  }
  
  List<AIRecommendation> getAIRecommendations() {
    final box = Hive.box(_aiBoxName);
    final recommendationsData = box.get('recommendations');
    
    if (recommendationsData == null) return [];
    
    try {
      final List<dynamic> decodedData = jsonDecode(recommendationsData);
      return decodedData
          .map((data) => AIRecommendation.fromJson(data))
          .toList();
    } catch (e) {
      debugPrint('Error parsing AI recommendations: $e');
      return [];
    }
  }
  
  Future<void> savePatternAnalysis(AIPatternAnalysis analysis) async {
    final box = Hive.box(_aiBoxName);
    await box.put('pattern_analysis', jsonEncode(analysis.toJson()));
  }
  
  AIPatternAnalysis? getPatternAnalysis() {
    final box = Hive.box(_aiBoxName);
    final analysisData = box.get('pattern_analysis');
    if (analysisData == null) return null;
    
    try {
      return AIPatternAnalysis.fromJson(jsonDecode(analysisData));
    } catch (e) {
      debugPrint('Error parsing pattern analysis: $e');
      return null;
    }
  }
  
  // Settings operations
  Future<void> saveSetting(String key, dynamic value) async {
    final box = Hive.box(_settingsBoxName);
    await box.put(key, value);
  }
  
  dynamic getSetting(String key, {dynamic defaultValue}) {
    final box = Hive.box(_settingsBoxName);
    return box.get(key, defaultValue: defaultValue);
  }
  
  // Clear all data (for logout or reset)
  Future<void> clearAllData() async {
    await Hive.box(_userBoxName).clear();
    await Hive.box(_cravingsBoxName).clear();
    await Hive.box(_progressBoxName).clear();
    await Hive.box(_aiBoxName).clear();
    // Don't clear settings as they may be needed across sessions
  }
}