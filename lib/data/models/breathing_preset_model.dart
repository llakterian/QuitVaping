import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'breathing_exercise_model.dart';

/// Model representing a saved breathing pattern preset
class BreathingPresetModel {
  /// Unique identifier
  final String id;
  
  /// Name of the preset
  final String name;
  
  /// ID of the exercise this preset is for
  final String exerciseId;
  
  /// Name of the exercise
  final String exerciseName;
  
  /// Breathing pattern
  final BreathingPattern pattern;
  
  /// User's notes about the preset
  final String? notes;
  
  /// Number of times this preset has been used
  final int useCount;
  
  /// Timestamp when this preset was last used
  final DateTime? lastUsedAt;
  
  /// Display order for sorting
  final int displayOrder;
  
  /// Duration in seconds
  final int durationSeconds;
  
  /// Creates a new breathing preset model
  const BreathingPresetModel({
    required this.id,
    required this.name,
    required this.exerciseId,
    this.exerciseName = '',
    required this.pattern,
    this.notes,
    this.useCount = 0,
    this.lastUsedAt,
    this.displayOrder = 0,
    this.durationSeconds = 0,
  });
  
  /// Creates a breathing preset model from JSON
  factory BreathingPresetModel.fromJson(Map<String, dynamic> json) {
    return BreathingPresetModel(
      id: json['id'] as String,
      name: json['name'] as String,
      exerciseId: json['exerciseId'] as String,
      exerciseName: json['exerciseName'] as String? ?? '',
      pattern: BreathingPattern.fromJson(json['pattern'] as Map<String, dynamic>),
      notes: json['notes'] as String?,
      useCount: json['useCount'] as int? ?? 0,
      lastUsedAt: json['lastUsedAt'] != null ? DateTime.parse(json['lastUsedAt'] as String) : null,
      displayOrder: json['displayOrder'] as int? ?? 0,
      durationSeconds: json['durationSeconds'] as int? ?? 0,
    );
  }
  
  /// Creates a breathing preset model from a JSON string
  factory BreathingPresetModel.fromJsonString(String jsonString) {
    return BreathingPresetModel.fromJson(
      json.decode(jsonString) as Map<String, dynamic>,
    );
  }
  
  /// Creates a new breathing preset with default values
  static BreathingPresetModel create({
    required String name,
    required String exerciseId,
    required String exerciseName,
    required BreathingPattern pattern,
    String? notes,
    int durationSeconds = 0,
  }) {
    return BreathingPresetModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      exerciseId: exerciseId,
      exerciseName: exerciseName,
      pattern: pattern,
      notes: notes,
      durationSeconds: durationSeconds,
    );
  }
  
  /// Converts the breathing preset model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'exerciseId': exerciseId,
      'exerciseName': exerciseName,
      'pattern': pattern.toJson(),
      'notes': notes,
      'useCount': useCount,
      'lastUsedAt': lastUsedAt?.toIso8601String(),
      'displayOrder': displayOrder,
      'durationSeconds': durationSeconds,
    };
  }
  
  /// Converts the breathing preset model to a JSON string
  String toJsonString() {
    return json.encode(toJson());
  }
  
  /// Creates a copy of this breathing preset model with the given fields replaced
  BreathingPresetModel copyWith({
    String? id,
    String? name,
    String? exerciseId,
    String? exerciseName,
    BreathingPattern? pattern,
    String? notes,
    int? useCount,
    DateTime? lastUsedAt,
    int? displayOrder,
    int? durationSeconds,
  }) {
    return BreathingPresetModel(
      id: id ?? this.id,
      name: name ?? this.name,
      exerciseId: exerciseId ?? this.exerciseId,
      exerciseName: exerciseName ?? this.exerciseName,
      pattern: pattern ?? this.pattern,
      notes: notes ?? this.notes,
      useCount: useCount ?? this.useCount,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      displayOrder: displayOrder ?? this.displayOrder,
      durationSeconds: durationSeconds ?? this.durationSeconds,
    );
  }
  
  /// Increments the use count and updates the last used timestamp
  BreathingPresetModel incrementUseCount() {
    return copyWith(
      useCount: useCount + 1,
      lastUsedAt: DateTime.now(),
    );
  }
  
  /// Gets a summary of the breathing pattern
  String get patternSummary {
    final parts = <String>[];
    
    parts.add('Inhale: ${pattern.inhaleSeconds}s');
    
    if (pattern.inhaleHoldSeconds > 0) {
      parts.add('Hold: ${pattern.inhaleHoldSeconds}s');
    }
    
    parts.add('Exhale: ${pattern.exhaleSeconds}s');
    
    if (pattern.exhaleHoldSeconds > 0) {
      parts.add('Hold: ${pattern.exhaleHoldSeconds}s');
    }
    
    return parts.join(' • ');
  }
  
  /// Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is BreathingPresetModel &&
        other.id == id &&
        other.name == name &&
        other.exerciseId == exerciseId &&
        other.exerciseName == exerciseName &&
        other.pattern == pattern &&
        other.notes == notes &&
        other.useCount == useCount &&
        other.lastUsedAt == lastUsedAt &&
        other.displayOrder == displayOrder &&
        other.durationSeconds == durationSeconds;
  }
  
  /// Hash code
  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        exerciseId.hashCode ^
        exerciseName.hashCode ^
        pattern.hashCode ^
        notes.hashCode ^
        useCount.hashCode ^
        lastUsedAt.hashCode ^
        displayOrder.hashCode ^
        durationSeconds.hashCode;
  }
}