import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quit_vaping/data/services/notification_service.dart';
import 'package:quit_vaping/data/services/breathing_exercise_service.dart';
import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'package:quit_vaping/data/models/breathing_session_model.dart';

/// Service for managing breathing exercise notifications
class BreathingNotificationService {
  static const String _prefsKeyPrefix = 'breathing_notification_';
  static const String _prefsRemindersEnabled = '${_prefsKeyPrefix}reminders_enabled';
  static const String _prefsReminderTime = '${_prefsKeyPrefix}reminder_time';
  static const String _prefsLastNotificationDate = '${_prefsKeyPrefix}last_notification_date';
  
  // Notification IDs
  static const int _dailyReminderNotificationId = 1001;
  static const int _inactivityReminderNotificationId = 1002;
  static const int _stressReliefSuggestionNotificationId = 1003;
  static const int _achievementMilestoneNotificationId = 1004;
  
  final NotificationService _notificationService;
  final BreathingExerciseService _breathingService;
  final SharedPreferences _prefs;
  
  /// Creates a new BreathingNotificationService
  BreathingNotificationService(
    this._notificationService,
    this._breathingService,
    this._prefs,
  ) {
    // Register for session recorded callbacks
    BreathingExerciseService.addSessionRecordedCallback(_onSessionRecorded);
  }
  
  /// Initializes the notification service
  Future<void> initialize() async {
    // Schedule daily reminder if enabled
    if (isRemindersEnabled()) {
      await scheduleDailyReminder();
    }
  }
  
  /// Checks if breathing reminders are enabled
  bool isRemindersEnabled() {
    return _prefs.getBool(_prefsRemindersEnabled) ?? true;
  }
  
  /// Sets whether breathing reminders are enabled
  Future<void> setRemindersEnabled(bool enabled) async {
    await _prefs.setBool(_prefsRemindersEnabled, enabled);
    
    if (enabled) {
      await scheduleDailyReminder();
    } else {
      await _notificationService.cancelNotification(_dailyReminderNotificationId);
      await _notificationService.cancelNotification(_inactivityReminderNotificationId);
      await _notificationService.cancelNotification(_stressReliefSuggestionNotificationId);
    }
  }
  
  /// Gets the daily reminder time
  TimeOfDay getReminderTime() {
    final timeString = _prefs.getString(_prefsReminderTime);
    
    if (timeString != null) {
      final parts = timeString.split(':');
      return TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
    }
    
    // Default to 8:00 PM
    return const TimeOfDay(hour: 20, minute: 0);
  }
  
  /// Sets the daily reminder time
  Future<void> setReminderTime(TimeOfDay time) async {
    await _prefs.setString(_prefsReminderTime, '${time.hour}:${time.minute}');
    
    if (isRemindersEnabled()) {
      await scheduleDailyReminder();
    }
  }
  
  /// Schedules the daily breathing reminder
  Future<void> scheduleDailyReminder() async {
    // Cancel any existing reminder
    await _notificationService.cancelNotification(_dailyReminderNotificationId);
    
    // Get the reminder time
    final reminderTime = getReminderTime();
    
    // Get a personalized exercise recommendation
    final recommendedExercise = await _getPersonalizedExerciseRecommendation();
    
    // Create the notification content
    String title = 'Time for a breathing exercise';
    String body = 'Take a moment to breathe and reduce stress';
    
    if (recommendedExercise != null) {
      title = 'Try ${recommendedExercise.name} breathing';
      body = recommendedExercise.benefitsDescription;
    }
    
    // Schedule the notification
    await _notificationService.scheduleDailyNotification(
      id: _dailyReminderNotificationId,
      title: title,
      body: body,
      time: reminderTime,
      payload: recommendedExercise?.id,
    );
  }
  
  /// Schedules an inactivity reminder if the user hasn't done a breathing exercise in a while
  Future<void> scheduleInactivityReminder() async {
    // Only schedule if reminders are enabled
    if (!isRemindersEnabled()) return;
    
    // Get the last session date
    final sessions = await _breathingService.getSessionHistory();
    
    if (sessions.isEmpty) {
      // If no sessions, schedule a reminder for tomorrow
      await _scheduleInactivityNotification(
        title: 'Start your breathing practice',
        body: 'Regular breathing exercises can help manage cravings and reduce stress.',
      );
      return;
    }
    
    // Sort sessions by timestamp (newest first)
    sessions.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    
    final lastSession = sessions.first;
    final daysSinceLastSession = DateTime.now().difference(lastSession.timestamp).inDays;
    
    // If it's been more than 3 days, schedule a reminder
    if (daysSinceLastSession >= 3) {
      final stats = await _breathingService.getStatistics();
      
      String title = 'Resume your breathing practice';
      String body = 'It\'s been $daysSinceLastSession days since your last breathing exercise.';
      
      if (stats['totalSessions'] > 0) {
        body += ' You\'ve completed ${stats['totalSessions']} sessions so far.';
      }
      
      await _scheduleInactivityNotification(title: title, body: body);
    }
  }
  
  /// Schedules a notification for inactivity
  Future<void> _scheduleInactivityNotification({
    required String title,
    required String body,
  }) async {
    // Cancel any existing inactivity reminder
    await _notificationService.cancelNotification(_inactivityReminderNotificationId);
    
    // Schedule for tomorrow at a random time between 10 AM and 6 PM
    final random = Random();
    final hour = 10 + random.nextInt(8); // 10 AM to 6 PM
    final minute = random.nextInt(60);
    
    final now = DateTime.now();
    final scheduledDate = DateTime(
      now.year,
      now.month,
      now.day + 1, // Tomorrow
      hour,
      minute,
    );
    
    // Get a recommended exercise
    final recommendedExercise = await _getPersonalizedExerciseRecommendation();
    
    await _notificationService.scheduleNotification(
      id: _inactivityReminderNotificationId,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      payload: recommendedExercise?.id,
    );
  }
  
