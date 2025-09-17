import 'package:freezed_annotation/freezed_annotation.dart';

part 'analytics_models.freezed.dart';
part 'analytics_models.g.dart';

/// Analytics Data Point for tracking various metrics
@freezed
class AnalyticsDataPoint with _$AnalyticsDataPoint {
  const factory AnalyticsDataPoint({
    required String id,
    required String userId,
    required String metricType,
    required double value,
    required DateTime timestamp,
    required Map<String, dynamic> metadata,
    String? category,
    String? source,
  }) = _AnalyticsDataPoint;

  factory AnalyticsDataPoint.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsDataPointFromJson(json);
}

/// Pattern Recognition Result
@freezed
class PatternRecognitionResult with _$PatternRecognitionResult {
  const factory PatternRecognitionResult({
    required String id,
    required String userId,
    required String patternType,
    required String description,
    required double confidence,
    required DateTime detectedAt,
    required Map<String, dynamic> patternData,
    required List<String> triggers,
    required List<String> recommendations,
    @Default([]) List<AnalyticsDataPoint> supportingData,
  }) = _PatternRecognitionResult;

  factory PatternRecognitionResult.fromJson(Map<String, dynamic> json) =>
      _$PatternRecognitionResultFromJson(json);
}

/// Predictive Model Result
@freezed
class PredictiveModelResult with _$PredictiveModelResult {
  const factory PredictiveModelResult({
    required String id,
    required String userId,
    required String modelType,
    required double prediction,
    required double confidence,
    required DateTime generatedAt,
    required Map<String, dynamic> modelData,
    required List<String> influencingFactors,
    required List<String> recommendations,
    @Default([]) List<AnalyticsDataPoint> inputData,
  }) = _PredictiveModelResult;

  factory PredictiveModelResult.fromJson(Map<String, dynamic> json) =>
      _$PredictiveModelResultFromJson(json);
}

/// Personalized Report
@freezed
class PersonalizedReport with _$PersonalizedReport {
  const factory PersonalizedReport({
    required String id,
    required String userId,
    required String reportType,
    required DateTime generatedAt,
    required Map<String, dynamic> reportData,
    required List<InsightSection> sections,
    required List<String> keyFindings,
    required List<String> actionableRecommendations,
    @Default(false) bool isShareable,
  }) = _PersonalizedReport;

  factory PersonalizedReport.fromJson(Map<String, dynamic> json) =>
      _$PersonalizedReportFromJson(json);
}

/// Insight Section for reports
@freezed
class InsightSection with _$InsightSection {
  const factory InsightSection({
    required String title,
    required String content,
    required String sectionType,
    required Map<String, dynamic> data,
    @Default([]) List<String> visualizations,
    @Default([]) List<String> recommendations,
  }) = _InsightSection;

  factory InsightSection.fromJson(Map<String, dynamic> json) =>
      _$InsightSectionFromJson(json);
}

/// Analytics Workflow Context
@freezed
class AnalyticsWorkflowContext with _$AnalyticsWorkflowContext {
  const factory AnalyticsWorkflowContext({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
    required List<String> analysisTypes,
    required Map<String, dynamic> userProfile,
    @Default({}) Map<String, dynamic> preferences,
    @Default([]) List<AnalyticsDataPoint> historicalData,
  }) = _AnalyticsWorkflowContext;

  factory AnalyticsWorkflowContext.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsWorkflowContextFromJson(json);
}

/// Quit Success Prediction
@freezed
class QuitSuccessPrediction with _$QuitSuccessPrediction {
  const factory QuitSuccessPrediction({
    required String id,
    required String userId,
    required double successProbability,
    required double confidence,
    required DateTime predictionDate,
    required String timeHorizon,
    required List<String> positiveFactors,
    required List<String> riskFactors,
    required List<String> recommendations,
    required Map<String, dynamic> modelMetrics,
  }) = _QuitSuccessPrediction;

  factory QuitSuccessPrediction.fromJson(Map<String, dynamic> json) =>
      _$QuitSuccessPredictionFromJson(json);
}

/// Pattern Type Enum
enum PatternType {
  @JsonValue('craving')
  craving,
  @JsonValue('mood')
  mood,
  @JsonValue('trigger')
  trigger,
  @JsonValue('success')
  success,
  @JsonValue('relapse_risk')
  relapseRisk,
  @JsonValue('engagement')
  engagement,
  @JsonValue('progress')
  progress,
}

/// Analysis Type Enum
enum AnalysisType {
  @JsonValue('pattern_recognition')
  patternRecognition,
  @JsonValue('predictive_modeling')
  predictiveModeling,
  @JsonValue('trend_analysis')
  trendAnalysis,
  @JsonValue('behavioral_analysis')
  behavioralAnalysis,
  @JsonValue('success_factors')
  successFactors,
  @JsonValue('risk_assessment')
  riskAssessment,
}