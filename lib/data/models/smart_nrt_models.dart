import 'package:freezed_annotation/freezed_annotation.dart';
import 'health_models.dart';

part 'smart_nrt_models.freezed.dart';
part 'smart_nrt_models.g.dart';

/// Intelligent NRT schedule with adaptive reminders and milestones
@freezed
class NRTIntelligentSchedule with _$NRTIntelligentSchedule {
  const factory NRTIntelligentSchedule({
    required String id,
    required String userId,
    required NRTProtocol protocol,
    required DateTime generatedAt,
    required List<AdaptiveReminder> adaptiveReminders,
    required List<ProgressMilestone> progressMilestones,
    @Default(false) bool isActive,
    DateTime? lastUpdated,
  }) = _NRTIntelligentSchedule;

  factory NRTIntelligentSchedule.fromJson(Map<String, dynamic> json) =>
      _$NRTIntelligentScheduleFromJson(json);
}

/// Adaptive reminder that adjusts based on user behavior and progress
@freezed
class AdaptiveReminder with _$AdaptiveReminder {
  const factory AdaptiveReminder({
    required String id,
    required String userId,
    required DateTime scheduledTime,
    required String message,
    required AdaptiveReminderType type,
    @Default(1.0) double priority,
    @Default(true) bool isActive,
    Map<String, dynamic>? adaptationData,
  }) = _AdaptiveReminder;

  factory AdaptiveReminder.fromJson(Map<String, dynamic> json) =>
      _$AdaptiveReminderFromJson(json);
}

/// Types of adaptive reminders
enum AdaptiveReminderType {
  @JsonValue('dosage')
  dosage,
  @JsonValue('reduction')
  reduction,
  @JsonValue('symptom_check')
  symptomCheck,
  @JsonValue('progress_review')
  progressReview,
  @JsonValue('motivation')
  motivation,
}

/// Progress milestone in NRT journey
@freezed
class ProgressMilestone with _$ProgressMilestone {
  const factory ProgressMilestone({
    required String id,
    required String title,
    required String description,
    required DateTime targetDate,
    required double targetValue,
    required String unit,
    @Default(false) bool achieved,
    DateTime? achievedDate,
    String? celebrationMessage,
  }) = _ProgressMilestone;

  factory ProgressMilestone.fromJson(Map<String, dynamic> json) =>
      _$ProgressMilestoneFromJson(json);
}

/// NRT reminder with intelligent scheduling
@freezed
class NRTReminder with _$NRTReminder {
  const factory NRTReminder({
    required String id,
    required String userId,
    required NRTReminderType type,
    required DateTime scheduledTime,
    required String message,
    @Default(true) bool isActive,
    @Default(false) bool isCompleted,
    DateTime? completedAt,
    String? userResponse,
  }) = _NRTReminder;

  factory NRTReminder.fromJson(Map<String, dynamic> json) =>
      _$NRTReminderFromJson(json);
}

/// Types of NRT reminders
enum NRTReminderType {
  @JsonValue('dosage')
  dosage,
  @JsonValue('reduction')
  reduction,
  @JsonValue('symptom_check')
  symptomCheck,
  @JsonValue('urgent')
  urgent,
  @JsonValue('celebration')
  celebration,
}

/// Withdrawal symptom tracking
@freezed
class WithdrawalSymptom with _$WithdrawalSymptom {
  const factory WithdrawalSymptom({
    required String id,
    required String userId,
    required WithdrawalSymptomType type,
    required int severity, // 1-10 scale
    required DateTime timestamp,
    String? notes,
    String? triggers,
    String? copingStrategy,
  }) = _WithdrawalSymptom;

  factory WithdrawalSymptom.fromJson(Map<String, dynamic> json) =>
      _$WithdrawalSymptomFromJson(json);
}

/// Types of withdrawal symptoms
enum WithdrawalSymptomType {
  @JsonValue('craving')
  craving,
  @JsonValue('irritability')
  irritability,
  @JsonValue('anxiety')
  anxiety,
  @JsonValue('difficulty_concentrating')
  difficultyConcentrating,
  @JsonValue('restlessness')
  restlessness,
  @JsonValue('sleep_disturbance')
  sleepDisturbance,
  @JsonValue('increased_appetite')
  increasedAppetite,
  @JsonValue('mood_changes')
  moodChanges,
  @JsonValue('fatigue')
  fatigue,
  @JsonValue('headache')
  headache,
}

/// Intelligent response to withdrawal symptoms
@freezed
class SymptomResponse with _$SymptomResponse {
  const factory SymptomResponse({
    required String id,
    required String userId,
    required WithdrawalSymptom symptom,
    required String message,
    required List<String> copingStrategies,
    required List<String> evidenceSources,
    @Default(false) bool requiresImmediateAction,
    @Default(false) bool requiresMedicalAttention,
    DateTime? followUpDate,
  }) = _SymptomResponse;

  factory SymptomResponse.fromJson(Map<String, dynamic> json) =>
      _$SymptomResponseFromJson(json);
}

/// Personalized dosage recommendation
@freezed
class NRTDosageRecommendation with _$NRTDosageRecommendation {
  const factory NRTDosageRecommendation({
    required String recommendedDosage,
    required String adjustment, // increase, decrease, maintain
    required double confidence, // 0.0 to 1.0
    required String reasoning,
    required DateTime nextReviewDate,
    List<String>? warnings,
    List<String>? supportingEvidence,
  }) = _NRTDosageRecommendation;

