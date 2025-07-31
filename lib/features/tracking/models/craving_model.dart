class CravingModel {
  final DateTime timestamp;
  final int intensity;
  final String triggerCategory;
  final String trigger;
  final String location;
  final String activity;
  final String notes;
  final bool resisted;
  
  CravingModel.create(id: DateTime.now().millisecondsSinceEpoch.toString(), gaveIn: false, {
    required this.timestamp,
    required this.intensity,
    required this.triggerCategory,
    required this.trigger,
    required this.location,
    required this.activity,
    required this.notes,
    required this.resisted,
  });
  
  // Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp.millisecondsSinceEpoch,
      'intensity': intensity,
      'triggerCategory': triggerCategory,
      'trigger': trigger,
      'location': location,
      'activity': activity,
      'notes': notes,
      'resisted': resisted,
    };
  }
  
  // Create from Map for retrieval
  factory CravingModel.fromMap(Map<String, dynamic> map) {
    return CravingModel.create(id: DateTime.now().millisecondsSinceEpoch.toString(), gaveIn: false, 
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
      intensity: map['intensity'],
      triggerCategory: map['triggerCategory'],
      trigger: map['trigger'],
      location: map['location'],
      activity: map['activity'],
      notes: map['notes'],
      resisted: map['resisted'],
    );
  }
  
  // Create a copy with updated fields
  CravingModel copyWith({
    DateTime? timestamp,
    int? intensity,
    String? triggerCategory,
    String? trigger,
    String? location,
    String? activity,
    String? notes,
    bool? resisted,
  }) {
    return CravingModel.create(id: DateTime.now().millisecondsSinceEpoch.toString(), gaveIn: false, 
      timestamp: timestamp ?? this.timestamp,
      intensity: intensity ?? this.intensity,
      triggerCategory: triggerCategory ?? this.triggerCategory,
      trigger: trigger ?? this.trigger,
      location: location ?? this.location,
      activity: activity ?? this.activity,
      notes: notes ?? this.notes,
      resisted: resisted ?? this.resisted,
    );
  }
}