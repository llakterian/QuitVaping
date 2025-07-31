import 'package:flutter/material.dart';

/// Model representing a breathing exercise achievement
class BreathingAchievementModel {
  /// Unique identifier for the achievement
  final String id;
  
  /// Display name of the achievement
  final String name;
  
  /// Description of how to earn the achievement
  final String description;
  
  /// Icon to display for the achievement
  final IconData icon;
  
  /// Path to the badge image for the achievement
  final String badgeImagePath;
  
  /// Whether the achievement has been unlocked
  final bool unlocked;
  
  /// When the achievement was unlocked (null if not unlocked)
  final DateTime? unlockedAt;
  
  /// Progress towards the achievement (0-100)
  final int progress;
  
  /// The milestone value needed to unlock this achievement
  final int milestone;
  
  /// The type of achievement
  final BreathingAchievementType type;
  
  /// Creates a new BreathingAchievementModel
  const BreathingAchievementModel({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.badgeImagePath,
    required this.unlocked,
    this.unlockedAt,
    required this.progress,
    required this.milestone,
    required this.type,
  });
  
  /// Creates a copy of this BreathingAchievementModel with the given fields replaced
  BreathingAchievementModel copyWith({
    String? id,
    String? name,
    String? description,
    IconData? icon,
    String? badgeImagePath,
    bool? unlocked,
    DateTime? unlockedAt,
    int? progress,
    int? milestone,
    BreathingAchievementType? type,
  }) {
    return BreathingAchievementModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      badgeImagePath: badgeImagePath ?? this.badgeImagePath,
      unlocked: unlocked ?? this.unlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      progress: progress ?? this.progress,
      milestone: milestone ?? this.milestone,
      type: type ?? this.type,
    );
  }
  
  /// Creates a BreathingAchievementModel from JSON data
  factory BreathingAchievementModel.fromJson(Map<String, dynamic> json) {
    return BreathingAchievementModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      icon: _iconFromString(json['icon'] as String),
      badgeImagePath: json['badgeImagePath'] as String,
      unlocked: json['unlocked'] as bool,
      unlockedAt: json['unlockedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['unlockedAt'] as int)
          : null,
      progress: json['progress'] as int,
      milestone: json['milestone'] as int,
      type: BreathingAchievementType.values
          .firstWhere((e) => e.name == json['type']),
    );
  }
  
  /// Converts the BreathingAchievementModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': _iconToString(icon),
      'badgeImagePath': badgeImagePath,
      'unlocked': unlocked,
      'unlockedAt': unlockedAt?.millisecondsSinceEpoch,
      'progress': progress,
      'milestone': milestone,
      'type': type.name,
    };
  }
  
  /// Helper method to convert IconData to string
  static String _iconToString(IconData icon) {
    return '${icon.fontFamily}:${icon.codePoint}';
  }
  
  /// Helper method to convert string to IconData
  static IconData _iconFromString(String iconString) {
    final parts = iconString.split(':');
    return IconData(
      int.parse(parts[1]),
      fontFamily: parts[0],
    );
  }
  
  /// Returns the progress percentage (0-100)
  int get progressPercentage {
    if (milestone == 0) return 0;
    final percentage = (progress / milestone * 100).round();
    return percentage > 100 ? 100 : percentage;
  }
  
  /// Returns whether the achievement is in progress (some progress but not unlocked)
  bool get inProgress => !unlocked && progress > 0;
  
  /// Returns a formatted string for the milestone
  String get formattedMilestone {
    switch (type) {
      case BreathingAchievementType.sessionCount:
        return '$milestone sessions';
      case BreathingAchievementType.totalMinutes:
        return '$milestone minutes';
      case BreathingAchievementType.streak:
        return '$milestone day streak';
      case BreathingAchievementType.exerciseVariety:
        return '$milestone different exercises';
      case BreathingAchievementType.moodImprovement:
        return '$milestone mood improvements';
    }
  }
  
  /// Returns a formatted string for the current progress
  String get formattedProgress {
    switch (type) {
      case BreathingAchievementType.sessionCount:
        return '$progress sessions';
      case BreathingAchievementType.totalMinutes:
        return '$progress minutes';
      case BreathingAchievementType.streak:
        return '$progress days';
      case BreathingAchievementType.exerciseVariety:
        return '$progress exercises';
      case BreathingAchievementType.moodImprovement:
        return '$progress improvements';
    }
  }
}

/// Types of breathing achievements
enum BreathingAchievementType {
  /// Achievement for completing a certain number of sessions
  sessionCount,
  
  /// Achievement for practicing for a certain number of minutes
  totalMinutes,
  
  /// Achievement for maintaining a streak of consecutive days
  streak,
  
  /// Achievement for trying different types of exercises
  exerciseVariety,
  
  /// Achievement for improving mood through breathing
  moodImprovement,
}