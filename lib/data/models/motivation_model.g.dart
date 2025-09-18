// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'motivation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MotivationalContentImpl _$$MotivationalContentImplFromJson(
        Map<String, dynamic> json) =>
    _$MotivationalContentImpl(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      type: json['type'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      imageUrl: json['imageUrl'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      relevanceScore: (json['relevanceScore'] as num?)?.toDouble() ?? 1.0,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$MotivationalContentImplToJson(
        _$MotivationalContentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp.toIso8601String(),
      'type': instance.type,
      'title': instance.title,
      'content': instance.content,
      'imageUrl': instance.imageUrl,
      'tags': instance.tags,
      'relevanceScore': instance.relevanceScore,
      'metadata': instance.metadata,
    };

_$MilestoneEventImpl _$$MilestoneEventImplFromJson(Map<String, dynamic> json) =>
    _$MilestoneEventImpl(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      milestoneKey: json['milestoneKey'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      celebrationImageUrl: json['celebrationImageUrl'] as String?,
      milestone: json['milestone'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$MilestoneEventImplToJson(
        _$MilestoneEventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp.toIso8601String(),
      'milestoneKey': instance.milestoneKey,
      'title': instance.title,
      'message': instance.message,
      'celebrationImageUrl': instance.celebrationImageUrl,
      'milestone': instance.milestone,
    };
