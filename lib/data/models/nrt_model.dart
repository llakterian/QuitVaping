import 'package:uuid/uuid.dart';

class NRTModel {
  final String id;
  final DateTime timestamp;
  final String type;
  final double nicotineStrength;
  final String? notes;

  NRTModel({
    String? id,
    required this.timestamp,
    required this.type,
    required this.nicotineStrength,
    this.notes,
  }) : id = id ?? const Uuid().v4();

  factory NRTModel.fromJson(Map<String, dynamic> json) {
    return NRTModel(
      id: json['id'],
      timestamp: DateTime.parse(json['timestamp']),
      type: json['type'],
      nicotineStrength: (json['nicotineStrength'] ?? 0.0).toDouble(),
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

  NRTModel copyWith({
    String? id,
    DateTime? timestamp,
    String? type,
    double? nicotineStrength,
    String? notes,
  }) {
    return NRTModel(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      nicotineStrength: nicotineStrength ?? this.nicotineStrength,
      notes: notes ?? this.notes,
    );
  }
}

class NRTScheduleModel {
  final String id;
  final String name;
  final List<NRTScheduleItem> items;
  final bool isActive;

  NRTScheduleModel({
    String? id,
    required this.name,
    required this.items,
    this.isActive = false,
  }) : id = id ?? const Uuid().v4();

  factory NRTScheduleModel.fromJson(Map<String, dynamic> json) {
    return NRTScheduleModel(
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

  NRTScheduleModel copyWith({
    String? id,
    String? name,
    List<NRTScheduleItem>? items,
    bool? isActive,
  }) {
    return NRTScheduleModel(
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
      nicotineStrength: (json['nicotineStrength'] ?? 0.0).toDouble(),
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

enum NRTType {
  patch,
  gum,
  lozenge,
  inhaler,
  spray,
  other
}

class NRTStepModel {
  final String id;
  final int step;
  final String description;
  final double nicotineStrength;
  final int durationDays;
  final bool isCompleted;

  NRTStepModel({
    String? id,
    required this.step,
    required this.description,
    required this.nicotineStrength,
    required this.durationDays,
    this.isCompleted = false,
  }) : id = id ?? const Uuid().v4();

  factory NRTStepModel.fromJson(Map<String, dynamic> json) {
    return NRTStepModel(
      id: json['id'],
      step: json['step'],
      description: json['description'],
      nicotineStrength: (json['nicotineStrength'] ?? 0.0).toDouble(),
      durationDays: json['durationDays'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'step': step,
      'description': description,
      'nicotineStrength': nicotineStrength,
      'durationDays': durationDays,
      'isCompleted': isCompleted,
    };
  }

  NRTStepModel copyWith({
    String? id,
    int? step,
    String? description,
    double? nicotineStrength,
    int? durationDays,
    bool? isCompleted,
  }) {
    return NRTStepModel(
      id: id ?? this.id,
      step: step ?? this.step,
      description: description ?? this.description,
      nicotineStrength: nicotineStrength ?? this.nicotineStrength,
      durationDays: durationDays ?? this.durationDays,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
