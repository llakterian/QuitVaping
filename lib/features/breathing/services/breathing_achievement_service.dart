import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/breathing_session_model.dart';
import '../../../data/services/breathing_exercise_service.dart';
import '../models/breathing_achievement_model.dart';

/// Service for managing breathing exercise achievements
class BreathingAchievementService {
  static const String _prefsKeyAchievements = 'breathing_achievements';
  
  final SharedPreferences _prefs;
  final BreathingExerciseService _breathingService;
  
  /// Creates a new BreathingAchievementService
  BreathingAchievementService(this._prefs, this._breathingService);
  
  /// Gets all achievements with their current status
  Future<List<BreathingAchievementModel>> getAchievements() async {
    // Get saved achievements
    final savedAchievements = _getSavedAchievements();
    
    // Get all predefined achievements
    final allAchievements = _getPredefinedAchievements();
    
    // Update achievements with saved data
    final updatedAchievements = <BreathingAchievementModel>[];
    
    for (final achievement in allAchievements) {
      // Check if we have saved data for this achievement
      final savedAchievement = savedAchievements.firstWhere(
        (a) => a.id == achievement.id,
        orElse: () => achievement,
      );
      
      updatedAchievements.add(savedAchievement);
    }
    
    return updatedAchievements;
  }
  
  /// Gets unlocked achievements
  Future<List<BreathingAchievementModel>> getUnlockedAchievements() async {
    final achievements = await getAchievements();
    return achievements.where((a) => a.unlocked).toList();
  }
  
  /// Gets achievements in progress (some progress but not unlocked)
  Future<List<BreathingAchievementModel>> getInProgressAchievements() async {
    final achievements = await getAchievements();
    return achievements.where((a) => a.inProgress).toList();
  }
  
  /// Gets locked achievements (no progress)
  Future<List<BreathingAchievementModel>> getLockedAchievements() async {
    final achievements = await getAchievements();
    return achievements.where((a) => !a.unlocked && a.progress == 0).toList();
  }
  
  /// Updates achievements based on the latest session data
  Future<List<BreathingAchievementModel>> updateAchievements() async {
    // Get current achievements
    final achievements = await getAchievements();
    
    // Get statistics
    final stats = await _breathingService.getStatistics();
    
    // Get all sessions
    final sessions = await _breathingService.getSessionHistory();
    
    // Update each achievement
    final updatedAchievements = <BreathingAchievementModel>[];
    final newlyUnlocked = <BreathingAchievementModel>[];
    
    for (final achievement in achievements) {
      var updated = achievement;
      
      // Update progress based on achievement type
      switch (achievement.type) {
        case BreathingAchievementType.sessionCount:
          updated = _updateSessionCountAchievement(achievement, stats['totalSessions']);
          break;
        case BreathingAchievementType.totalMinutes:
          updated = _updateTotalMinutesAchievement(achievement, stats['totalMinutes']);
          break;
        case BreathingAchievementType.streak:
          updated = _updateStreakAchievement(
            achievement, 
            stats['currentStreak'], 
            stats['longestStreak'],
          );
          break;
        case BreathingAchievementType.exerciseVariety:
          updated = _updateExerciseVarietyAchievement(achievement, sessions);
          break;
        case BreathingAchievementType.moodImprovement:
          updated = _updateMoodImprovementAchievement(achievement, sessions);
          break;
      }
      
      // Check if newly unlocked
      if (updated.unlocked && !achievement.unlocked) {
        newlyUnlocked.add(updated);
      }
      
      updatedAchievements.add(updated);
    }
    
    // Save updated achievements
    await _saveAchievements(updatedAchievements);
    
    return newlyUnlocked;
  }
  
  /// Updates a session count achievement
  BreathingAchievementModel _updateSessionCountAchievement(
    BreathingAchievementModel achievement,
    int totalSessions,
  ) {
    // If already unlocked, no need to update
    if (achievement.unlocked) return achievement;
    
    final progress = totalSessions;
    final unlocked = progress >= achievement.milestone;
    
    return achievement.copyWith(
      progress: progress,
      unlocked: unlocked,
      unlockedAt: unlocked ? DateTime.now() : null,
    );
  }
  
  /// Updates a total minutes achievement
  BreathingAchievementModel _updateTotalMinutesAchievement(
    BreathingAchievementModel achievement,
    int totalMinutes,
  ) {
    // If already unlocked, no need to update
    if (achievement.unlocked) return achievement;
    
    final progress = totalMinutes;
    final unlocked = progress >= achievement.milestone;
    
    return achievement.copyWith(
      progress: progress,
      unlocked: unlocked,
      unlockedAt: unlocked ? DateTime.now() : null,
    );
  }
  
