import 'package:uuid/uuid.dart';

class CravingModel {
  final String id;
  final DateTime timestamp;
  final int intensity;
  final String? location;
  final String? activity;
  final String? emotion;
  final String? notes;
  final bool resolved;
  final String? triggerCategory;
  final String? specificTrigger;
  final String? copingStrategy;
  final String? timeOfDay;
  final int? duration;
  final List<CravingInsightModel>? aiInsights;

  CravingModel({
    String? id,
    required this.timestamp,
    required this.intensity,
    this.triggerCategory,
    this.specificTrigger,
    this.location,
    this.activity,
    this.emotion,
    this.timeOfDay,
    this.duration,
    this.copingStrategy,
    this.notes,
    this.resolved = false,
    this.aiInsights,
  }) : id = id ?? const Uuid().v4();

  factory CravingModel.fromJson(Map<String, dynamic> json) {
    return CravingModel(
      id: json['id'],
      timestamp: DateTime.parse(json['timestamp']),
      intensity: json['intensity'] ?? 0,
      triggerCategory: json['triggerCategory'],
      specificTrigger: json['specificTrigger'],
      location: json['location'],
      activity: json['activity'],
      emotion: json['emotion'],
      timeOfDay: json['timeOfDay'],
      duration: json['duration'],
      copingStrategy: json['copingStrategy'],
      notes: json['notes'],
      resolved: json['resolved'] ?? false,
      aiInsights: json['aiInsights'] != null
          ? (json['aiInsights'] as List)
              .map((i) => CravingInsightModel.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'intensity': intensity,
      'triggerCategory': triggerCategory,
      'specificTrigger': specificTrigger,
      'location': location,
      'activity': activity,
      'emotion': emotion,
      'timeOfDay': timeOfDay,
      'duration': duration,
      'copingStrategy': copingStrategy,
      'notes': notes,
      'resolved': resolved,
      'aiInsights': aiInsights?.map((i) => i.toJson()).toList(),
    };
  }

  CravingModel copyWith({
    String? id,
    DateTime? timestamp,
    int? intensity,
    String? triggerCategory,
    String? specificTrigger,
    String? location,
    String? activity,
    String? emotion,
    String? timeOfDay,
    int? duration,
    String? copingStrategy,
    String? notes,
    bool? resolved,
    List<CravingInsightModel>? aiInsights,
  }) {
    return CravingModel(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      intensity: intensity ?? this.intensity,
      triggerCategory: triggerCategory ?? this.triggerCategory,
      specificTrigger: specificTrigger ?? this.specificTrigger,
      location: location ?? this.location,
      activity: activity ?? this.activity,
      emotion: emotion ?? this.emotion,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      duration: duration ?? this.duration,
      copingStrategy: copingStrategy ?? this.copingStrategy,
      notes: notes ?? this.notes,
      resolved: resolved ?? this.resolved,
      aiInsights: aiInsights ?? this.aiInsights,
    );
  }
}

class CravingInsightModel {
  final String id;
  final DateTime timestamp;
  final Map<String, dynamic> insights;
  final List<String>? recommendedStrategies;

  CravingInsightModel({
    String? id,
    required this.timestamp,
    required this.insights,
    this.recommendedStrategies,
  }) : id = id ?? const Uuid().v4();

  factory CravingInsightModel.fromJson(Map<String, dynamic> json) {
    return CravingInsightModel(
      id: json['id'],
      timestamp: DateTime.parse(json['timestamp']),
      insights: Map<String, dynamic>.from(json['insights']),
      recommendedStrategies: json['recommendedStrategies'] != null
          ? List<String>.from(json['recommendedStrategies'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'insights': insights,
      'recommendedStrategies': recommendedStrategies,
    };
  }

  CravingInsightModel copyWith({
    String? id,
    DateTime? timestamp,
    Map<String, dynamic>? insights,
    List<String>? recommendedStrategies,
  }) {
    return CravingInsightModel(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      insights: insights ?? this.insights,
      recommendedStrategies: recommendedStrategies ?? this.recommendedStrategies,
    );
  }
}
