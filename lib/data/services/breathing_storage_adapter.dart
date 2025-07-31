import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quit_vaping/data/models/breathing_session_model.dart';

/// Adapter for storing breathing session data in local storage
class BreathingStorageAdapter {
  static const String _sessionsBoxName = 'breathing_sessions';
  Box<Map>? _sessionsBox;
  
  /// Initialize the storage adapter
  Future<void> init() async {
    if (_sessionsBox != null) return;
    
    final appDir = await getApplicationDocumentsDirectory();
    Hive.init(appDir.path);
    
    if (!Hive.isBoxOpen(_sessionsBoxName)) {
      _sessionsBox = await Hive.openBox<Map>(_sessionsBoxName);
    } else {
      _sessionsBox = Hive.box<Map>(_sessionsBoxName);
    }
  }
  
  /// Save a breathing session
  Future<void> saveSession(BreathingSessionModel session) async {
    await init();
    
    // Convert the session to a map that can be stored in Hive
    final sessionMap = session.toJson();
    
    // Store the session using its ID as the key
    await _sessionsBox!.put(session.id, sessionMap);
  }
  
  /// Get all breathing sessions
  Future<List<BreathingSessionModel>> getAllSessions() async {
    await init();
    
    // Get all sessions
    final sessionMaps = _sessionsBox!.values.toList();
    
    // Convert maps to BreathingSessionModel objects
    return sessionMaps.map((sessionMap) {
      return BreathingSessionModel.fromJson(Map<String, dynamic>.from(sessionMap));
    }).toList();
  }
  
  /// Get sessions within a date range
  Future<List<BreathingSessionModel>> getSessionsByDateRange(
    DateTime? startDate,
    DateTime? endDate,
  ) async {
    final allSessions = await getAllSessions();
    
    // Filter by date range if provided
    if (startDate != null || endDate != null) {
      return allSessions.where((session) {
        final sessionDate = session.timestamp;
        
        if (startDate != null && endDate != null) {
          return sessionDate.isAfter(startDate) && 
                 sessionDate.isBefore(endDate.add(const Duration(days: 1)));
        } else if (startDate != null) {
          return sessionDate.isAfter(startDate);
        } else if (endDate != null) {
          return sessionDate.isBefore(endDate.add(const Duration(days: 1)));
        }
        
        return true;
      }).toList();
    }
    
    return allSessions;
  }
  
  /// Get sessions for a specific exercise
  Future<List<BreathingSessionModel>> getSessionsByExercise(String exerciseId) async {
    final allSessions = await getAllSessions();
    return allSessions.where((session) => session.exerciseId == exerciseId).toList();
  }
  
  /// Get a session by ID
  Future<BreathingSessionModel?> getSessionById(String sessionId) async {
    await init();
    
    final sessionMap = _sessionsBox!.get(sessionId);
    if (sessionMap == null) return null;
    
    return BreathingSessionModel.fromJson(Map<String, dynamic>.from(sessionMap));
  }
  
  /// Delete a session by ID
  Future<void> deleteSession(String sessionId) async {
    await init();
    await _sessionsBox!.delete(sessionId);
  }
  
  /// Delete all sessions
  Future<void> deleteAllSessions() async {
    await init();
    await _sessionsBox!.clear();
  }
  
  /// Get the count of sessions
  Future<int> getSessionCount() async {
    await init();
    return _sessionsBox!.length;
  }
  
  /// Get sessions grouped by date
  Future<Map<DateTime, List<BreathingSessionModel>>> getSessionsByDate() async {
    final allSessions = await getAllSessions();
    final sessionsByDate = <DateTime, List<BreathingSessionModel>>{};
    
    for (final session in allSessions) {
      final date = DateTime(
        session.timestamp.year,
        session.timestamp.month,
        session.timestamp.day,
      );
      
      if (!sessionsByDate.containsKey(date)) {
        sessionsByDate[date] = [];
      }
      
      sessionsByDate[date]!.add(session);
    }
    
    return sessionsByDate;
  }
  
