import 'package:uuid/uuid.dart';

class NRTRecord {
  final String id;
  final DateTime timestamp;
  final String type;
  final double nicotineStrength; // Make this non-nullable
  final String? notes;

  NRTRecord({
    String? id,
    required this.timestamp,
    required this.type,
    required this.nicotineStrength,
    this.notes,
  }) : id = id ?? const Uuid().v4();

  factory NRTRecord.fromJson(Map<String, dynamic> json) {
    return NRTRecord(
      id: json['id'],
      timestamp: DateTime.parse(json['timestamp']),
      type: json['type'],
      nicotineStrength: json['nicotineStrength'] ?? 0.0, // Provide default value
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'type': type,
      'nicotineStrength': nicotineStrength,
      'notes': notes,
    };
  }

  NRTRecord copyWith({
    String? id,
    DateTime? timestamp,
    String? type,
    double? nicotineStrength,
    String? notes,
  }) {
    return NRTRecord(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      nicotineStrength: nicotineStrength ?? this.nicotineStrength,
      notes: notes ?? this.notes,
    );
  }
}

class NRTSchedule {
  final String id;
  final String name;
  final List<NRTScheduleItem> items;
  final bool isActive;

  NRTSchedule({
    String? id,
    required this.name,
    required this.items,
    this.isActive = false,
  }) : id = id ?? const Uuid().v4();

  factory NRTSchedule.fromJson(Map<String, dynamic> json) {
    return NRTSchedule(
      id: json['id'],
      name: json['name'],
      items: (json['items'] as List)
          .map((item) => NRTScheduleItem.fromJson(item))
          .toList(),
      isActive: json['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'items': items.map((item) => item.toJson()).toList(),
      'isActive': isActive,
    };
  }

  NRTSchedule copyWith({
    String? id,
    String? name,
    List<NRTScheduleItem>? items,
    bool? isActive,
  }) {
    return NRTSchedule(
      id: id ?? this.id,
      name: name ?? this.name,
      items: items ?? this.items,
      isActive: isActive ?? this.isActive,
    );
  }
}

class NRTScheduleItem {
  final String id;
  final String type;
  final double nicotineStrength;
  final String timeOfDay;
  final bool isCompleted;

  NRTScheduleItem({
    String? id,
    required this.type,
    required this.nicotineStrength,
    required this.timeOfDay,
    this.isCompleted = false,
  }) : id = id ?? const Uuid().v4();

  factory NRTScheduleItem.fromJson(Map<String, dynamic> json) {
    return NRTScheduleItem(
      id: json['id'],
      type: json['type'],
      nicotineStrength: json['nicotineStrength'] ?? 0.0,
      timeOfDay: json['timeOfDay'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'nicotineStrength': nicotineStrength,
      'timeOfDay': timeOfDay,
      'isCompleted': isCompleted,
    };
  }

  NRTScheduleItem copyWith({
    String? id,
    String? type,
    double? nicotineStrength,
    String? timeOfDay,
    bool? isCompleted,
  }) {
    return NRTScheduleItem(
      id: id ?? this.id,
      type: type ?? this.type,
      nicotineStrength: nicotineStrength ?? this.nicotineStrength,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