  /// Schedules a stress relief suggestion notification
  Future<void> scheduleStressReliefSuggestion() async {
    // Only schedule if reminders are enabled
    if (!isRemindersEnabled()) return;
    
    // Check if we've already sent a notification today
    final lastNotificationDateStr = _prefs.getString(_prefsLastNotificationDate);
    if (lastNotificationDateStr != null) {
      final lastNotificationDate = DateTime.parse(lastNotificationDateStr);
      final today = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      );
      
      if (lastNotificationDate.isAtSameMomentAs(today)) {
        // Already sent a notification today
        return;
      }
    }
    
    // Get a stress-relief focused exercise
    final exercises = await _breathingService.getExercises();
    final stressExercises = exercises.where((e) => e.tags.contains('stress')).toList();
    
    if (stressExercises.isEmpty) return;
    
    // Pick a random stress exercise
    final random = Random();
    final exercise = stressExercises[random.nextInt(stressExercises.length)];
    
    // Schedule for a random time in the next 2 hours
    final now = DateTime.now();
    final minutesToAdd = 15 + random.nextInt(105); // Between 15 minutes and 2 hours
    final scheduledDate = now.add(Duration(minutes: minutesToAdd));
    
    await _notificationService.scheduleNotification(
      id: _stressReliefSuggestionNotificationId,
      title: 'Feeling stressed?',
      body: 'Try ${exercise.name} breathing to help reduce stress and stay on track.',
      scheduledDate: scheduledDate,
      payload: exercise.id,
    );
    
    // Save the notification date
    await _prefs.setString(
      _prefsLastNotificationDate,
      DateTime(now.year, now.month, now.day).toIso8601String(),
    );
  }
  
  /// Schedules a notification for achievement milestones
  Future<void> scheduleAchievementMilestone(int sessionsToNextMilestone) async {
    // Only schedule if reminders are enabled
    if (!isRemindersEnabled()) return;
    
    // Only schedule if we're close to a milestone (1-2 sessions away)
    if (sessionsToNextMilestone <= 0 || sessionsToNextMilestone > 2) return;
    
    // Cancel any existing milestone reminder
    await _notificationService.cancelNotification(_achievementMilestoneNotificationId);
    
    // Schedule for tomorrow at a random time between 9 AM and 8 PM
    final random = Random();
    final hour = 9 + random.nextInt(11); // 9 AM to 8 PM
    final minute = random.nextInt(60);
    
    final now = DateTime.now();
    final scheduledDate = DateTime(
      now.year,
      now.month,
      now.day + 1, // Tomorrow
      hour,
      minute,
    );
    
    String title = 'Achievement within reach!';
    String body = sessionsToNextMilestone == 1
        ? 'Just 1 more breathing session to unlock your next achievement!'
        : 'Only $sessionsToNextMilestone more breathing sessions to unlock your next achievement!';
    
    await _notificationService.scheduleNotification(
      id: _achievementMilestoneNotificationId,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
    );
  }
  
  /// Gets a personalized exercise recommendation based on user history
  Future<BreathingExerciseModel?> _getPersonalizedExerciseRecommendation() async {
    final exercises = await _breathingService.getExercises();
    if (exercises.isEmpty) return null;
    
    // Try to get the last used exercise
    final lastUsedExercise = await _breathingService.getLastUsedExercise();
    
    // Get all sessions
    final sessions = await _breathingService.getSessionHistory();
    
    // If no sessions, recommend a beginner exercise
    if (sessions.isEmpty) {
      final beginnerExercises = exercises.where((e) => e.tags.contains('beginner')).toList();
      if (beginnerExercises.isNotEmpty) {
        return beginnerExercises[Random().nextInt(beginnerExercises.length)];
      }
      return exercises[Random().nextInt(exercises.length)];
    }
    
    // Count exercise usage
    final exerciseCounts = <String, int>{};
    for (final session in sessions) {
      exerciseCounts[session.exerciseId] = (exerciseCounts[session.exerciseId] ?? 0) + 1;
    }
    
    // If the user has a clear favorite, suggest something different occasionally
    if (exerciseCounts.isNotEmpty) {
      final favoriteExerciseId = exerciseCounts.entries
          .reduce((a, b) => a.value > b.value ? a : b)
          .key;
      
      // 70% chance to recommend something different than the favorite
      if (Random().nextDouble() < 0.7) {
        final otherExercises = exercises.where((e) => e.id != favoriteExerciseId).toList();
        if (otherExercises.isNotEmpty) {
          return otherExercises[Random().nextInt(otherExercises.length)];
        }
      }
    }
    
    // If we have a last used exercise, 50% chance to recommend it again
    if (lastUsedExercise != null && Random().nextBool()) {
      return lastUsedExercise;
    }
    
    // Otherwise, pick a random exercise
    return exercises[Random().nextInt(exercises.length)];
  }
  
  /// Called when a breathing session is recorded
  void _onSessionRecorded(BreathingSessionModel session) {
    // Schedule the next daily reminder
    scheduleDailyReminder();
    
    // Cancel any inactivity reminders
    _notificationService.cancelNotification(_inactivityReminderNotificationId);
  }
  
  /// Disposes the service
  void dispose() {
    BreathingExerciseService.removeSessionRecordedCallback(_onSessionRecorded);
  }
}