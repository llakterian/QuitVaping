// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnalyticsDataPointImpl _$$AnalyticsDataPointImplFromJson(
        Map<String, dynamic> json) =>
    _$AnalyticsDataPointImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      metricType: json['metricType'] as String,
      value: (json['value'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      metadata: json['metadata'] as Map<String, dynamic>,
      category: json['category'] as String?,
      source: json['source'] as String?,
    );

Map<String, dynamic> _$$AnalyticsDataPointImplToJson(
        _$AnalyticsDataPointImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'metricType': instance.metricType,
      'value': instance.value,
      'timestamp': instance.timestamp.toIso8601String(),
      'metadata': instance.metadata,
      'category': instance.category,
      'source': instance.source,
    };

_$PatternRecognitionResultImpl _$$PatternRecognitionResultImplFromJson(
        Map<String, dynamic> json) =>
    _$PatternRecognitionResultImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      patternType: json['patternType'] as String,
      description: json['description'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      detectedAt: DateTime.parse(json['detectedAt'] as String),
      patternData: json['patternData'] as Map<String, dynamic>,
      triggers:
          (json['triggers'] as List<dynamic>).map((e) => e as String).toList(),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      supportingData: (json['supportingData'] as List<dynamic>?)
              ?.map(
                  (e) => AnalyticsDataPoint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PatternRecognitionResultImplToJson(
        _$PatternRecognitionResultImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'patternType': instance.patternType,
      'description': instance.description,
      'confidence': instance.confidence,
      'detectedAt': instance.detectedAt.toIso8601String(),
      'patternData': instance.patternData,
      'triggers': instance.triggers,
      'recommendations': instance.recommendations,
      'supportingData': instance.supportingData,
    };

_$PredictiveModelResultImpl _$$PredictiveModelResultImplFromJson(
        Map<String, dynamic> json) =>
    _$PredictiveModelResultImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      modelType: json['modelType'] as String,
      prediction: (json['prediction'] as num).toDouble(),
      confidence: (json['confidence'] as num).toDouble(),
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      modelData: json['modelData'] as Map<String, dynamic>,
      influencingFactors: (json['influencingFactors'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      inputData: (json['inputData'] as List<dynamic>?)
              ?.map(
                  (e) => AnalyticsDataPoint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PredictiveModelResultImplToJson(
        _$PredictiveModelResultImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'modelType': instance.modelType,
      'prediction': instance.prediction,
      'confidence': instance.confidence,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'modelData': instance.modelData,
      'influencingFactors': instance.influencingFactors,
      'recommendations': instance.recommendations,
      'inputData': instance.inputData,
    };

_$PersonalizedReportImpl _$$PersonalizedReportImplFromJson(
        Map<String, dynamic> json) =>
    _$PersonalizedReportImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      reportType: json['reportType'] as String,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      reportData: json['reportData'] as Map<String, dynamic>,
      sections: (json['sections'] as List<dynamic>)
          .map((e) => InsightSection.fromJson(e as Map<String, dynamic>))
          .toList(),
      keyFindings: (json['keyFindings'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      actionableRecommendations:
          (json['actionableRecommendations'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      isShareable: json['isShareable'] as bool? ?? false,
    );

Map<String, dynamic> _$$PersonalizedReportImplToJson(
        _$PersonalizedReportImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'reportType': instance.reportType,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'reportData': instance.reportData,
      'sections': instance.sections,
      'keyFindings': instance.keyFindings,
      'actionableRecommendations': instance.actionableRecommendations,
      'isShareable': instance.isShareable,
    };

_$InsightSectionImpl _$$InsightSectionImplFromJson(Map<String, dynamic> json) =>
    _$InsightSectionImpl(
      title: json['title'] as String,
      content: json['content'] as String,
      sectionType: json['sectionType'] as String,
      data: json['data'] as Map<String, dynamic>,
      visualizations: (json['visualizations'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      recommendations: (json['recommendations'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$InsightSectionImplToJson(
        _$InsightSectionImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'sectionType': instance.sectionType,
      'data': instance.data,
      'visualizations': instance.visualizations,
      'recommendations': instance.recommendations,
    };

_$AnalyticsWorkflowContextImpl _$$AnalyticsWorkflowContextImplFromJson(
        Map<String, dynamic> json) =>
    _$AnalyticsWorkflowContextImpl(
      userId: json['userId'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      analysisTypes: (json['analysisTypes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      userProfile: json['userProfile'] as Map<String, dynamic>,
      preferences: json['preferences'] as Map<String, dynamic>? ?? const {},
      historicalData: (json['historicalData'] as List<dynamic>?)
              ?.map(
                  (e) => AnalyticsDataPoint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$AnalyticsWorkflowContextImplToJson(
        _$AnalyticsWorkflowContextImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'analysisTypes': instance.analysisTypes,
      'userProfile': instance.userProfile,
      'preferences': instance.preferences,
      'historicalData': instance.historicalData,
    };

_$QuitSuccessPredictionImpl _$$QuitSuccessPredictionImplFromJson(
        Map<String, dynamic> json) =>
    _$QuitSuccessPredictionImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      successProbability: (json['successProbability'] as num).toDouble(),
      confidence: (json['confidence'] as num).toDouble(),
      predictionDate: DateTime.parse(json['predictionDate'] as String),
      timeHorizon: json['timeHorizon'] as String,
      positiveFactors: (json['positiveFactors'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      riskFactors: (json['riskFactors'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      modelMetrics: json['modelMetrics'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$QuitSuccessPredictionImplToJson(
        _$QuitSuccessPredictionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'successProbability': instance.successProbability,
      'confidence': instance.confidence,
      'predictionDate': instance.predictionDate.toIso8601String(),
      'timeHorizon': instance.timeHorizon,
      'positiveFactors': instance.positiveFactors,
      'riskFactors': instance.riskFactors,
      'recommendations': instance.recommendations,
      'modelMetrics': instance.modelMetrics,
    };
