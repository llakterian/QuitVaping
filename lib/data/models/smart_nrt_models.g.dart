// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smart_nrt_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NRTIntelligentScheduleImpl _$$NRTIntelligentScheduleImplFromJson(
        Map<String, dynamic> json) =>
    _$NRTIntelligentScheduleImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      protocol: NRTProtocol.fromJson(json['protocol'] as Map<String, dynamic>),
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      adaptiveReminders: (json['adaptiveReminders'] as List<dynamic>)
          .map((e) => AdaptiveReminder.fromJson(e as Map<String, dynamic>))
          .toList(),
      progressMilestones: (json['progressMilestones'] as List<dynamic>)
          .map((e) => ProgressMilestone.fromJson(e as Map<String, dynamic>))
          .toList(),
      isActive: json['isActive'] as bool? ?? false,
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$NRTIntelligentScheduleImplToJson(
        _$NRTIntelligentScheduleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'protocol': instance.protocol,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'adaptiveReminders': instance.adaptiveReminders,
      'progressMilestones': instance.progressMilestones,
      'isActive': instance.isActive,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
    };

_$AdaptiveReminderImpl _$$AdaptiveReminderImplFromJson(
        Map<String, dynamic> json) =>
    _$AdaptiveReminderImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      scheduledTime: DateTime.parse(json['scheduledTime'] as String),
      message: json['message'] as String,
      type: $enumDecode(_$AdaptiveReminderTypeEnumMap, json['type']),
      priority: (json['priority'] as num?)?.toDouble() ?? 1.0,
      isActive: json['isActive'] as bool? ?? true,
      adaptationData: json['adaptationData'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$AdaptiveReminderImplToJson(
        _$AdaptiveReminderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'scheduledTime': instance.scheduledTime.toIso8601String(),
      'message': instance.message,
      'type': _$AdaptiveReminderTypeEnumMap[instance.type]!,
      'priority': instance.priority,
      'isActive': instance.isActive,
      'adaptationData': instance.adaptationData,
    };

const _$AdaptiveReminderTypeEnumMap = {
  AdaptiveReminderType.dosage: 'dosage',
  AdaptiveReminderType.reduction: 'reduction',
  AdaptiveReminderType.symptomCheck: 'symptom_check',
  AdaptiveReminderType.progressReview: 'progress_review',
  AdaptiveReminderType.motivation: 'motivation',
};

_$ProgressMilestoneImpl _$$ProgressMilestoneImplFromJson(
        Map<String, dynamic> json) =>
    _$ProgressMilestoneImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      targetDate: DateTime.parse(json['targetDate'] as String),
      targetValue: (json['targetValue'] as num).toDouble(),
      unit: json['unit'] as String,
      achieved: json['achieved'] as bool? ?? false,
      achievedDate: json['achievedDate'] == null
          ? null
          : DateTime.parse(json['achievedDate'] as String),
      celebrationMessage: json['celebrationMessage'] as String?,
    );

Map<String, dynamic> _$$ProgressMilestoneImplToJson(
        _$ProgressMilestoneImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'targetDate': instance.targetDate.toIso8601String(),
      'targetValue': instance.targetValue,
      'unit': instance.unit,
      'achieved': instance.achieved,
      'achievedDate': instance.achievedDate?.toIso8601String(),
      'celebrationMessage': instance.celebrationMessage,
    };

_$NRTReminderImpl _$$NRTReminderImplFromJson(Map<String, dynamic> json) =>
    _$NRTReminderImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: $enumDecode(_$NRTReminderTypeEnumMap, json['type']),
      scheduledTime: DateTime.parse(json['scheduledTime'] as String),
      message: json['message'] as String,
      isActive: json['isActive'] as bool? ?? true,
      isCompleted: json['isCompleted'] as bool? ?? false,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      userResponse: json['userResponse'] as String?,
    );

Map<String, dynamic> _$$NRTReminderImplToJson(_$NRTReminderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': _$NRTReminderTypeEnumMap[instance.type]!,
      'scheduledTime': instance.scheduledTime.toIso8601String(),
      'message': instance.message,
      'isActive': instance.isActive,
      'isCompleted': instance.isCompleted,
      'completedAt': instance.completedAt?.toIso8601String(),
      'userResponse': instance.userResponse,
    };

