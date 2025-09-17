import 'package:freezed_annotation/freezed_annotation.dart';

part 'health_models.freezed.dart';
part 'health_models.g.dart';

/// Health Recovery Timeline containing all health benefits over time
@freezed
class HealthRecoveryTimeline with _$HealthRecoveryTimeline {
  const factory HealthRecoveryTimeline({
    required String userId,
    required List<HealthBenefit> benefits,
    required DateTime generatedAt,
    @Default(false) bool personalized,
  }) = _HealthRecoveryTimeline;

  factory HealthRecoveryTimeline.fromJson(Map<String, dynamic> json) =>
      _$HealthRecoveryTimelineFromJson(json);
}

/// Individual health benefit at a specific time point
@freezed
class HealthBenefit with _$HealthBenefit {
  const factory HealthBenefit({
    required String timeDescription,
    required String benefitDescription,
    required HealthBenefitStage stage,
    @Default(1.0) double confidenceLevel,
    @Default([]) List<String> personalizationFactors,
    @Default(false) bool achieved,
    String? personalizedMessage,
  }) = _HealthBenefit;

  factory HealthBenefit.fromJson(Map<String, dynamic> json) =>
      _$HealthBenefitFromJson(json);
}

/// Health benefit stages after quitting vaping
enum HealthBenefitStage {
  @JsonValue('immediate')
  immediate,
  @JsonValue('short_term')
  shortTerm,
  @JsonValue('medium_term')
  mediumTerm,
  @JsonValue('long_term')
  longTerm,
}

/// User's health profile for personalized insights
@freezed
class UserHealthProfile with _$UserHealthProfile {
  const factory UserHealthProfile({
    required String userId,
    required DateTime quitDate,
    required int age,
    required int vapingDurationMonths,
    required String dailyUsageLevel, // low, medium, high
    @Default([]) List<String> healthConditions,
    @Default('fair') String fitnessLevel, // poor, fair, good, excellent
  }) = _UserHealthProfile;

  factory UserHealthProfile.fromJson(Map<String, dynamic> json) =>
      _$UserHealthProfileFromJson(json);
}

/// NRT (Nicotine Replacement Therapy) Protocol
@freezed
class NRTProtocol with _$NRTProtocol {
  const factory NRTProtocol({
    required String recommendedNrtType,
    required List<NRTDosageSchedule> dosageSchedule,
    required int durationWeeks,
    required List<String> monitoringSchedule,
    required List<String> successIndicators,
    @Default([]) List<String> safetyWarnings,
  }) = _NRTProtocol;

  factory NRTProtocol.fromJson(Map<String, dynamic> json) =>
      _$NRTProtocolFromJson(json);
}

/// NRT dosage schedule item
@freezed
class NRTDosageSchedule with _$NRTDosageSchedule {
  const factory NRTDosageSchedule({
    required String week,
    required String dosage,
    String? additional,
  }) = _NRTDosageSchedule;

  factory NRTDosageSchedule.fromJson(Map<String, dynamic> json) =>
      _$NRTDosageScheduleFromJson(json);
}

/// Comprehensive personalized health insights
@freezed
class PersonalizedHealthInsights with _$PersonalizedHealthInsights {
  const factory PersonalizedHealthInsights({
    required QuitProgress quitProgress,
    required HealthImprovements healthImprovements,
    required FinancialSavings financialSavings,
    required RiskReductions riskReductions,
    @Default(0.8) double confidenceScore,
  }) = _PersonalizedHealthInsights;

  factory PersonalizedHealthInsights.fromJson(Map<String, dynamic> json) =>
      _$PersonalizedHealthInsightsFromJson(json);
}

/// Quit progress information
@freezed
class QuitProgress with _$QuitProgress {
  const factory QuitProgress({
    required int daysQuit,
    required double percentageComplete,
    required HealthMilestone nextMilestone,
  }) = _QuitProgress;

  factory QuitProgress.fromJson(Map<String, dynamic> json) =>
      _$QuitProgressFromJson(json);
}

/// Health improvements metrics
@freezed
class HealthImprovements with _$HealthImprovements {
  const factory HealthImprovements({
    @Default(0.0) double lungCapacityImprovement,
    @Default(0.0) double circulationImprovement,
    @Default(0.0) double tasteSmellRecovery,
    @Default(0.0) double energyLevelIncrease,
    @Default(0.0) double heartRateImprovement,
    @Default(0.0) double bloodPressureImprovement,
  }) = _HealthImprovements;

  factory HealthImprovements.fromJson(Map<String, dynamic> json) =>
      _$HealthImprovementsFromJson(json);
}

/// Financial savings from quitting
@freezed
class FinancialSavings with _$FinancialSavings {
  const factory FinancialSavings({
    required double totalSaved,
    required double dailySavings,
    required double weeklySavings,
    required double monthlySavings,
    required double yearlySavings,
    required int daysQuit,
  }) = _FinancialSavings;

  factory FinancialSavings.fromJson(Map<String, dynamic> json) =>
      _$FinancialSavingsFromJson(json);
}