  /// Updates a streak achievement
  BreathingAchievementModel _updateStreakAchievement(
    BreathingAchievementModel achievement,
    int currentStreak,
    int longestStreak,
  ) {
    // If already unlocked, no need to update
    if (achievement.unlocked) return achievement;
    
    // Use the longest streak for progress
    final progress = longestStreak;
    final unlocked = progress >= achievement.milestone;
    
    return achievement.copyWith(
      progress: progress,
      unlocked: unlocked,
      unlockedAt: unlocked ? DateTime.now() : null,
    );
  }
  
  /// Updates an exercise variety achievement
  BreathingAchievementModel _updateExerciseVarietyAchievement(
    BreathingAchievementModel achievement,
    List<BreathingSessionModel> sessions,
  ) {
    // If already unlocked, no need to update
    if (achievement.unlocked) return achievement;
    
    // Count unique exercise IDs
    final uniqueExercises = sessions.map((s) => s.exerciseId).toSet();
    final progress = uniqueExercises.length;
    final unlocked = progress >= achievement.milestone;
    
    return achievement.copyWith(
      progress: progress,
      unlocked: unlocked,
      unlockedAt: unlocked ? DateTime.now() : null,
    );
  }
  
  /// Updates a mood improvement achievement
  BreathingAchievementModel _updateMoodImprovementAchievement(
    BreathingAchievementModel achievement,
    List<BreathingSessionModel> sessions,
  ) {
    // If already unlocked, no need to update
    if (achievement.unlocked) return achievement;
    
    // Count sessions with mood improvement
    final sessionsWithImprovement = sessions.where(
      (s) => s.moodBefore != null && 
             s.moodAfter != null && 
             s.moodAfter! > s.moodBefore!
    ).length;
    
    final progress = sessionsWithImprovement;
    final unlocked = progress >= achievement.milestone;
    
    return achievement.copyWith(
      progress: progress,
      unlocked: unlocked,
      unlockedAt: unlocked ? DateTime.now() : null,
    );
  }
  
  /// Gets saved achievements from preferences
  List<BreathingAchievementModel> _getSavedAchievements() {
    final savedJson = _prefs.getString(_prefsKeyAchievements);
    
    if (savedJson == null) {
      return [];
    }
    
    try {
      final List<dynamic> achievementsList = json.decode(savedJson);
      return achievementsList
          .map((json) => BreathingAchievementModel.fromJson(json))
          .toList();
    } catch (e) {
      return [];
    }
  }
  
  /// Saves achievements to preferences
  Future<void> _saveAchievements(List<BreathingAchievementModel> achievements) async {
    final achievementsJson = achievements.map((a) => a.toJson()).toList();
    await _prefs.setString(_prefsKeyAchievements, json.encode(achievementsJson));
  }
  
