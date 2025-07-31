import 'dart:convert';
import 'nrt_type.dart';

/// Model representing an NRT product
class NRTProductModel {
  /// Unique identifier
  final String id;
  
  /// Name of the product
  final String name;
  
  /// Type of NRT
  final NRTType type;
  
  /// Strength of the product (e.g., "21mg", "4mg")
  final String strength;
  
  /// Brand of the product
  final String? brand;
  
  /// Cost of the product
  final double? cost;
  
  /// User's notes about the product
  final String? notes;
  
  /// Creates a new NRT product model
  const NRTProductModel({
    required this.id,
    required this.name,
    required this.type,
    required this.strength,
    this.brand,
    this.cost,
    this.notes,
  });
  
  /// Creates an NRT product model from JSON
  factory NRTProductModel.fromJson(Map<String, dynamic> json) {
    return NRTProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: NRTTypeExtension.fromString(json['type'] as String),
      strength: json['strength'] as String,
      brand: json['brand'] as String?,
      cost: json['cost'] != null ? (json['cost'] as num).toDouble() : null,
      notes: json['notes'] as String?,
    );
  }
  
  /// Creates an NRT product model from a JSON string
  factory NRTProductModel.fromJsonString(String jsonString) {
    return NRTProductModel.fromJson(
      json.decode(jsonString) as Map<String, dynamic>,
    );
  }
  
  /// Converts the NRT product model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type.toStorageString(),
      'strength': strength,
      'brand': brand,
      'cost': cost,
      'notes': notes,
    };
  }
  
  /// Converts the NRT product model to a JSON string
  String toJsonString() {
    return json.encode(toJson());
  }
  
  /// Creates a copy of this NRT product model with the given fields replaced
  NRTProductModel copyWith({
    String? id,
    String? name,
    NRTType? type,
    String? strength,
    String? brand,
    double? cost,
    String? notes,
  }) {
    return NRTProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      strength: strength ?? this.strength,
      brand: brand ?? this.brand,
      cost: cost ?? this.cost,
      notes: notes ?? this.notes,
    );
  }
  
  /// Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is NRTProductModel &&
        other.id == id &&
        other.name == name &&
        other.type == type &&
        other.strength == strength &&
        other.brand == brand &&
        other.cost == cost &&
        other.notes == notes;
  }
  
  /// Hash code
  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        type.hashCode ^
        strength.hashCode ^
        brand.hashCode ^
        cost.hashCode ^
        notes.hashCode;
  }
}

/// Model representing an NRT usage event
class NRTUsageModel {
  /// Unique identifier
  final String id;
  
  /// ID of the product used
  final String productId;
  
  /// Timestamp when the NRT was used
  final DateTime timestamp;
  
  /// Dosage used (e.g., "1 patch", "2 pieces")
  final String dosage;
  
  /// Whether the usage was effective
  final bool? wasEffective;
  
  /// User's notes about the usage
  final String? notes;
  
  /// Creates a new NRT usage model
  const NRTUsageModel({
    required this.id,
    required this.productId,
    required this.timestamp,
    required this.dosage,
    this.wasEffective,
    this.notes,
  });
  
  /// Creates an NRT usage model from JSON
  factory NRTUsageModel.fromJson(Map<String, dynamic> json) {
    return NRTUsageModel(
      id: json['id'] as String,
      productId: json['productId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      dosage: json['dosage'] as String,
      wasEffective: json['wasEffective'] as bool?,
      notes: json['notes'] as String?,
    );
  }
  
  /// Creates an NRT usage model from a JSON string
  factory NRTUsageModel.fromJsonString(String jsonString) {
    return NRTUsageModel.fromJson(
      json.decode(jsonString) as Map<String, dynamic>,
    );
  }
  
  /// Converts the NRT usage model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'timestamp': timestamp.toIso8601String(),
      'dosage': dosage,
      'wasEffective': wasEffective,
      'notes': notes,
    };
  }
  
  /// Converts the NRT usage model to a JSON string
  String toJsonString() {
    return json.encode(toJson());
  }
  
  /// Creates a copy of this NRT usage model with the given fields replaced
  NRTUsageModel copyWith({
    String? id,
    String? productId,
    DateTime? timestamp,
    String? dosage,
    bool? wasEffective,
    String? notes,
  }) {
    return NRTUsageModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      timestamp: timestamp ?? this.timestamp,
      dosage: dosage ?? this.dosage,
      wasEffective: wasEffective ?? this.wasEffective,
      notes: notes ?? this.notes,
    );
  }
  
  /// Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is NRTUsageModel &&
        other.id == id &&
        other.productId == productId &&
        other.timestamp == timestamp &&
        other.dosage == dosage &&
        other.wasEffective == wasEffective &&
        other.notes == notes;
  }
  
  /// Hash code
  @override
  int get hashCode {
    return id.hashCode ^
        productId.hashCode ^
        timestamp.hashCode ^
        dosage.hashCode ^
        wasEffective.hashCode ^
        notes.hashCode;
  }
}