  factory NRTDosageRecommendation.fromJson(Map<String, dynamic> json) =>
      _$NRTDosageRecommendationFromJson(json);
}

/// Assessment of readiness for dosage reduction
@freezed
class NRTReadinessAssessment with _$NRTReadinessAssessment {
  const factory NRTReadinessAssessment({
    required bool isReady,
    required double readinessScore, // 0.0 to 1.0
    required List<String> reasons,
    required int recommendedWaitDays,
    List<String>? preparationSteps,
    DateTime? nextAssessmentDate,
  }) = _NRTReadinessAssessment;

  factory NRTReadinessAssessment.fromJson(Map<String, dynamic> json) =>
      _$NRTReadinessAssessmentFromJson(json);
}

/// User usage patterns analysis
@freezed
class UsagePatterns with _$UsagePatterns {
  const factory UsagePatterns({
    required List<int> preferredTimes, // Hours of day (0-23)
    required double averageDaily,
    required double consistency, // 0.0 to 1.0
    @Default([]) List<String> triggers,
    @Default([]) List<String> patterns,
  }) = _UsagePatterns;

  factory UsagePatterns.fromJson(Map<String, dynamic> json) =>
      _$UsagePatternsFromJson(json);
}

/// Medical evidence citation for NRT recommendations
@freezed
class MedicalEvidence with _$MedicalEvidence {
  const factory MedicalEvidence({
    required String title,
    required String source,
    required String summary,
    required double relevanceScore, // 0.0 to 1.0
    required DateTime publishedDate,
    String? doi,
    String? url,
  }) = _MedicalEvidence;

  factory MedicalEvidence.fromJson(Map<String, dynamic> json) =>
      _$MedicalEvidenceFromJson(json);
}

/// Safety monitoring alert for NRT usage
@freezed
class NRTSafetyAlert with _$NRTSafetyAlert {
  const factory NRTSafetyAlert({
    required String id,
    required String userId,
    required NRTSafetyAlertType type,
    required String message,
    required NRTSafetyAlertSeverity severity,
    required DateTime createdAt,
    @Default(false) bool acknowledged,
    DateTime? acknowledgedAt,
    String? userResponse,
  }) = _NRTSafetyAlert;

  factory NRTSafetyAlert.fromJson(Map<String, dynamic> json) =>
      _$NRTSafetyAlertFromJson(json);
}

/// Types of NRT safety alerts
enum NRTSafetyAlertType {
  @JsonValue('overdose_risk')
  overdoseRisk,
  @JsonValue('interaction_warning')
  interactionWarning,
  @JsonValue('side_effect_concern')
  sideEffectConcern,
  @JsonValue('usage_pattern_concern')
  usagePatternConcern,
  @JsonValue('medical_consultation_needed')
  medicalConsultationNeeded,
}

/// Severity levels for safety alerts
enum NRTSafetyAlertSeverity {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
  @JsonValue('critical')
  critical,
}

/// Comprehensive NRT progress report
@freezed
class NRTProgressReport with _$NRTProgressReport {
  const factory NRTProgressReport({
    required String userId,
    required DateTime generatedAt,
    required NRTProgressSummary summary,
    required List<NRTProgressMetric> metrics,
    required List<String> achievements,
    required List<String> recommendations,
    required double overallScore, // 0.0 to 1.0
    DateTime? nextReviewDate,
  }) = _NRTProgressReport;

  factory NRTProgressReport.fromJson(Map<String, dynamic> json) =>
      _$NRTProgressReportFromJson(json);
}

/// Summary of NRT progress
@freezed
class NRTProgressSummary with _$NRTProgressSummary {
  const factory NRTProgressSummary({
    required int daysOnNRT,
    required double initialDosage,
    required double currentDosage,
    required double reductionPercentage,
    required int symptomsReported,
    required double averageSymptomSeverity,
    required int milestonesAchieved,
  }) = _NRTProgressSummary;

  factory NRTProgressSummary.fromJson(Map<String, dynamic> json) =>
      _$NRTProgressSummaryFromJson(json);
}

/// Individual progress metric
@freezed
class NRTProgressMetric with _$NRTProgressMetric {
  const factory NRTProgressMetric({
    required String name,
    required double value,
    required String unit,
    required String trend, // improving, stable, declining
    required String description,
  }) = _NRTProgressMetric;

  factory NRTProgressMetric.fromJson(Map<String, dynamic> json) =>
      _$NRTProgressMetricFromJson(json);
}

/// NRT success prediction model
@freezed
class NRTSuccessPrediction with _$NRTSuccessPrediction {
  const factory NRTSuccessPrediction({
    required String userId,
    required double successProbability, // 0.0 to 1.0
    required List<String> positiveFactors,
    required List<String> riskFactors,
    required List<String> recommendations,
    required DateTime predictionDate,
    required int predictionHorizonDays,
  }) = _NRTSuccessPrediction;

  factory NRTSuccessPrediction.fromJson(Map<String, dynamic> json) =>
      _$NRTSuccessPredictionFromJson(json);
}