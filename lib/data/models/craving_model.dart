import 'dart:convert';

/// Model representing a craving event
class CravingModel {
  /// Unique identifier
  final String id;
  
  /// Timestamp when the craving occurred
  final DateTime timestamp;
  
  /// Intensity of the craving (1-5)
  final int intensity;
  
  /// Category of the trigger (e.g., stress, social, etc.)
  final String? triggerCategory;
  
  /// Specific trigger description
  final String? triggerDescription;
  
  /// Whether the user gave in to the craving
  final bool gaveIn;
  
  /// Coping strategy used (if any)
  final String? copingStrategy;
  
  /// User's notes about the craving
  final String? notes;
  
  /// Location where the craving occurred
  final String? location;
  
  /// Specific trigger for the craving
  final String? specificTrigger;
  
  /// Whether the craving was resolved
  final bool resolved;
  
  /// Activity during the craving
  final String? activity;
  
  /// Emotion during the craving
  final String? emotion;
  
  /// Trigger for the craving (alias for specificTrigger)
  String? get trigger => specificTrigger;
  
  /// Creates a new craving model
  const CravingModel({
    required this.id,
    required this.timestamp,
    required this.intensity,
    this.triggerCategory,
    this.triggerDescription,
    required this.gaveIn,
    this.copingStrategy,
    this.notes,
    this.location,
    this.specificTrigger,
    this.resolved = false,
    this.activity,
    this.emotion,
  });
  
  /// Creates a craving model from JSON
  factory CravingModel.fromJson(Map<String, dynamic> json) {
    return CravingModel(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      intensity: json['intensity'] as int,
      triggerCategory: json['triggerCategory'] as String?,
      triggerDescription: json['triggerDescription'] as String?,
      gaveIn: json['gaveIn'] as bool,
      copingStrategy: json['copingStrategy'] as String?,
      notes: json['notes'] as String?,
      location: json['location'] as String?,
      specificTrigger: json['specificTrigger'] as String?,
      resolved: json['resolved'] as bool? ?? false,
      activity: json['activity'] as String?,
      emotion: json['emotion'] as String?,
    );
  }
  
  /// Creates a craving model from a JSON string
  factory CravingModel.fromJsonString(String jsonString) {
    return CravingModel.fromJson(
      json.decode(jsonString) as Map<String, dynamic>,
    );
  }
  
  /// Creates a default craving model
  factory CravingModel.create({
    String? id,
    DateTime? timestamp,
    int intensity = 3,
    String? triggerCategory,
    String? triggerDescription,
    bool gaveIn = false,
    String? copingStrategy,
    String? notes,
    String? location,
    String? specificTrigger,
    bool resolved = false,
    String? activity,
    String? emotion,
  }) {
    return CravingModel(
      id: id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      timestamp: timestamp ?? DateTime.now(),
      intensity: intensity,
      triggerCategory: triggerCategory,
      triggerDescription: triggerDescription,
      gaveIn: gaveIn,
      copingStrategy: copingStrategy,
      notes: notes,
      location: location,
      specificTrigger: specificTrigger,
      resolved: resolved,
      activity: activity,
      emotion: emotion,
    );
  }
  
  /// Converts the craving model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'intensity': intensity,
      'triggerCategory': triggerCategory,
      'triggerDescription': triggerDescription,
      'gaveIn': gaveIn,
      'copingStrategy': copingStrategy,
      'notes': notes,
      'location': location,
      'specificTrigger': specificTrigger,
      'resolved': resolved,
      'activity': activity,
      'emotion': emotion,
    };
  }
  
  /// Converts the craving model to a JSON string
  String toJsonString() {
    return json.encode(toJson());
  }
  
  /// Creates a copy of this craving model with the given fields replaced
  CravingModel copyWith({
    String? id,
    DateTime? timestamp,
    int? intensity,
    String? triggerCategory,
    String? triggerDescription,
    bool? gaveIn,
    String? copingStrategy,
    String? notes,
    String? location,
    String? specificTrigger,
    bool? resolved,
    String? activity,
    String? emotion,
  }) {
    return CravingModel(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      intensity: intensity ?? this.intensity,
      triggerCategory: triggerCategory ?? this.triggerCategory,
      triggerDescription: triggerDescription ?? this.triggerDescription,
      gaveIn: gaveIn ?? this.gaveIn,
      copingStrategy: copingStrategy ?? this.copingStrategy,
      notes: notes ?? this.notes,
      location: location ?? this.location,
      specificTrigger: specificTrigger ?? this.specificTrigger,
      resolved: resolved ?? this.resolved,
      activity: activity ?? this.activity,
      emotion: emotion ?? this.emotion,
    );
  }
  
  /// Gets the time of day when the craving occurred
  String get timeOfDay {
    final hour = timestamp.hour;
    if (hour >= 5 && hour < 12) {
      return 'Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Evening';
    } else {
      return 'Night';
    }
  }
  
  /// Gets the day of week when the craving occurred
  String get dayOfWeek {
    switch (timestamp.weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }
  
  /// Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is CravingModel &&
        other.id == id &&
        other.timestamp == timestamp &&
        other.intensity == intensity &&
        other.triggerCategory == triggerCategory &&
        other.triggerDescription == triggerDescription &&
        other.gaveIn == gaveIn &&
        other.copingStrategy == copingStrategy &&
        other.notes == notes &&
        other.location == location &&
        other.specificTrigger == specificTrigger &&
        other.resolved == resolved &&
        other.activity == activity &&
        other.emotion == emotion;
  }
  
  /// Hash code
  @override
  int get hashCode {
    return id.hashCode ^
        timestamp.hashCode ^
        intensity.hashCode ^
        triggerCategory.hashCode ^
        triggerDescription.hashCode ^
        gaveIn.hashCode ^
        copingStrategy.hashCode ^
        notes.hashCode ^
        location.hashCode ^
        specificTrigger.hashCode ^
        resolved.hashCode ^
        activity.hashCode ^
        emotion.hashCode;
  }
}