/// Model representing an NRT schedule
class NRTScheduleModel {
  /// Unique identifier
  final String id;
  
  /// ID of the product to use
  final String productId;
  
  /// Name of the schedule
  final String name;
  
  /// Start date of the schedule
  final DateTime startDate;
  
  /// End date of the schedule (if applicable)
  final DateTime? endDate;
  
  /// Frequency of usage (e.g., "daily", "twice daily")
  final String frequency;
  
  /// Dosage to use (e.g., "1 patch", "2 pieces")
  final String dosage;
  
  /// Time of day to use the NRT (e.g., "morning", "evening")
  final List<String> timeOfDay;
  
  /// User's notes about the schedule
  final String? notes;
  
  /// Type of NRT
  final String type;
  
  /// Whether the schedule is active
  final bool isActive;
  
  /// Schedule items
  final List<NRTScheduleItem> items;
  
  /// Initial nicotine strength in mg
  final double? initialStrength;
  
  /// Current nicotine strength in mg
  final double? currentStrength;
  
  /// Frequency per day
  final int? frequencyPerDay;
  
  /// Reduction steps
  final List<NRTStepModel>? reductionSteps;
  
  /// Creates a new NRT schedule model
  const NRTScheduleModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.startDate,
    this.endDate,
    required this.frequency,
    required this.dosage,
    required this.timeOfDay,
    this.notes,
    required this.type,
    this.isActive = true,
    this.items = const [],
    this.initialStrength,
    this.currentStrength,
    this.frequencyPerDay,
    this.reductionSteps,
  });
  
  /// Creates an NRT schedule model from JSON
  factory NRTScheduleModel.fromJson(Map<String, dynamic> json) {
    return NRTScheduleModel(
      id: json['id'] as String,
      productId: json['productId'] as String,
      name: json['name'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate'] as String) : null,
      frequency: json['frequency'] as String,
      dosage: json['dosage'] as String,
      timeOfDay: List<String>.from(json['timeOfDay'] as List),
      notes: json['notes'] as String?,
      type: json['type'] as String? ?? 'patch',
      isActive: json['isActive'] as bool? ?? true,
      items: json['items'] != null 
          ? List<NRTScheduleItem>.from(
              (json['items'] as List).map((item) => NRTScheduleItem.fromJson(item as Map<String, dynamic>))
            )
          : const [],
      initialStrength: json['initialStrength'] != null ? (json['initialStrength'] as num).toDouble() : null,
      currentStrength: json['currentStrength'] != null ? (json['currentStrength'] as num).toDouble() : null,
      frequencyPerDay: json['frequencyPerDay'] as int?,
      reductionSteps: json['reductionSteps'] != null
          ? List<NRTStepModel>.from(
              (json['reductionSteps'] as List).map((step) => NRTStepModel.fromJson(step as Map<String, dynamic>))
            )
          : null,
    );
  }
  
  /// Creates an NRT schedule model from a JSON string
  factory NRTScheduleModel.fromJsonString(String jsonString) {
    return NRTScheduleModel.fromJson(
      json.decode(jsonString) as Map<String, dynamic>,
    );
  }
  
  /// Converts the NRT schedule model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'name': name,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'frequency': frequency,
      'dosage': dosage,
      'timeOfDay': timeOfDay,
      'notes': notes,
      'type': type,
      'isActive': isActive,
      'items': items.map((item) => item.toJson()).toList(),
      'initialStrength': initialStrength,
      'currentStrength': currentStrength,
      'frequencyPerDay': frequencyPerDay,
      'reductionSteps': reductionSteps?.map((step) => step.toJson()).toList(),
    };
  }
  
  /// Converts the NRT schedule model to a JSON string
  String toJsonString() {
    return json.encode(toJson());
  }
  
  /// Creates a copy of this NRT schedule model with the given fields replaced
  NRTScheduleModel copyWith({
    String? id,
    String? productId,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    String? frequency,
    String? dosage,
    List<String>? timeOfDay,
    String? notes,
    String? type,
    bool? isActive,
    List<NRTScheduleItem>? items,
    double? initialStrength,
    double? currentStrength,
    int? frequencyPerDay,
    List<NRTStepModel>? reductionSteps,
  }) {
    return NRTScheduleModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      frequency: frequency ?? this.frequency,
      dosage: dosage ?? this.dosage,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      notes: notes ?? this.notes,
      type: type ?? this.type,
      isActive: isActive ?? this.isActive,
      items: items ?? this.items,
      initialStrength: initialStrength ?? this.initialStrength,
      currentStrength: currentStrength ?? this.currentStrength,
      frequencyPerDay: frequencyPerDay ?? this.frequencyPerDay,
      reductionSteps: reductionSteps ?? this.reductionSteps,
    );
  }
  
  /// Checks if the schedule is active on the given date
  bool isActiveOn(DateTime date) {
    final startComparison = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
    ).compareTo(DateTime(
      date.year,
      date.month,
      date.day,
    ));
    
    if (startComparison > 0) {
      return false; // Date is before start date
    }
    
    if (endDate != null) {
      final endComparison = DateTime(
        endDate!.year,
        endDate!.month,
        endDate!.day,
      ).compareTo(DateTime(
        date.year,
        date.month,
        date.day,
      ));
      
      if (endComparison < 0) {
        return false; // Date is after end date
      }
    }
    
    return true;
  }
  
  /// Gets the duration of the schedule in days
  int get durationDays {
    if (endDate == null) {
      return 0; // Ongoing schedule
    }
    
    return endDate!.difference(startDate).inDays + 1;
  }
  
  /// Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is NRTScheduleModel &&
        other.id == id &&
        other.productId == productId &&
        other.name == name &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.frequency == frequency &&
        other.dosage == dosage &&
        other.notes == notes;
  }
  
  /// Hash code
  @override
  int get hashCode {
    return id.hashCode ^
        productId.hashCode ^
        name.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        frequency.hashCode ^
        dosage.hashCode ^
        notes.hashCode;
  }
}

