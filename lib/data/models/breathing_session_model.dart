import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'dart:convert';
import 'breathing_exercise_model.dart';

/// Model representing a completed breathing session
class BreathingSessionModel {
  /// Unique identifier
  final String id;
  
  /// ID of the exercise used
  final String exerciseId;
  
  /// Name of the exercise
  final String exerciseName;
  
  /// Breathing pattern used
  final BreathingPattern pattern;
  
  /// Duration in seconds
  final int durationSeconds;
  
  /// Number of completed cycles
  final int completedCycles;
  
  /// Timestamp when the session started
  final DateTime startTime;
  
  /// Timestamp when the session ended
  final DateTime endTime;
  
  /// User's mood improvement rating (1-5)
  final int? moodImprovement;
  
  /// User's notes about the session
  final String? notes;
  
  /// Timestamp of the session
  final DateTime timestamp;
  
  /// User's mood before the session (1-5)
  final int? moodBefore;
  
  /// User's mood after the session (1-5)
  final int? moodAfter;
  
  /// Whether the session was completed
  final bool completed;
  
  /// Creates a new breathing session model
  BreathingSessionModel({
    required this.id,
    required this.exerciseId,
    required this.exerciseName,
    required this.pattern,
    required this.durationSeconds,
    required this.completedCycles,
    required this.startTime,
    required this.endTime,
    this.moodImprovement,
    this.notes,
    DateTime? timestamp,
    this.moodBefore,
    this.moodAfter,
    this.completed = true,
  }) : timestamp = timestamp ?? DateTime.now();
  
  /// Creates a breathing session model from JSON
  factory BreathingSessionModel.fromJson(Map<String, dynamic> json) {
    return BreathingSessionModel(
      id: json['id'] as String,
      exerciseId: json['exerciseId'] as String,
      exerciseName: json['exerciseName'] as String,
      pattern: BreathingPattern.fromJson(json['pattern'] as Map<String, dynamic>),
      durationSeconds: json['durationSeconds'] as int,
      completedCycles: json['completedCycles'] as int,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      moodImprovement: json['moodImprovement'] as int?,
      notes: json['notes'] as String?,
      timestamp: json['timestamp'] != null ? DateTime.parse(json['timestamp'] as String) : null,
      moodBefore: json['moodBefore'] as int?,
      moodAfter: json['moodAfter'] as int?,
      completed: json['completed'] as bool? ?? true,
    );
  }
  
  /// Creates a breathing session model from a JSON string
  factory BreathingSessionModel.fromJsonString(String jsonString) {
    return BreathingSessionModel.fromJson(
      json.decode(jsonString) as Map<String, dynamic>,
    );
  }
  
  /// Creates a new breathing session with minimal parameters
  factory BreathingSessionModel.create({
    String? id,
    required String exerciseId,
    required String exerciseName,
    required BreathingPattern pattern,
    required int durationSeconds,
    int completedCycles = 0,
    DateTime? startTime,
    DateTime? endTime,
    int? moodImprovement,
    String? notes,
    DateTime? timestamp,
    int? moodBefore,
    int? moodAfter,
    bool completed = true,
  }) {
    final now = DateTime.now();
    final start = startTime ?? now.subtract(Duration(seconds: durationSeconds));
    final end = endTime ?? now;
    
    return BreathingSessionModel(
      id: id ?? now.millisecondsSinceEpoch.toString(),
      exerciseId: exerciseId,
      exerciseName: exerciseName,
      pattern: pattern,
      durationSeconds: durationSeconds,
      completedCycles: completedCycles,
      startTime: start,
      endTime: end,
      moodImprovement: moodImprovement,
      notes: notes,
      timestamp: timestamp ?? now,
      moodBefore: moodBefore,
      moodAfter: moodAfter,
      completed: completed,
    );
  }
  
  /// Creates a new breathing session from an exercise
  factory BreathingSessionModel.fromExercise({
    required BreathingExerciseModel exercise,
    required int durationSeconds,
    BreathingPattern? pattern,
    int completedCycles = 0,
    int? moodImprovement,
    String? notes,
    int? moodBefore,
    int? moodAfter,
    bool completed = true,
  }) {
    final now = DateTime.now();
    final start = now.subtract(Duration(seconds: durationSeconds));
    
    return BreathingSessionModel(
      id: now.millisecondsSinceEpoch.toString(),
      exerciseId: exercise.id,
      exerciseName: exercise.name,
      pattern: pattern ?? exercise.defaultPattern,
      durationSeconds: durationSeconds,
      completedCycles: completedCycles,
      startTime: start,
      endTime: now,
      moodImprovement: moodImprovement,
      notes: notes,
      timestamp: now,
      moodBefore: moodBefore,
      moodAfter: moodAfter,
      completed: completed,
    );
  }
  
  /// Converts the breathing session model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exerciseId': exerciseId,
      'exerciseName': exerciseName,
      'pattern': pattern.toJson(),
      'durationSeconds': durationSeconds,
      'completedCycles': completedCycles,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'moodImprovement': moodImprovement,
      'notes': notes,
      'timestamp': timestamp.toIso8601String(),
      'moodBefore': moodBefore,
      'moodAfter': moodAfter,
      'completed': completed,
    };
  }
  
  /// Converts the breathing session model to a JSON string
  String toJsonString() {
    return json.encode(toJson());
  }
  
  /// Creates a copy of this breathing session model with the given fields replaced
  BreathingSessionModel copyWith({
    String? id,
    String? exerciseId,
    String? exerciseName,
    BreathingPattern? pattern,
    int? durationSeconds,
    int? completedCycles,
    DateTime? startTime,
    DateTime? endTime,
    int? moodImprovement,
    String? notes,
    DateTime? timestamp,
    int? moodBefore,
    int? moodAfter,
    bool? completed,
  }) {
    return BreathingSessionModel(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      exerciseName: exerciseName ?? this.exerciseName,
      pattern: pattern ?? this.pattern,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      completedCycles: completedCycles ?? this.completedCycles,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      moodImprovement: moodImprovement ?? this.moodImprovement,
      notes: notes ?? this.notes,
      timestamp: timestamp ?? this.timestamp,
      moodBefore: moodBefore ?? this.moodBefore,
      moodAfter: moodAfter ?? this.moodAfter,
      completed: completed ?? this.completed,
    );
  }
  
  /// Gets the duration of the session
  Duration get duration {
    return endTime.difference(startTime);
  }
  
  /// Gets the average cycle duration in seconds
  double get averageCycleDuration {
    if (completedCycles == 0) return 0;
    return durationSeconds / completedCycles;
  }
  
  /// Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is BreathingSessionModel &&
        other.id == id &&
        other.exerciseId == exerciseId &&
        other.exerciseName == exerciseName &&
        other.pattern == pattern &&
        other.durationSeconds == durationSeconds &&
        other.completedCycles == completedCycles &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.moodImprovement == moodImprovement &&
        other.notes == notes &&
        other.timestamp == timestamp &&
        other.moodBefore == moodBefore &&
        other.moodAfter == moodAfter &&
        other.completed == completed;
  }
  
  /// Hash code
  @override
  int get hashCode {
    return id.hashCode ^
        exerciseId.hashCode ^
        exerciseName.hashCode ^
        pattern.hashCode ^
        durationSeconds.hashCode ^
        completedCycles.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        moodImprovement.hashCode ^
        notes.hashCode ^
        timestamp.hashCode ^
        moodBefore.hashCode ^
        moodAfter.hashCode ^
        completed.hashCode;
  }
}