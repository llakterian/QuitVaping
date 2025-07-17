class NRTModel {
  final String id;
  final String userId;
  final NRTType type;
  final double nicotineStrength; // in mg
  final DateTime timestamp;
  final String? notes;

  NRTModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.nicotineStrength,
    required this.timestamp,
    this.notes,
  });

  factory NRTModel.fromJson(Map<String, dynamic> json) {
    return NRTModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      type: NRTType.values.firstWhere(
        (e) => e.toString() == 'NRTType.${json['type']}',
        orElse: () => NRTType.other,
      ),
      nicotineStrength: json['nicotine_strength'] as double,
      timestamp: DateTime.parse(json['timestamp']),
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'type': type.toString().split('.').last,
      'nicotine_strength': nicotineStrength,
      'timestamp': timestamp.toIso8601String(),
      'notes': notes,
    };
  }

  NRTModel copyWith({
    String? id,
    String? userId,
    NRTType? type,
    double? nicotineStrength,
    DateTime? timestamp,
    String? notes,
  }) {
    return NRTModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      nicotineStrength: nicotineStrength ?? this.nicotineStrength,
      timestamp: timestamp ?? this.timestamp,
      notes: notes ?? this.notes,
    );
  }
}

class NRTScheduleModel {
  final String id;
  final String userId;
  final NRTType type;
  final double initialStrength; // in mg
  final double currentStrength; // in mg
  final int frequencyPerDay;
  final DateTime startDate;
  final List<NRTStepModel> reductionSteps;
  final String? notes;

  NRTScheduleModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.initialStrength,
    required this.currentStrength,
    required this.frequencyPerDay,
    required this.startDate,
    required this.reductionSteps,
    this.notes,
  });

  factory NRTScheduleModel.fromJson(Map<String, dynamic> json) {
    return NRTScheduleModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      type: NRTType.values.firstWhere(
        (e) => e.toString() == 'NRTType.${json['type']}',
        orElse: () => NRTType.other,
      ),
      initialStrength: json['initial_strength'] as double,
      currentStrength: json['current_strength'] as double,
      frequencyPerDay: json['frequency_per_day'] as int,
      startDate: DateTime.parse(json['start_date']),
      reductionSteps: (json['reduction_steps'] as List)
          .map((e) => NRTStepModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'type': type.toString().split('.').last,
      'initial_strength': initialStrength,
      'current_strength': currentStrength,
      'frequency_per_day': frequencyPerDay,
      'start_date': startDate.toIso8601String(),
      'reduction_steps': reductionSteps.map((e) => e.toJson()).toList(),
      'notes': notes,
    };
  }

  NRTScheduleModel copyWith({
    String? id,
    String? userId,
    NRTType? type,
    double? initialStrength,
    double? currentStrength,
    int? frequencyPerDay,
    DateTime? startDate,
    List<NRTStepModel>? reductionSteps,
    String? notes,
  }) {
    return NRTScheduleModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      initialStrength: initialStrength ?? this.initialStrength,
      currentStrength: currentStrength ?? this.currentStrength,
      frequencyPerDay: frequencyPerDay ?? this.frequencyPerDay,
      startDate: startDate ?? this.startDate,
      reductionSteps: reductionSteps ?? this.reductionSteps,
      notes: notes ?? this.notes,
    );
  }
  
  // Calculate the next step in the reduction plan
  NRTStepModel? getNextStep() {
    final now = DateTime.now();
    
    for (final step in reductionSteps) {
      if (step.targetDate.isAfter(now)) {
        return step;
      }
    }
    
    return null; // No more steps, plan completed
  }
  
  // Calculate progress percentage through the entire plan
  double get progressPercentage {
    if (reductionSteps.isEmpty) return 1.0;
    
    final now = DateTime.now();
    final totalDuration = reductionSteps.last.targetDate.difference(startDate).inDays;
    
    if (totalDuration <= 0) return 1.0;
    
    final elapsedDuration = now.difference(startDate).inDays;
    
    return (elapsedDuration / totalDuration).clamp(0.0, 1.0);
  }
  
  // Calculate the current recommended nicotine strength
  double get recommendedStrength {
    final now = DateTime.now();
    double strength = initialStrength;
    
    for (final step in reductionSteps) {
      if (step.targetDate.isBefore(now)) {
        strength = step.nicotineStrength;
      } else {
        break;
      }
    }
    
    return strength;
  }
}

class NRTStepModel {
  final DateTime targetDate;
  final double nicotineStrength; // in mg
  final int frequencyPerDay;

  NRTStepModel({
    required this.targetDate,
    required this.nicotineStrength,
    required this.frequencyPerDay,
  });

  factory NRTStepModel.fromJson(Map<String, dynamic> json) {
    return NRTStepModel(
      targetDate: DateTime.parse(json['target_date']),
      nicotineStrength: json['nicotine_strength'] as double,
      frequencyPerDay: json['frequency_per_day'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'target_date': targetDate.toIso8601String(),
      'nicotine_strength': nicotineStrength,
      'frequency_per_day': frequencyPerDay,
    };
  }
}

enum NRTType {
  patch,
  gum,
  lozenge,
  inhaler,
  spray,
  mint,
  other
}

extension NRTTypeExtension on NRTType {
  String get displayName {
    switch (this) {
      case NRTType.patch:
        return 'Nicotine Patch';
      case NRTType.gum:
        return 'Nicotine Gum';
      case NRTType.lozenge:
        return 'Nicotine Lozenge';
      case NRTType.inhaler:
        return 'Nicotine Inhaler';
      case NRTType.spray:
        return 'Nicotine Spray';
      case NRTType.mint:
        return 'Nicotine Mint';
      case NRTType.other:
        return 'Other NRT';
    }
  }
  
  String get icon {
    switch (this) {
      case NRTType.patch:
        return 'assets/images/nrt/patch.png';
      case NRTType.gum:
        return 'assets/images/nrt/gum.png';
      case NRTType.lozenge:
        return 'assets/images/nrt/lozenge.png';
      case NRTType.inhaler:
        return 'assets/images/nrt/inhaler.png';
      case NRTType.spray:
        return 'assets/images/nrt/spray.png';
      case NRTType.mint:
        return 'assets/images/nrt/mint.png';
      case NRTType.other:
        return 'assets/images/nrt/other.png';
    }
  }
}