/// Model representing an NRT record
class NRTModel {
  /// Unique identifier
  final String id;
  
  /// Type of NRT
  final NRTType type;
  
  /// Name of the product
  final String name;
  
  /// Strength of the product (e.g., "21mg", "4mg")
  final String strength;
  
  /// Nicotine strength in mg
  final double nicotineStrength;
  
  /// Timestamp when the NRT was used
  final DateTime timestamp;
  
  /// Dosage used (e.g., "1 patch", "2 pieces")
  final String dosage;
  
  /// Whether the usage was effective
  final bool? wasEffective;
  
  /// User's notes about the usage
  final String? notes;
  
  /// Creates a new NRT model
  const NRTModel({
    required this.id,
    required this.type,
    required this.name,
    required this.strength,
    required this.nicotineStrength,
    required this.timestamp,
    required this.dosage,
    this.wasEffective,
    this.notes,
  });
  
  /// Creates an NRT model from JSON
  factory NRTModel.fromJson(Map<String, dynamic> json) {
    return NRTModel(
      id: json['id'] as String,
      type: NRTTypeExtension.fromString(json['type'] as String),
      name: json['name'] as String,
      strength: json['strength'] as String,
      nicotineStrength: (json['nicotineStrength'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      dosage: json['dosage'] as String,
      wasEffective: json['wasEffective'] as bool?,
      notes: json['notes'] as String?,
    );
  }
  
  /// Creates an NRT model from a JSON string
  factory NRTModel.fromJsonString(String jsonString) {
    return NRTModel.fromJson(
      json.decode(jsonString) as Map<String, dynamic>,
    );
  }
  
  /// Converts the NRT model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toStorageString(),
      'name': name,
      'strength': strength,
      'nicotineStrength': nicotineStrength,
      'timestamp': timestamp.toIso8601String(),
      'dosage': dosage,
      'wasEffective': wasEffective,
      'notes': notes,
    };
  }
  
  /// Converts the NRT model to a JSON string
  String toJsonString() {
    return json.encode(toJson());
  }
  
  /// Creates a copy of this NRT model with the given fields replaced
  NRTModel copyWith({
    String? id,
    NRTType? type,
    String? name,
    String? strength,
    double? nicotineStrength,
    DateTime? timestamp,
    String? dosage,
    bool? wasEffective,
    String? notes,
  }) {
    return NRTModel(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      strength: strength ?? this.strength,
      nicotineStrength: nicotineStrength ?? this.nicotineStrength,
      timestamp: timestamp ?? this.timestamp,
      dosage: dosage ?? this.dosage,
      wasEffective: wasEffective ?? this.wasEffective,
      notes: notes ?? this.notes,
    );
  }
  