const _$NRTReminderTypeEnumMap = {
  NRTReminderType.dosage: 'dosage',
  NRTReminderType.reduction: 'reduction',
  NRTReminderType.symptomCheck: 'symptom_check',
  NRTReminderType.urgent: 'urgent',
  NRTReminderType.celebration: 'celebration',
};

_$WithdrawalSymptomImpl _$$WithdrawalSymptomImplFromJson(
        Map<String, dynamic> json) =>
    _$WithdrawalSymptomImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: $enumDecode(_$WithdrawalSymptomTypeEnumMap, json['type']),
      severity: (json['severity'] as num).toInt(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      notes: json['notes'] as String?,
      triggers: json['triggers'] as String?,
      copingStrategy: json['copingStrategy'] as String?,
    );

Map<String, dynamic> _$$WithdrawalSymptomImplToJson(
        _$WithdrawalSymptomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': _$WithdrawalSymptomTypeEnumMap[instance.type]!,
      'severity': instance.severity,
      'timestamp': instance.timestamp.toIso8601String(),
      'notes': instance.notes,
      'triggers': instance.triggers,
      'copingStrategy': instance.copingStrategy,
    };

const _$WithdrawalSymptomTypeEnumMap = {
  WithdrawalSymptomType.craving: 'craving',
  WithdrawalSymptomType.irritability: 'irritability',
  WithdrawalSymptomType.anxiety: 'anxiety',
  WithdrawalSymptomType.difficultyConcentrating: 'difficulty_concentrating',
  WithdrawalSymptomType.restlessness: 'restlessness',
  WithdrawalSymptomType.sleepDisturbance: 'sleep_disturbance',
  WithdrawalSymptomType.increasedAppetite: 'increased_appetite',
  WithdrawalSymptomType.moodChanges: 'mood_changes',
  WithdrawalSymptomType.fatigue: 'fatigue',
  WithdrawalSymptomType.headache: 'headache',
};

