import 'package:uuid/uuid.dart';

class CravingModel {
  final String id;
  final DateTime timestamp;
  final int intensity; // Make this non-nullable
  final String? trigger;
  final String? location;
  final String? activity;
  final String? emotion;
  final String? notes;
  final bool resolved;

  CravingModel({
    String? id,
    required this.timestamp,
    required this.intensity,
    this.trigger,
    this.location,
    this.activity,
    this.emotion,
    this.notes,
    this.resolved = false,
  }) : id = id ?? const Uuid().v4();

  factory CravingModel.fromJson(Map<String, dynamic> json) {
    return CravingModel(
      id: json['id'],
      timestamp: DateTime.parse(json['timestamp']),
      intensity: json['intensity'] ?? 0, // Provide default value
      trigger: json['trigger'],
      location: json['location'],
      activity: json['activity'],
      emotion: json['emotion'],
      notes: json['notes'],
      resolved: json['resolved'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'intensity': intensity,
      'trigger': trigger,
      'location': location,
      'activity': activity,
      'emotion': emotion,
      'notes': notes,
      'resolved': resolved,
    };
  }

  CravingModel copyWith({
    String? id,
    DateTime? timestamp,
    int? intensity,
    String? trigger,
    String? location,
    String? activity,
    String? emotion,
    String? notes,
    bool? resolved,
  }) {
    return CravingModel(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      intensity: intensity ?? this.intensity,
      trigger: trigger ?? this.trigger,
      location: location ?? this.location,
      activity: activity ?? this.activity,
      emotion: emotion ?? this.emotion,
      notes: notes ?? this.notes,
      resolved: resolved ?? this.resolved,
    );
  }
}
