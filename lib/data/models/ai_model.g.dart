// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AIChatMessageImpl _$$AIChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$AIChatMessageImpl(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      content: json['content'] as String,
      sender: json['sender'] as String,
      intent: json['intent'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$AIChatMessageImplToJson(_$AIChatMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp.toIso8601String(),
      'content': instance.content,
      'sender': instance.sender,
      'intent': instance.intent,
      'metadata': instance.metadata,
    };

_$AIRecommendationImpl _$$AIRecommendationImplFromJson(
        Map<String, dynamic> json) =>
    _$AIRecommendationImpl(
      id: json['id'] as String,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      type: json['type'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      relevanceScore: (json['relevanceScore'] as num).toDouble(),
      triggerContext: json['triggerContext'] as String?,
      actionableSteps: json['actionableSteps'] as Map<String, dynamic>?,
      userRated: json['userRated'] as bool,
      userRating: (json['userRating'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$AIRecommendationImplToJson(
        _$AIRecommendationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'type': instance.type,
      'title': instance.title,
      'content': instance.content,
      'relevanceScore': instance.relevanceScore,
      'triggerContext': instance.triggerContext,
      'actionableSteps': instance.actionableSteps,
      'userRated': instance.userRated,
      'userRating': instance.userRating,
    };

_$AIPatternAnalysisImpl _$$AIPatternAnalysisImplFromJson(
        Map<String, dynamic> json) =>
    _$AIPatternAnalysisImpl(
      id: json['id'] as String,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      userId: json['userId'] as String,
      identifiedPatterns: (json['identifiedPatterns'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      triggersByCategory:
          (json['triggersByCategory'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      timeOfDayDistribution:
          (json['timeOfDayDistribution'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      mostEffectiveStrategies:
          (json['mostEffectiveStrategies'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      leastEffectiveStrategies:
          (json['leastEffectiveStrategies'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      customInsights: json['customInsights'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$AIPatternAnalysisImplToJson(
        _$AIPatternAnalysisImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'userId': instance.userId,
      'identifiedPatterns': instance.identifiedPatterns,
      'triggersByCategory': instance.triggersByCategory,
      'timeOfDayDistribution': instance.timeOfDayDistribution,
      'mostEffectiveStrategies': instance.mostEffectiveStrategies,
      'leastEffectiveStrategies': instance.leastEffectiveStrategies,
      'customInsights': instance.customInsights,
    };
