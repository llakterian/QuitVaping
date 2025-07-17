import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_model.g.dart';
part 'ai_model.freezed.dart';

@freezed
class AIChatMessage with _$AIChatMessage {
  const factory AIChatMessage({
    required String id,
    required DateTime timestamp,
    required String content,
    required String sender, // 'user' or 'ai'
    String? intent, // The detected intent of the message
    Map<String, dynamic>? metadata, // Additional data like sentiment, etc.
  }) = _AIChatMessage;

  factory AIChatMessage.fromJson(Map<String, dynamic> json) => _$AIChatMessageFromJson(json);
}

@freezed
class AIRecommendation with _$AIRecommendation {
  const factory AIRecommendation({
    required String id,
    required DateTime generatedAt,
    required String type, // 'coping_strategy', 'motivation', 'education', etc.
    required String title,
    required String content,
    required double relevanceScore, // 0.0 to 1.0
    String? triggerContext,
    Map<String, dynamic>? actionableSteps,
    required bool userRated,
    int? userRating, // 1-5 stars
  }) = _AIRecommendation;

  factory AIRecommendation.fromJson(Map<String, dynamic> json) => _$AIRecommendationFromJson(json);
}

@freezed
class AIPatternAnalysis with _$AIPatternAnalysis {
  const factory AIPatternAnalysis({
    required String id,
    required DateTime generatedAt,
    required String userId,
    required List<Map<String, dynamic>> identifiedPatterns,
    required Map<String, List<String>> triggersByCategory,
    required Map<String, double> timeOfDayDistribution,
    required List<String> mostEffectiveStrategies,
    required List<String> leastEffectiveStrategies,
    required Map<String, dynamic> customInsights,
  }) = _AIPatternAnalysis;

  factory AIPatternAnalysis.fromJson(Map<String, dynamic> json) => _$AIPatternAnalysisFromJson(json);
}