  /// Gets predefined achievements
  List<BreathingAchievementModel> _getPredefinedAchievements() {
    return [
      // Session count achievements
      BreathingAchievementModel(
        id: 'session_count_1',
        name: 'First Breath',
        description: 'Complete your first breathing exercise session',
        icon: Icons.play_circle_filled,
        badgeImagePath: 'assets/images/achievements/first_breath.png',
        unlocked: false,
        progress: 0,
        milestone: 1,
        type: BreathingAchievementType.sessionCount,
      ),
      BreathingAchievementModel(
        id: 'session_count_5',
        name: 'Getting Started',
        description: 'Complete 5 breathing exercise sessions',
        icon: Icons.trending_up,
        badgeImagePath: 'assets/images/achievements/getting_started.png',
        unlocked: false,
        progress: 0,
        milestone: 5,
        type: BreathingAchievementType.sessionCount,
      ),
      BreathingAchievementModel(
        id: 'session_count_20',
        name: 'Breathing Enthusiast',
        description: 'Complete 20 breathing exercise sessions',
        icon: Icons.favorite,
        badgeImagePath: 'assets/images/achievements/breathing_enthusiast.png',
        unlocked: false,
        progress: 0,
        milestone: 20,
        type: BreathingAchievementType.sessionCount,
      ),
      BreathingAchievementModel(
        id: 'session_count_50',
        name: 'Breathing Master',
        description: 'Complete 50 breathing exercise sessions',
        icon: Icons.star,
        badgeImagePath: 'assets/images/achievements/breathing_master.png',
        unlocked: false,
        progress: 0,
        milestone: 50,
        type: BreathingAchievementType.sessionCount,
      ),
      BreathingAchievementModel(
        id: 'session_count_100',
        name: 'Breathing Guru',
        description: 'Complete 100 breathing exercise sessions',
        icon: Icons.auto_awesome,
        badgeImagePath: 'assets/images/achievements/breathing_guru.png',
        unlocked: false,
        progress: 0,
        milestone: 100,
        type: BreathingAchievementType.sessionCount,
      ),
      
      // Total minutes achievements
      BreathingAchievementModel(
        id: 'total_minutes_30',
        name: 'Half Hour',
        description: 'Practice breathing exercises for a total of 30 minutes',
        icon: Icons.timer,
        badgeImagePath: 'assets/images/achievements/half_hour.png',
        unlocked: false,
        progress: 0,
        milestone: 30,
        type: BreathingAchievementType.totalMinutes,
      ),
      BreathingAchievementModel(
        id: 'total_minutes_60',
        name: 'Full Hour',
        description: 'Practice breathing exercises for a total of 60 minutes',
        icon: Icons.hourglass_full,
        badgeImagePath: 'assets/images/achievements/full_hour.png',
        unlocked: false,
        progress: 0,
        milestone: 60,
        type: BreathingAchievementType.totalMinutes,
      ),
      BreathingAchievementModel(
        id: 'total_minutes_180',
        name: 'Dedicated Practice',
        description: 'Practice breathing exercises for a total of 3 hours',
        icon: Icons.access_time_filled,
        badgeImagePath: 'assets/images/achievements/dedicated_practice.png',
        unlocked: false,
        progress: 0,
        milestone: 180,
        type: BreathingAchievementType.totalMinutes,
      ),
      
      // Streak achievements
      BreathingAchievementModel(
        id: 'streak_3',
        name: 'Three in a Row',
        description: 'Practice breathing exercises for 3 consecutive days',
        icon: Icons.local_fire_department,
        badgeImagePath: 'assets/images/achievements/three_in_a_row.png',
        unlocked: false,
        progress: 0,
        milestone: 3,
        type: BreathingAchievementType.streak,
      ),
      BreathingAchievementModel(
        id: 'streak_7',
        name: 'Week Warrior',
        description: 'Practice breathing exercises for 7 consecutive days',
        icon: Icons.whatshot,
        badgeImagePath: 'assets/images/achievements/week_warrior.png',
        unlocked: false,
        progress: 0,
        milestone: 7,
        type: BreathingAchievementType.streak,
      ),
      BreathingAchievementModel(
        id: 'streak_14',
        name: 'Fortnight Focus',
        description: 'Practice breathing exercises for 14 consecutive days',
        icon: Icons.bolt,
        badgeImagePath: 'assets/images/achievements/fortnight_focus.png',
        unlocked: false,
        progress: 0,
        milestone: 14,
        type: BreathingAchievementType.streak,
      ),
      BreathingAchievementModel(
        id: 'streak_30',
        name: 'Monthly Mastery',
        description: 'Practice breathing exercises for 30 consecutive days',
        icon: Icons.emoji_events,
        badgeImagePath: 'assets/images/achievements/monthly_mastery.png',
        unlocked: false,
        progress: 0,
        milestone: 30,
        type: BreathingAchievementType.streak,
      ),
      
      // Exercise variety achievements
      BreathingAchievementModel(
        id: 'variety_3',
        name: 'Breath Explorer',
        description: 'Try 3 different types of breathing exercises',
        icon: Icons.explore,
        badgeImagePath: 'assets/images/achievements/breath_explorer.png',
        unlocked: false,
        progress: 0,
        milestone: 3,
        type: BreathingAchievementType.exerciseVariety,
      ),
      BreathingAchievementModel(
        id: 'variety_6',
        name: 'Breath Connoisseur',
        description: 'Try 6 different types of breathing exercises',
        icon: Icons.diversity_3,
        badgeImagePath: 'assets/images/achievements/breath_connoisseur.png',
        unlocked: false,
        progress: 0,
        milestone: 6,
        type: BreathingAchievementType.exerciseVariety,
      ),
      
      // Mood improvement achievements
      BreathingAchievementModel(
        id: 'mood_1',
        name: 'Mood Lifter',
        description: 'Improve your mood with a breathing exercise',
        icon: Icons.mood,
        badgeImagePath: 'assets/images/achievements/mood_lifter.png',
        unlocked: false,
        progress: 0,
        milestone: 1,
        type: BreathingAchievementType.moodImprovement,
      ),
      BreathingAchievementModel(
        id: 'mood_5',
        name: 'Mood Booster',
        description: 'Improve your mood 5 times with breathing exercises',
        icon: Icons.sentiment_very_satisfied,
        badgeImagePath: 'assets/images/achievements/mood_booster.png',
        unlocked: false,
        progress: 0,
        milestone: 5,
        type: BreathingAchievementType.moodImprovement,
      ),
      BreathingAchievementModel(
        id: 'mood_20',
        name: 'Mood Master',
        description: 'Improve your mood 20 times with breathing exercises',
        icon: Icons.psychology,
        badgeImagePath: 'assets/images/achievements/mood_master.png',
        unlocked: false,
        progress: 0,
        milestone: 20,
        type: BreathingAchievementType.moodImprovement,
      ),
    ];
  }
  
  /// Resets all achievements (for testing)
  Future<void> resetAchievements() async {
    await _prefs.remove(_prefsKeyAchievements);
  }
}