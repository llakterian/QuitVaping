import 'package:freezed_annotation/freezed_annotation.dart';

part 'motivation_model.freezed.dart';
part 'motivation_model.g.dart';

/// Motivational Content Model
@freezed
class MotivationalContent with _$MotivationalContent {
  const factory MotivationalContent({
    required String id,
    required DateTime timestamp,
    required String type, // 'daily', 'mood_based', 'milestone', 'intervention'
    required String title,
    required String content,
    String? imageUrl,
    @Default([]) List<String> tags,
    @Default(1.0) double relevanceScore,
    Map<String, dynamic>? metadata,
  }) = _MotivationalContent;

  factory MotivationalContent.fromJson(Map<String, dynamic> json) =>
      _$MotivationalContentFromJson(json);
}

/// Milestone Event Model
@freezed
class MilestoneEvent with _$MilestoneEvent {
  const factory MilestoneEvent({
    required String id,
    required DateTime timestamp,
    required String milestoneKey,
    required String title,
    required String message,
    String? celebrationImageUrl,
    @Default({}) Map<String, dynamic> milestone,
  }) = _MilestoneEvent;

  factory MilestoneEvent.fromJson(Map<String, dynamic> json) =>
      _$MilestoneEventFromJson(json);
}