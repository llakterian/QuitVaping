// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HealthRecoveryTimelineImpl _$$HealthRecoveryTimelineImplFromJson(
        Map<String, dynamic> json) =>
    _$HealthRecoveryTimelineImpl(
      userId: json['userId'] as String,
      benefits: (json['benefits'] as List<dynamic>)
          .map((e) => HealthBenefit.fromJson(e as Map<String, dynamic>))
          .toList(),
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      personalized: json['personalized'] as bool? ?? false,
    );

Map<String, dynamic> _$$HealthRecoveryTimelineImplToJson(
        _$HealthRecoveryTimelineImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'benefits': instance.benefits,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'personalized': instance.personalized,
    };

_$HealthBenefitImpl _$$HealthBenefitImplFromJson(Map<String, dynamic> json) =>
    _$HealthBenefitImpl(
      timeDescription: json['timeDescription'] as String,
      benefitDescription: json['benefitDescription'] as String,
      stage: $enumDecode(_$HealthBenefitStageEnumMap, json['stage']),
      confidenceLevel: (json['confidenceLevel'] as num?)?.toDouble() ?? 1.0,
      personalizationFactors: (json['personalizationFactors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      achieved: json['achieved'] as bool? ?? false,
      personalizedMessage: json['personalizedMessage'] as String?,
    );

Map<String, dynamic> _$$HealthBenefitImplToJson(_$HealthBenefitImpl instance) =>
    <String, dynamic>{
      'timeDescription': instance.timeDescription,
      'benefitDescription': instance.benefitDescription,
      'stage': _$HealthBenefitStageEnumMap[instance.stage]!,
      'confidenceLevel': instance.confidenceLevel,
      'personalizationFactors': instance.personalizationFactors,
      'achieved': instance.achieved,
      'personalizedMessage': instance.personalizedMessage,
    };

const _$HealthBenefitStageEnumMap = {
  HealthBenefitStage.immediate: 'immediate',
  HealthBenefitStage.shortTerm: 'short_term',
  HealthBenefitStage.mediumTerm: 'medium_term',
  HealthBenefitStage.longTerm: 'long_term',
};

_$UserHealthProfileImpl _$$UserHealthProfileImplFromJson(
        Map<String, dynamic> json) =>
    _$UserHealthProfileImpl(
      userId: json['userId'] as String,
      quitDate: DateTime.parse(json['quitDate'] as String),
      age: (json['age'] as num).toInt(),
      vapingDurationMonths: (json['vapingDurationMonths'] as num).toInt(),
      dailyUsageLevel: json['dailyUsageLevel'] as String,
      healthConditions: (json['healthConditions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      fitnessLevel: json['fitnessLevel'] as String? ?? 'fair',
    );

Map<String, dynamic> _$$UserHealthProfileImplToJson(
        _$UserHealthProfileImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'quitDate': instance.quitDate.toIso8601String(),
      'age': instance.age,
      'vapingDurationMonths': instance.vapingDurationMonths,
      'dailyUsageLevel': instance.dailyUsageLevel,
      'healthConditions': instance.healthConditions,
      'fitnessLevel': instance.fitnessLevel,
    };

_$NRTProtocolImpl _$$NRTProtocolImplFromJson(Map<String, dynamic> json) =>
    _$NRTProtocolImpl(
      recommendedNrtType: json['recommendedNrtType'] as String,
      dosageSchedule: (json['dosageSchedule'] as List<dynamic>)
          .map((e) => NRTDosageSchedule.fromJson(e as Map<String, dynamic>))
          .toList(),
      durationWeeks: (json['durationWeeks'] as num).toInt(),
      monitoringSchedule: (json['monitoringSchedule'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      successIndicators: (json['successIndicators'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      safetyWarnings: (json['safetyWarnings'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$NRTProtocolImplToJson(_$NRTProtocolImpl instance) =>
    <String, dynamic>{
      'recommendedNrtType': instance.recommendedNrtType,
      'dosageSchedule': instance.dosageSchedule,
      'durationWeeks': instance.durationWeeks,
      'monitoringSchedule': instance.monitoringSchedule,
      'successIndicators': instance.successIndicators,
      'safetyWarnings': instance.safetyWarnings,
    };

_$NRTDosageScheduleImpl _$$NRTDosageScheduleImplFromJson(
        Map<String, dynamic> json) =>
    _$NRTDosageScheduleImpl(
      week: json['week'] as String,
      dosage: json['dosage'] as String,
      additional: json['additional'] as String?,
    );

Map<String, dynamic> _$$NRTDosageScheduleImplToJson(
        _$NRTDosageScheduleImpl instance) =>
    <String, dynamic>{
      'week': instance.week,
      'dosage': instance.dosage,
      'additional': instance.additional,
    };

_$PersonalizedHealthInsightsImpl _$$PersonalizedHealthInsightsImplFromJson(
        Map<String, dynamic> json) =>
    _$PersonalizedHealthInsightsImpl(
      quitProgress:
          QuitProgress.fromJson(json['quitProgress'] as Map<String, dynamic>),
      healthImprovements: HealthImprovements.fromJson(
          json['healthImprovements'] as Map<String, dynamic>),
      financialSavings: FinancialSavings.fromJson(
          json['financialSavings'] as Map<String, dynamic>),
      riskReductions: RiskReductions.fromJson(
          json['riskReductions'] as Map<String, dynamic>),
      confidenceScore: (json['confidenceScore'] as num?)?.toDouble() ?? 0.8,
    );

Map<String, dynamic> _$$PersonalizedHealthInsightsImplToJson(
        _$PersonalizedHealthInsightsImpl instance) =>
    <String, dynamic>{
      'quitProgress': instance.quitProgress,
      'healthImprovements': instance.healthImprovements,
      'financialSavings': instance.financialSavings,
      'riskReductions': instance.riskReductions,
      'confidenceScore': instance.confidenceScore,
    };

_$QuitProgressImpl _$$QuitProgressImplFromJson(Map<String, dynamic> json) =>
    _$QuitProgressImpl(
      daysQuit: (json['daysQuit'] as num).toInt(),
      percentageComplete: (json['percentageComplete'] as num).toDouble(),
      nextMilestone: HealthMilestone.fromJson(
          json['nextMilestone'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$QuitProgressImplToJson(_$QuitProgressImpl instance) =>
    <String, dynamic>{
      'daysQuit': instance.daysQuit,
      'percentageComplete': instance.percentageComplete,
      'nextMilestone': instance.nextMilestone,
    };

_$HealthImprovementsImpl _$$HealthImprovementsImplFromJson(
        Map<String, dynamic> json) =>
    _$HealthImprovementsImpl(
      lungCapacityImprovement:
          (json['lungCapacityImprovement'] as num?)?.toDouble() ?? 0.0,
      circulationImprovement:
          (json['circulationImprovement'] as num?)?.toDouble() ?? 0.0,
      tasteSmellRecovery:
          (json['tasteSmellRecovery'] as num?)?.toDouble() ?? 0.0,
      energyLevelIncrease:
          (json['energyLevelIncrease'] as num?)?.toDouble() ?? 0.0,
      heartRateImprovement:
          (json['heartRateImprovement'] as num?)?.toDouble() ?? 0.0,
      bloodPressureImprovement:
          (json['bloodPressureImprovement'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$HealthImprovementsImplToJson(
        _$HealthImprovementsImpl instance) =>
    <String, dynamic>{
      'lungCapacityImprovement': instance.lungCapacityImprovement,
      'circulationImprovement': instance.circulationImprovement,
      'tasteSmellRecovery': instance.tasteSmellRecovery,
      'energyLevelIncrease': instance.energyLevelIncrease,
      'heartRateImprovement': instance.heartRateImprovement,
      'bloodPressureImprovement': instance.bloodPressureImprovement,
    };

_$FinancialSavingsImpl _$$FinancialSavingsImplFromJson(
        Map<String, dynamic> json) =>
    _$FinancialSavingsImpl(
      totalSaved: (json['totalSaved'] as num).toDouble(),
      dailySavings: (json['dailySavings'] as num).toDouble(),
      weeklySavings: (json['weeklySavings'] as num).toDouble(),
      monthlySavings: (json['monthlySavings'] as num).toDouble(),
      yearlySavings: (json['yearlySavings'] as num).toDouble(),
      daysQuit: (json['daysQuit'] as num).toInt(),
    );

Map<String, dynamic> _$$FinancialSavingsImplToJson(
        _$FinancialSavingsImpl instance) =>
    <String, dynamic>{
      'totalSaved': instance.totalSaved,
      'dailySavings': instance.dailySavings,
      'weeklySavings': instance.weeklySavings,
      'monthlySavings': instance.monthlySavings,
      'yearlySavings': instance.yearlySavings,
      'daysQuit': instance.daysQuit,
    };

_$RiskReductionsImpl _$$RiskReductionsImplFromJson(Map<String, dynamic> json) =>
    _$RiskReductionsImpl(
      heartAttackRisk: (json['heartAttackRisk'] as num?)?.toDouble() ?? 0.0,
      strokeRisk: (json['strokeRisk'] as num?)?.toDouble() ?? 0.0,
      lungCancerRisk: (json['lungCancerRisk'] as num?)?.toDouble() ?? 0.0,
      respiratoryInfectionRisk:
          (json['respiratoryInfectionRisk'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$RiskReductionsImplToJson(
        _$RiskReductionsImpl instance) =>
    <String, dynamic>{
      'heartAttackRisk': instance.heartAttackRisk,
      'strokeRisk': instance.strokeRisk,
      'lungCancerRisk': instance.lungCancerRisk,
      'respiratoryInfectionRisk': instance.respiratoryInfectionRisk,
    };

_$HealthMilestoneImpl _$$HealthMilestoneImplFromJson(
        Map<String, dynamic> json) =>
    _$HealthMilestoneImpl(
      days: (json['days'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      achieved: json['achieved'] as bool? ?? false,
      daysRemaining: (json['daysRemaining'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$HealthMilestoneImplToJson(
        _$HealthMilestoneImpl instance) =>
    <String, dynamic>{
      'days': instance.days,
      'title': instance.title,
      'description': instance.description,
      'achieved': instance.achieved,
      'daysRemaining': instance.daysRemaining,
    };

_$HealthDataSourceImpl _$$HealthDataSourceImplFromJson(
        Map<String, dynamic> json) =>
    _$HealthDataSourceImpl(
      name: json['name'] as String,
      url: json['url'] as String,
      description: json['description'] as String,
      reliability: (json['reliability'] as num?)?.toDouble() ?? 1.0,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$HealthDataSourceImplToJson(
        _$HealthDataSourceImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'description': instance.description,
      'reliability': instance.reliability,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
    };

_$HealthResearchCitationImpl _$$HealthResearchCitationImplFromJson(
        Map<String, dynamic> json) =>
    _$HealthResearchCitationImpl(
      title: json['title'] as String,
      authors: json['authors'] as String,
      journal: json['journal'] as String,
      doi: json['doi'] as String,
      publishedDate: DateTime.parse(json['publishedDate'] as String),
      relevanceScore: (json['relevanceScore'] as num?)?.toDouble() ?? 1.0,
    );

Map<String, dynamic> _$$HealthResearchCitationImplToJson(
        _$HealthResearchCitationImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'authors': instance.authors,
      'journal': instance.journal,
      'doi': instance.doi,
      'publishedDate': instance.publishedDate.toIso8601String(),
      'relevanceScore': instance.relevanceScore,
    };

_$HealthAlertImpl _$$HealthAlertImplFromJson(Map<String, dynamic> json) =>
    _$HealthAlertImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      type: $enumDecode(_$HealthAlertTypeEnumMap, json['type']),
      priority: $enumDecode(_$HealthAlertPriorityEnumMap, json['priority']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      dismissed: json['dismissed'] as bool? ?? false,
      actionUrl: json['actionUrl'] as String?,
    );

Map<String, dynamic> _$$HealthAlertImplToJson(_$HealthAlertImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'type': _$HealthAlertTypeEnumMap[instance.type]!,
      'priority': _$HealthAlertPriorityEnumMap[instance.priority]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'dismissed': instance.dismissed,
      'actionUrl': instance.actionUrl,
    };

const _$HealthAlertTypeEnumMap = {
  HealthAlertType.milestone: 'milestone',
  HealthAlertType.improvement: 'improvement',
  HealthAlertType.warning: 'warning',
  HealthAlertType.recommendation: 'recommendation',
  HealthAlertType.celebration: 'celebration',
};

const _$HealthAlertPriorityEnumMap = {
  HealthAlertPriority.low: 'low',
  HealthAlertPriority.medium: 'medium',
  HealthAlertPriority.high: 'high',
  HealthAlertPriority.urgent: 'urgent',
};

_$HealthMetricsImpl _$$HealthMetricsImplFromJson(Map<String, dynamic> json) =>
    _$HealthMetricsImpl(
      userId: json['userId'] as String,
      recordedAt: DateTime.parse(json['recordedAt'] as String),
      heartRate: (json['heartRate'] as num?)?.toDouble(),
      bloodPressure: (json['bloodPressure'] as num?)?.toDouble(),
      oxygenSaturation: (json['oxygenSaturation'] as num?)?.toDouble(),
      lungCapacity: (json['lungCapacity'] as num?)?.toDouble(),
      stepsCount: (json['stepsCount'] as num?)?.toInt(),
      sleepQuality: (json['sleepQuality'] as num?)?.toDouble(),
      stressLevel: (json['stressLevel'] as num?)?.toInt(),
      additionalMetrics: json['additionalMetrics'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$HealthMetricsImplToJson(_$HealthMetricsImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'recordedAt': instance.recordedAt.toIso8601String(),
      'heartRate': instance.heartRate,
      'bloodPressure': instance.bloodPressure,
      'oxygenSaturation': instance.oxygenSaturation,
      'lungCapacity': instance.lungCapacity,
      'stepsCount': instance.stepsCount,
      'sleepQuality': instance.sleepQuality,
      'stressLevel': instance.stressLevel,
      'additionalMetrics': instance.additionalMetrics,
    };

_$HealthGoalImpl _$$HealthGoalImplFromJson(Map<String, dynamic> json) =>
    _$HealthGoalImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$HealthGoalTypeEnumMap, json['type']),
      targetValue: (json['targetValue'] as num).toDouble(),
      currentValue: (json['currentValue'] as num).toDouble(),
      unit: json['unit'] as String,
      targetDate: DateTime.parse(json['targetDate'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      achieved: json['achieved'] as bool? ?? false,
      achievedAt: json['achievedAt'] == null
          ? null
          : DateTime.parse(json['achievedAt'] as String),
    );

Map<String, dynamic> _$$HealthGoalImplToJson(_$HealthGoalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'type': _$HealthGoalTypeEnumMap[instance.type]!,
      'targetValue': instance.targetValue,
      'currentValue': instance.currentValue,
      'unit': instance.unit,
      'targetDate': instance.targetDate.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'achieved': instance.achieved,
      'achievedAt': instance.achievedAt?.toIso8601String(),
    };

const _$HealthGoalTypeEnumMap = {
  HealthGoalType.lungCapacity: 'lung_capacity',
  HealthGoalType.exercise: 'exercise',
  HealthGoalType.weight: 'weight',
  HealthGoalType.sleep: 'sleep',
  HealthGoalType.stress: 'stress',
  HealthGoalType.quitDuration: 'quit_duration',
};

_$HealthRecommendationImpl _$$HealthRecommendationImplFromJson(
        Map<String, dynamic> json) =>
    _$HealthRecommendationImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$HealthRecommendationTypeEnumMap, json['type']),
      confidenceScore: (json['confidenceScore'] as num).toDouble(),
      evidenceSources: (json['evidenceSources'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      generatedAt: DateTime.parse(json['generatedAt'] as String),
      implemented: json['implemented'] as bool? ?? false,
      implementedAt: json['implementedAt'] == null
          ? null
          : DateTime.parse(json['implementedAt'] as String),
      userFeedback: json['userFeedback'] as String?,
    );

Map<String, dynamic> _$$HealthRecommendationImplToJson(
        _$HealthRecommendationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'type': _$HealthRecommendationTypeEnumMap[instance.type]!,
      'confidenceScore': instance.confidenceScore,
      'evidenceSources': instance.evidenceSources,
      'generatedAt': instance.generatedAt.toIso8601String(),
      'implemented': instance.implemented,
      'implementedAt': instance.implementedAt?.toIso8601String(),
      'userFeedback': instance.userFeedback,
    };

const _$HealthRecommendationTypeEnumMap = {
  HealthRecommendationType.exercise: 'exercise',
  HealthRecommendationType.nutrition: 'nutrition',
  HealthRecommendationType.sleep: 'sleep',
  HealthRecommendationType.stressManagement: 'stress_management',
  HealthRecommendationType.medicalCheckup: 'medical_checkup',
  HealthRecommendationType.nrtAdjustment: 'nrt_adjustment',
};