/// Health risk reductions
@freezed
class RiskReductions with _$RiskReductions {
  const factory RiskReductions({
    @Default(0.0) double heartAttackRisk,
    @Default(0.0) double strokeRisk,
    @Default(0.0) double lungCancerRisk,
    @Default(0.0) double respiratoryInfectionRisk,
  }) = _RiskReductions;

  factory RiskReductions.fromJson(Map<String, dynamic> json) =>
      _$RiskReductionsFromJson(json);
}

/// Health milestone information
@freezed
class HealthMilestone with _$HealthMilestone {
  const factory HealthMilestone({
    required int days,
    required String title,
    required String description,
    @Default(false) bool achieved,
    @Default(0) int daysRemaining,
  }) = _HealthMilestone;

  factory HealthMilestone.fromJson(Map<String, dynamic> json) =>
      _$HealthMilestoneFromJson(json);
}

/// Health data source information
@freezed
class HealthDataSource with _$HealthDataSource {
  const factory HealthDataSource({
    required String name,
    required String url,
    required String description,
    @Default(1.0) double reliability,
    required DateTime lastUpdated,
  }) = _HealthDataSource;

  factory HealthDataSource.fromJson(Map<String, dynamic> json) =>
      _$HealthDataSourceFromJson(json);
}

/// Health research citation
@freezed
class HealthResearchCitation with _$HealthResearchCitation {
  const factory HealthResearchCitation({
    required String title,
    required String authors,
    required String journal,
    required String doi,
    required DateTime publishedDate,
    @Default(1.0) double relevanceScore,
  }) = _HealthResearchCitation;

  factory HealthResearchCitation.fromJson(Map<String, dynamic> json) =>
      _$HealthResearchCitationFromJson(json);
}

/// Health alert or notification
@freezed
class HealthAlert with _$HealthAlert {
  const factory HealthAlert({
    required String id,
    required String title,
    required String message,
    required HealthAlertType type,
    required HealthAlertPriority priority,
    required DateTime createdAt,
    @Default(false) bool dismissed,
    String? actionUrl,
  }) = _HealthAlert;

  factory HealthAlert.fromJson(Map<String, dynamic> json) =>
      _$HealthAlertFromJson(json);
}

/// Health alert types
enum HealthAlertType {
  @JsonValue('milestone')
  milestone,
  @JsonValue('improvement')
  improvement,
  @JsonValue('warning')
  warning,
  @JsonValue('recommendation')
  recommendation,
  @JsonValue('celebration')
  celebration,
}

/// Health alert priority levels
enum HealthAlertPriority {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
  @JsonValue('urgent')
  urgent,
}

/// Health tracking metrics
@freezed
class HealthMetrics with _$HealthMetrics {
  const factory HealthMetrics({
    required String userId,
    required DateTime recordedAt,
    double? heartRate,
    double? bloodPressure,
    double? oxygenSaturation,
    double? lungCapacity,
    int? stepsCount,
    double? sleepQuality,
    int? stressLevel,
    Map<String, dynamic>? additionalMetrics,
  }) = _HealthMetrics;

  factory HealthMetrics.fromJson(Map<String, dynamic> json) =>
      _$HealthMetricsFromJson(json);
}

/// Health goal tracking
@freezed
class HealthGoal with _$HealthGoal {
  const factory HealthGoal({
    required String id,
    required String userId,
    required String title,
    required String description,
    required HealthGoalType type,
    required double targetValue,
    required double currentValue,
    required String unit,
    required DateTime targetDate,
    required DateTime createdAt,
    @Default(false) bool achieved,
    DateTime? achievedAt,
  }) = _HealthGoal;

  factory HealthGoal.fromJson(Map<String, dynamic> json) =>
      _$HealthGoalFromJson(json);
}

/// Health goal types
enum HealthGoalType {
  @JsonValue('lung_capacity')
  lungCapacity,
  @JsonValue('exercise')
  exercise,
  @JsonValue('weight')
  weight,
  @JsonValue('sleep')
  sleep,
  @JsonValue('stress')
  stress,
  @JsonValue('quit_duration')
  quitDuration,
}

/// Health recommendation from AI analysis
@freezed
class HealthRecommendation with _$HealthRecommendation {
  const factory HealthRecommendation({
    required String id,
    required String userId,
    required String title,
    required String description,
    required HealthRecommendationType type,
    required double confidenceScore,
    required List<String> evidenceSources,
    required DateTime generatedAt,
    @Default(false) bool implemented,
    DateTime? implementedAt,
    String? userFeedback,
  }) = _HealthRecommendation;

  factory HealthRecommendation.fromJson(Map<String, dynamic> json) =>
      _$HealthRecommendationFromJson(json);
}

/// Health recommendation types
enum HealthRecommendationType {
  @JsonValue('exercise')
  exercise,
  @JsonValue('nutrition')
  nutrition,
  @JsonValue('sleep')
  sleep,
  @JsonValue('stress_management')
  stressManagement,
  @JsonValue('medical_checkup')
  medicalCheckup,
  @JsonValue('nrt_adjustment')
  nrtAdjustment,
}