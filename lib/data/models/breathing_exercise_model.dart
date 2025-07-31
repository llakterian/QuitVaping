import 'package:flutter/foundation.dart';
import 'dart:convert';

/// Model representing a breathing pattern
class BreathingPattern {
  /// Duration of inhale phase in seconds
  final int inhaleSeconds;
  
  /// Duration of hold after inhale in seconds
  final int inhaleHoldSeconds;
  
  /// Duration of exhale phase in seconds
  final int exhaleSeconds;
  
  /// Duration of hold after exhale in seconds
  final int exhaleHoldSeconds;
  
  /// Minimum duration for any phase in seconds
  static const int minDuration = 2;
  
  /// Maximum duration for any phase in seconds
  static const int maxDuration = 10;
  
  /// Creates a new breathing pattern
  const BreathingPattern({
    required this.inhaleSeconds,
    this.inhaleHoldSeconds = 0,
    required this.exhaleSeconds,
    this.exhaleHoldSeconds = 0,
  });
  
  /// Creates a breathing pattern from JSON
  factory BreathingPattern.fromJson(Map<String, dynamic> json) {
    return BreathingPattern(
      inhaleSeconds: json['inhaleSeconds'] as int,
      inhaleHoldSeconds: json['inhaleHoldSeconds'] as int? ?? 0,
      exhaleSeconds: json['exhaleSeconds'] as int,
      exhaleHoldSeconds: json['exhaleHoldSeconds'] as int? ?? 0,
    );
  }
  
  /// Converts the breathing pattern to JSON
  Map<String, dynamic> toJson() {
    return {
      'inhaleSeconds': inhaleSeconds,
      'inhaleHoldSeconds': inhaleHoldSeconds,
      'exhaleSeconds': exhaleSeconds,
      'exhaleHoldSeconds': exhaleHoldSeconds,
    };
  }
  
  /// Creates a copy of this breathing pattern with the given fields replaced
  BreathingPattern copyWith({
    int? inhaleSeconds,
    int? inhaleHoldSeconds,
    int? exhaleSeconds,
    int? exhaleHoldSeconds,
  }) {
    return BreathingPattern(
      inhaleSeconds: inhaleSeconds ?? this.inhaleSeconds,
      inhaleHoldSeconds: inhaleHoldSeconds ?? this.inhaleHoldSeconds,
      exhaleSeconds: exhaleSeconds ?? this.exhaleSeconds,
      exhaleHoldSeconds: exhaleHoldSeconds ?? this.exhaleHoldSeconds,
    );
  }
  
  /// Gets the total duration of one breathing cycle in seconds
  int get totalCycleDuration {
    return inhaleSeconds + inhaleHoldSeconds + exhaleSeconds + exhaleHoldSeconds;
  }
  
  /// Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is BreathingPattern &&
        other.inhaleSeconds == inhaleSeconds &&
        other.inhaleHoldSeconds == inhaleHoldSeconds &&
        other.exhaleSeconds == exhaleSeconds &&
        other.exhaleHoldSeconds == exhaleHoldSeconds;
  }
  
  /// Hash code
  @override
  int get hashCode {
    return inhaleSeconds.hashCode ^
        inhaleHoldSeconds.hashCode ^
        exhaleSeconds.hashCode ^
        exhaleHoldSeconds.hashCode;
  }
  
  /// String representation
  @override
  String toString() {
    return 'BreathingPattern(inhale: $inhaleSeconds, inhaleHold: $inhaleHoldSeconds, exhale: $exhaleSeconds, exhaleHold: $exhaleHoldSeconds)';
  }
}

/// Model representing a breathing exercise
class BreathingExerciseModel {
  /// Unique identifier
  final String id;
  
  /// Name of the exercise
  final String name;
  
  /// Description of the exercise
  final String description;
  
  /// Default breathing pattern
  final BreathingPattern defaultPattern;
  
  /// Recommended duration in minutes
  final int recommendedDurationMinutes;
  
  /// Benefits of the exercise
  final List<String> benefits;
  
  /// Image asset path
  final String? imagePath;
  
  /// Whether this is a premium exercise
  final bool isPremium;
  
  /// Tags for categorizing exercises
  final List<String> tags;
  
  /// Detailed description of benefits
  final String benefitsDescription;
  
  /// Creates a new breathing exercise model
  const BreathingExerciseModel({
    required this.id,
    required this.name,
    required this.description,
    required this.defaultPattern,
    required this.recommendedDurationMinutes,
    required this.benefits,
    this.imagePath,
    this.isPremium = false,
    this.tags = const [],
    this.benefitsDescription = '',
  });
  
  /// Creates a breathing exercise model from JSON
  factory BreathingExerciseModel.fromJson(Map<String, dynamic> json) {
    return BreathingExerciseModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      defaultPattern: BreathingPattern.fromJson(json['defaultPattern'] as Map<String, dynamic>),
      recommendedDurationMinutes: json['recommendedDurationMinutes'] as int,
      benefits: List<String>.from(json['benefits'] as List),
      imagePath: json['imagePath'] as String?,
      isPremium: json['isPremium'] as bool? ?? false,
      tags: json['tags'] != null ? List<String>.from(json['tags'] as List) : const [],
      benefitsDescription: json['benefitsDescription'] as String? ?? '',
    );
  }
  
  /// Creates a breathing exercise model from a JSON string
  factory BreathingExerciseModel.fromJsonString(String jsonString) {
    return BreathingExerciseModel.fromJson(
      json.decode(jsonString) as Map<String, dynamic>,
    );
  }
  
  /// Converts the breathing exercise model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'defaultPattern': defaultPattern.toJson(),
      'recommendedDurationMinutes': recommendedDurationMinutes,
      'benefits': benefits,
      'imagePath': imagePath,
      'isPremium': isPremium,
      'tags': tags,
      'benefitsDescription': benefitsDescription,
    };
  }
  
  /// Converts the breathing exercise model to a JSON string
  String toJsonString() {
    return json.encode(toJson());
  }
  
  /// Creates a copy of this breathing exercise model with the given fields replaced
  BreathingExerciseModel copyWith({
    String? id,
    String? name,
    String? description,
    BreathingPattern? defaultPattern,
    int? recommendedDurationMinutes,
    List<String>? benefits,
    String? imagePath,
    bool? isPremium,
    List<String>? tags,
    String? benefitsDescription,
  }) {
    return BreathingExerciseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      defaultPattern: defaultPattern ?? this.defaultPattern,
      recommendedDurationMinutes: recommendedDurationMinutes ?? this.recommendedDurationMinutes,
      benefits: benefits ?? this.benefits,
      imagePath: imagePath ?? this.imagePath,
      isPremium: isPremium ?? this.isPremium,
      tags: tags ?? this.tags,
      benefitsDescription: benefitsDescription ?? this.benefitsDescription,
    );
  }
  
  /// Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is BreathingExerciseModel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.defaultPattern == defaultPattern &&
        other.recommendedDurationMinutes == recommendedDurationMinutes &&
        listEquals(other.benefits, benefits) &&
        other.imagePath == imagePath &&
        other.isPremium == isPremium &&
        listEquals(other.tags, tags) &&
        other.benefitsDescription == benefitsDescription;
  }
  
  /// Hash code
  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        defaultPattern.hashCode ^
        recommendedDurationMinutes.hashCode ^
        benefits.hashCode ^
        imagePath.hashCode ^
        isPremium.hashCode ^
        tags.hashCode ^
        benefitsDescription.hashCode;
  }
  
  /// Gets the recommended duration in seconds
  int get recommendedDuration => recommendedDurationMinutes * 60;
}