  /// Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is NRTModel &&
        other.id == id &&
        other.type == type &&
        other.name == name &&
        other.strength == strength &&
        other.nicotineStrength == nicotineStrength &&
        other.timestamp == timestamp &&
        other.dosage == dosage &&
        other.wasEffective == wasEffective &&
        other.notes == notes;
  }
  
  /// Hash code
  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        name.hashCode ^
        strength.hashCode ^
        nicotineStrength.hashCode ^
        timestamp.hashCode ^
        dosage.hashCode ^
        wasEffective.hashCode ^
        notes.hashCode;
  }
}

/// Model representing an NRT schedule step
class NRTStepModel {
  /// Unique identifier
  final String id;
  
  /// Step number
  final int stepNumber;
  
  /// Duration in days
  final int durationDays;
  
  /// Nicotine strength in mg
  final double nicotineStrength;
  
  /// Dosage instructions
  final String dosage;
  
  /// Creates a new NRT step model
  const NRTStepModel({
    required this.id,
    required this.stepNumber,
    required this.durationDays,
    required this.nicotineStrength,
    required this.dosage,
  });
  
  /// Creates an NRT step model from JSON
  factory NRTStepModel.fromJson(Map<String, dynamic> json) {
    return NRTStepModel(
      id: json['id'] as String,
      stepNumber: json['stepNumber'] as int,
      durationDays: json['durationDays'] as int,
      nicotineStrength: (json['nicotineStrength'] as num).toDouble(),
      dosage: json['dosage'] as String,
    );
  }
  
  /// Converts the NRT step model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stepNumber': stepNumber,
      'durationDays': durationDays,
      'nicotineStrength': nicotineStrength,
      'dosage': dosage,
    };
  }
  
  /// Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is NRTStepModel &&
        other.id == id &&
        other.stepNumber == stepNumber &&
        other.durationDays == durationDays &&
        other.nicotineStrength == nicotineStrength &&
        other.dosage == dosage;
  }
  
  /// Hash code
  @override
  int get hashCode {
    return id.hashCode ^
        stepNumber.hashCode ^
        durationDays.hashCode ^
        nicotineStrength.hashCode ^
        dosage.hashCode;
  }
}

/// Model representing an NRT schedule item
class NRTScheduleItem {
  /// Unique identifier
  final String id;
  
  /// Day of the week (e.g., "Monday", "Tuesday")
  final String dayOfWeek;
  
  /// Time of day (e.g., "morning", "evening")
  final String timeOfDay;
  
  /// Dosage to use (e.g., "1 patch", "2 pieces")
  final String dosage;
  
  /// Type of NRT
  final NRTType? type;
  
  /// Nicotine strength in mg
  final double? nicotineStrength;
  
  /// Whether the item is completed
  final bool isCompleted;
  
  /// Creates a new NRT schedule item
  const NRTScheduleItem({
    required this.id,
    required this.dayOfWeek,
    required this.timeOfDay,
    required this.dosage,
    this.type,
    this.nicotineStrength,
    this.isCompleted = false,
  });
  
  /// Creates an NRT schedule item from JSON
  factory NRTScheduleItem.fromJson(Map<String, dynamic> json) {
    return NRTScheduleItem(
      id: json['id'] as String,
      dayOfWeek: json['dayOfWeek'] as String,
      timeOfDay: json['timeOfDay'] as String,
      dosage: json['dosage'] as String,
      type: json['type'] != null ? NRTTypeExtension.fromString(json['type'] as String) : null,
      nicotineStrength: json['nicotineStrength'] != null ? (json['nicotineStrength'] as num).toDouble() : null,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }
  
  /// Converts the NRT schedule item to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dayOfWeek': dayOfWeek,
      'timeOfDay': timeOfDay,
      'dosage': dosage,
      'type': type?.toStorageString(),
      'nicotineStrength': nicotineStrength,
      'isCompleted': isCompleted,
    };
  }
  
  /// Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is NRTScheduleItem &&
        other.id == id &&
        other.dayOfWeek == dayOfWeek &&
        other.timeOfDay == timeOfDay &&
        other.dosage == dosage;
  }
  
  /// Hash code
  @override
  int get hashCode {
    return id.hashCode ^
        dayOfWeek.hashCode ^
        timeOfDay.hashCode ^
        dosage.hashCode;
  }
}