  /// Get the total duration of all sessions in seconds
  Future<int> getTotalDuration() async {
    final allSessions = await getAllSessions();
    return allSessions.fold<int>(0, (sum, session) => sum + session.durationSeconds);
  }
  
  /// Get the average duration of sessions in seconds
  Future<double> getAverageDuration() async {
    final allSessions = await getAllSessions();
    if (allSessions.isEmpty) return 0;
    
    final totalDuration = allSessions.fold<int>(0, (sum, session) => sum + session.durationSeconds);
    return totalDuration / allSessions.length;
  }
  
  /// Get the completion rate (percentage of completed sessions)
  Future<double> getCompletionRate() async {
    final allSessions = await getAllSessions();
    if (allSessions.isEmpty) return 0;
    
    final completedSessions = allSessions.where((s) => s.completed).length;
    return completedSessions / allSessions.length;
  }
  
  /// Get the average mood improvement
  Future<double> getAverageMoodImprovement() async {
    final allSessions = await getAllSessions();
    final sessionsWithMood = allSessions.where(
      (s) => s.moodBefore != null && s.moodAfter != null
    ).toList();
    
    if (sessionsWithMood.isEmpty) return 0;
    
    final totalImprovement = sessionsWithMood.fold<int>(
      0, 
      (sum, s) => sum + (s.moodAfter! - s.moodBefore!)
    );
    
    return totalImprovement / sessionsWithMood.length;
  }
  
  /// Get the favorite exercise (most used)
  Future<String?> getFavoriteExercise() async {
    final allSessions = await getAllSessions();
    if (allSessions.isEmpty) return null;
    
    final exerciseCounts = <String, int>{};
    for (final session in allSessions) {
      exerciseCounts[session.exerciseId] = (exerciseCounts[session.exerciseId] ?? 0) + 1;
    }
    
    String? favoriteExerciseId;
    int maxCount = 0;
    exerciseCounts.forEach((id, count) {
      if (count > maxCount) {
        maxCount = count;
        favoriteExerciseId = id;
      }
    });
    
    if (favoriteExerciseId != null) {
      final favoriteSession = allSessions.firstWhere(
        (s) => s.exerciseId == favoriteExerciseId
      );
      return favoriteSession.exerciseName;
    }
    
    return null;
  }
  
  /// Calculate the current streak (consecutive days with sessions)
  Future<int> getCurrentStreak() async {
    final sessionsByDate = await getSessionsByDate();
    if (sessionsByDate.isEmpty) return 0;
    
    final dates = sessionsByDate.keys.toList();
    dates.sort((a, b) => b.compareTo(a)); // Sort newest first
    
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    
    if (dates.isEmpty || dates[0].difference(todayDate).inDays < -1) {
      return 0; // No sessions today or yesterday, streak is 0
    }
    
    int streak = 0;
    DateTime checkDate = todayDate;
    
    while (true) {
      if (sessionsByDate.containsKey(checkDate)) {
        streak++;
        checkDate = checkDate.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }
    
    return streak;
  }
  
  /// Calculate the longest streak (consecutive days with sessions)
  Future<int> getLongestStreak() async {
    final sessionsByDate = await getSessionsByDate();
    if (sessionsByDate.isEmpty) return 0;
    
    final dates = sessionsByDate.keys.toList();
    dates.sort((a, b) => a.compareTo(b)); // Sort oldest first
    
    int currentStreak = 1;
    int longestStreak = 1;
    
    for (int i = 1; i < dates.length; i++) {
      final diff = dates[i].difference(dates[i - 1]).inDays;
      
      if (diff == 1) {
        currentStreak++;
        if (currentStreak > longestStreak) {
          longestStreak = currentStreak;
        }
      } else if (diff > 1) {
        currentStreak = 1;
      }
    }
    
    return longestStreak;
  }
}