import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'craving_model.g.dart';
part 'craving_model.freezed.dart';

@freezed
class CravingModel with _$CravingModel {
  const CravingModel._();
  
  const factory CravingModel({
    required String id,
    required DateTime timestamp,
    required int intensity, // 1-10 scale
    required String triggerCategory, // emotional, social, environmental, physical
    String? specificTrigger,
    String? location,
    String? activity,
    String? emotion,
    int? duration, // in minutes
    String? copingStrategy,
    required bool resolved,
    String? notes,
    Map<String, dynamic>? aiInsights,
  }) = _CravingModel;

  factory CravingModel.fromJson(Map<String, dynamic> json) => _$CravingModelFromJson(json);
  
  // Helper method to categorize craving intensity
  String get intensityCategory {
    if (intensity <= 3) {
      return 'Mild';
    } else if (intensity <= 7) {
      return 'Moderate';
    } else {
      return 'Severe';
    }
  }

  // Helper method to get time of day
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
}

@freezed
class CravingInsightModel with _$CravingInsightModel {
  const factory CravingInsightModel({
    required String id,
    required DateTime generatedAt,
    required String insightType, // pattern, trigger, time, location, etc.
    required String description,
    required double confidenceScore, // 0.0 to 1.0
    required Map<String, dynamic> supportingData,
    List<String>? recommendedStrategies,
  }) = _CravingInsightModel;

  factory CravingInsightModel.fromJson(Map<String, dynamic> json) => _$CravingInsightModelFromJson(json);
}