_$SymptomResponseImpl _$$SymptomResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$SymptomResponseImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      symptom:
          WithdrawalSymptom.fromJson(json['symptom'] as Map<String, dynamic>),
      message: json['message'] as String,
      copingStrategies: (json['copingStrategies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      evidenceSources: (json['evidenceSources'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      requiresImmediateAction:
          json['requiresImmediateAction'] as bool? ?? false,
      requiresMedicalAttention:
          json['requiresMedicalAttention'] as bool? ?? false,
      followUpDate: json['followUpDate'] == null
          ? null
          : DateTime.parse(json['followUpDate'] as String),
    );

Map<String, dynamic> _$$SymptomResponseImplToJson(
        _$SymptomResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'symptom': instance.symptom,
      'message': instance.message,
      'copingStrategies': instance.copingStrategies,
      'evidenceSources': instance.evidenceSources,
      'requiresImmediateAction': instance.requiresImmediateAction,
      'requiresMedicalAttention': instance.requiresMedicalAttention,
      'followUpDate': instance.followUpDate?.toIso8601String(),
    };

_$NRTDosageRecommendationImpl _$$NRTDosageRecommendationImplFromJson(
        Map<String, dynamic> json) =>
    _$NRTDosageRecommendationImpl(
      recommendedDosage: json['recommendedDosage'] as String,
      adjustment: json['adjustment'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      reasoning: json['reasoning'] as String,
      nextReviewDate: DateTime.parse(json['nextReviewDate'] as String),
      warnings: (json['warnings'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      supportingEvidence: (json['supportingEvidence'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$NRTDosageRecommendationImplToJson(
        _$NRTDosageRecommendationImpl instance) =>
    <String, dynamic>{
      'recommendedDosage': instance.recommendedDosage,
      'adjustment': instance.adjustment,
      'confidence': instance.confidence,
      'reasoning': instance.reasoning,
      'nextReviewDate': instance.nextReviewDate.toIso8601String(),
      'warnings': instance.warnings,
      'supportingEvidence': instance.supportingEvidence,
    };

_$NRTReadinessAssessmentImpl _$$NRTReadinessAssessmentImplFromJson(
        Map<String, dynamic> json) =>
    _$NRTReadinessAssessmentImpl(
      isReady: json['isReady'] as bool,
      readinessScore: (json['readinessScore'] as num).toDouble(),
      reasons:
          (json['reasons'] as List<dynamic>).map((e) => e as String).toList(),
      recommendedWaitDays: (json['recommendedWaitDays'] as num).toInt(),
      preparationSteps: (json['preparationSteps'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      nextAssessmentDate: json['nextAssessmentDate'] == null
          ? null
          : DateTime.parse(json['nextAssessmentDate'] as String),
    );

Map<String, dynamic> _$$NRTReadinessAssessmentImplToJson(
        _$NRTReadinessAssessmentImpl instance) =>
    <String, dynamic>{
      'isReady': instance.isReady,
      'readinessScore': instance.readinessScore,
      'reasons': instance.reasons,
      'recommendedWaitDays': instance.recommendedWaitDays,
      'preparationSteps': instance.preparationSteps,
      'nextAssessmentDate': instance.nextAssessmentDate?.toIso8601String(),
    };

_$UsagePatternsImpl _$$UsagePatternsImplFromJson(Map<String, dynamic> json) =>
    _$UsagePatternsImpl(
      preferredTimes: (json['preferredTimes'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      averageDaily: (json['averageDaily'] as num).toDouble(),
      consistency: (json['consistency'] as num).toDouble(),
      triggers: (json['triggers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      patterns: (json['patterns'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UsagePatternsImplToJson(_$UsagePatternsImpl instance) =>
    <String, dynamic>{
      'preferredTimes': instance.preferredTimes,
      'averageDaily': instance.averageDaily,
      'consistency': instance.consistency,
      'triggers': instance.triggers,
      'patterns': instance.patterns,
    };

_$MedicalEvidenceImpl _$$MedicalEvidenceImplFromJson(
        Map<String, dynamic> json) =>
    _$MedicalEvidenceImpl(
      title: json['title'] as String,
      source: json['source'] as String,
      summary: json['summary'] as String,
      relevanceScore: (json['relevanceScore'] as num).toDouble(),
      publishedDate: DateTime.parse(json['publishedDate'] as String),
      doi: json['doi'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$MedicalEvidenceImplToJson(
        _$MedicalEvidenceImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'source': instance.source,
      'summary': instance.summary,
      'relevanceScore': instance.relevanceScore,
      'publishedDate': instance.publishedDate.toIso8601String(),
      'doi': instance.doi,
      'url': instance.url,
    };

_$NRTSafetyAlertImpl _$$NRTSafetyAlertImplFromJson(Map<String, dynamic> json) =>
    _$NRTSafetyAlertImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: $enumDecode(_$NRTSafetyAlertTypeEnumMap, json['type']),
      message: json['message'] as String,
      severity: $enumDecode(_$NRTSafetyAlertSeverityEnumMap, json['severity']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      acknowledged: json['acknowledged'] as bool? ?? false,
      acknowledgedAt: json['acknowledgedAt'] == null
          ? null
          : DateTime.parse(json['acknowledgedAt'] as String),
      userResponse: json['userResponse'] as String?,
    );

Map<String, dynamic> _$$NRTSafetyAlertImplToJson(
        _$NRTSafetyAlertImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': _$NRTSafetyAlertTypeEnumMap[instance.type]!,
      'message': instance.message,
      'severity': _$NRTSafetyAlertSeverityEnumMap[instance.severity]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'acknowledged': instance.acknowledged,
      'acknowledgedAt': instance.acknowledgedAt?.toIso8601String(),
      'userResponse': instance.userResponse,
    };

const _$NRTSafetyAlertTypeEnumMap = {
  NRTSafetyAlertType.overdoseRisk: 'overdose_risk',
  NRTSafetyAlertType.interactionWarning: 'interaction_warning',
  NRTSafetyAlertType.sideEffectConcern: 'side_effect_concern',
  NRTSafetyAlertType.usagePatternConcern: 'usage_pattern_concern',
  NRTSafetyAlertType.medicalConsultationNeeded: 'medical_consultation_needed',
};

const _$NRTSafetyAlertSeverityEnumMap = {
  NRTSafetyAlertSeverity.low: 'low',
  NRTSafetyAlertSeverity.medium: 'medium',
  NRTSafetyAlertSeverity.high: 'high',
  NRTSafetyAlertSeverity.critical: 'critical',
};

_$NRTProgressReportImpl _$$NRTProgressReportImplFromJson(
        Map<String, dynamic> json) =>
    _$NRTProgressReportImpl(
      userId: json['userId'] as String,
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      summary:
          NRTProgressSummary.fromJson(json['summary'] as Map<String, dynamic>),
      metrics: (json['metrics'] as List<dynamic>)
          .map((e) => NRTProgressMetric.fromJson(e as Map<String, dynamic>))
          .toList(),
      achievements: (json['achievements'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      overallScore: (json['overallScore'] as num).toDouble(),
      nextReviewDate: json['nextReviewDate'] == null
          ? null
          : DateTime.parse(json['nextReviewDate'] as String),
    );

Map<String, dynamic> _$$NRTProgressReportImplToJson(
        _$NRTProgressReportImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'summary': instance.summary,
      'metrics': instance.metrics,
      'achievements': instance.achievements,
      'recommendations': instance.recommendations,
      'overallScore': instance.overallScore,
      'nextReviewDate': instance.nextReviewDate?.toIso8601String(),
    };

_$NRTProgressSummaryImpl _$$NRTProgressSummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$NRTProgressSummaryImpl(
      daysOnNRT: (json['daysOnNRT'] as num).toInt(),
      initialDosage: (json['initialDosage'] as num).toDouble(),
      currentDosage: (json['currentDosage'] as num).toDouble(),
      reductionPercentage: (json['reductionPercentage'] as num).toDouble(),
      symptomsReported: (json['symptomsReported'] as num).toInt(),
      averageSymptomSeverity:
          (json['averageSymptomSeverity'] as num).toDouble(),
      milestonesAchieved: (json['milestonesAchieved'] as num).toInt(),
    );

Map<String, dynamic> _$$NRTProgressSummaryImplToJson(
        _$NRTProgressSummaryImpl instance) =>
    <String, dynamic>{
      'daysOnNRT': instance.daysOnNRT,
      'initialDosage': instance.initialDosage,
      'currentDosage': instance.currentDosage,
      'reductionPercentage': instance.reductionPercentage,
      'symptomsReported': instance.symptomsReported,
      'averageSymptomSeverity': instance.averageSymptomSeverity,
      'milestonesAchieved': instance.milestonesAchieved,
    };

_$NRTProgressMetricImpl _$$NRTProgressMetricImplFromJson(
        Map<String, dynamic> json) =>
    _$NRTProgressMetricImpl(
      name: json['name'] as String,
      value: (json['value'] as num).toDouble(),
      unit: json['unit'] as String,
      trend: json['trend'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$$NRTProgressMetricImplToJson(
        _$NRTProgressMetricImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'unit': instance.unit,
      'trend': instance.trend,
      'description': instance.description,
    };

_$NRTSuccessPredictionImpl _$$NRTSuccessPredictionImplFromJson(
        Map<String, dynamic> json) =>
    _$NRTSuccessPredictionImpl(
      userId: json['userId'] as String,
      successProbability: (json['successProbability'] as num).toDouble(),
      positiveFactors: (json['positiveFactors'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      riskFactors: (json['riskFactors'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      predictionDate: DateTime.parse(json['predictionDate'] as String),
      predictionHorizonDays: (json['predictionHorizonDays'] as num).toInt(),
    );

Map<String, dynamic> _$$NRTSuccessPredictionImplToJson(
        _$NRTSuccessPredictionImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'successProbability': instance.successProbability,
      'positiveFactors': instance.positiveFactors,
      'riskFactors': instance.riskFactors,
      'recommendations': instance.recommendations,
      'predictionDate': instance.predictionDate.toIso8601String(),
      'predictionHorizonDays': instance.predictionHorizonDays,
    };
