// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'craving_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CravingModelImpl _$$CravingModelImplFromJson(Map<String, dynamic> json) =>
    _$CravingModelImpl(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      intensity: (json['intensity'] as num).toInt(),
      triggerCategory: json['triggerCategory'] as String,
      specificTrigger: json['specificTrigger'] as String?,
      location: json['location'] as String?,
      activity: json['activity'] as String?,
      emotion: json['emotion'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      copingStrategy: json['copingStrategy'] as String?,
      resolved: json['resolved'] as bool,
      notes: json['notes'] as String?,
      aiInsights: json['aiInsights'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$CravingModelImplToJson(_$CravingModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp.toIso8601String(),
      'intensity': instance.intensity,
      'triggerCategory': instance.triggerCategory,
      'specificTrigger': instance.specificTrigger,
      'location': instance.location,
      'activity': instance.activity,
      'emotion': instance.emotion,
      'duration': instance.duration,
      'copingStrategy': instance.copingStrategy,
      'resolved': instance.resolved,
      'notes': instance.notes,
      'aiInsights': instance.aiInsights,
    };

_$CravingInsightModelImpl _$$CravingInsightModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CravingInsightModelImpl(
      id: json['id'] as String,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      insightType: json['insightType'] as String,
      description: json['description'] as String,
      confidenceScore: (json['confidenceScore'] as num).toDouble(),
      supportingData: json['supportingData'] as Map<String, dynamic>,
      recommendedStrategies: (json['recommendedStrategies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$CravingInsightModelImplToJson(
        _$CravingInsightModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'insightType': instance.insightType,
      'description': instance.description,
      'confidenceScore': instance.confidenceScore,
      'supportingData': instance.supportingData,
      'recommendedStrategies': instance.recommendedStrategies,
    };
