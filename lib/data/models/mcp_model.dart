import 'package:freezed_annotation/freezed_annotation.dart';

part 'mcp_model.freezed.dart';
part 'mcp_model.g.dart';

/// MCP Server Configuration
@freezed
class MCPServerConfig with _$MCPServerConfig {
  const factory MCPServerConfig({
    required String serverId,
    required String command,
    required List<String> args,
    required Map<String, String> env,
    @Default(false) bool disabled,
    @Default([]) List<String> autoApprove,
  }) = _MCPServerConfig;

  factory MCPServerConfig.fromJson(Map<String, dynamic> json) =>
      _$MCPServerConfigFromJson(json);
}

/// MCP Request
@freezed
class MCPRequest with _$MCPRequest {
  const factory MCPRequest({
    required String id,
    required String method,
    required Map<String, dynamic> params,
    required String serverId,
    @Default(30) int timeoutSeconds,
  }) = _MCPRequest;

  factory MCPRequest.fromJson(Map<String, dynamic> json) =>
      _$MCPRequestFromJson(json);
}

/// MCP Response
@freezed
class MCPResponse with _$MCPResponse {
  const factory MCPResponse({
    required String id,
    required String serverId,
    required MCPResponseType responseType,
    required Map<String, dynamic> data,
    @Default(1.0) double confidence,
    @Default([]) List<RecommendedAction> nextActions,
    required DateTime timestamp,
    String? error,
  }) = _MCPResponse;

  factory MCPResponse.fromJson(Map<String, dynamic> json) =>
      _$MCPResponseFromJson(json);
}

/// MCP Response Types
enum MCPResponseType {
  @JsonValue('motivation')
  motivation,
  @JsonValue('health')
  health,
  @JsonValue('community')
  community,
  @JsonValue('intervention')
  intervention,
  @JsonValue('analytics')
  analytics,
  @JsonValue('error')
  error,
}

/// Recommended Action
@freezed
class RecommendedAction with _$RecommendedAction {
  const factory RecommendedAction({
    required String actionType,
    required String description,
    required Map<String, dynamic> parameters,
    @Default(1.0) double priority,
  }) = _RecommendedAction;

  factory RecommendedAction.fromJson(Map<String, dynamic> json) =>
      _$RecommendedActionFromJson(json);
}

/// MCP Connection Status
enum MCPConnectionStatus {
  disconnected,
  connecting,
  connected,
  error,
  retrying,
}

/// MCP Server Status
@freezed
class MCPServerStatus with _$MCPServerStatus {
  const factory MCPServerStatus({
    required String serverId,
    required MCPConnectionStatus status,
    String? error,
    DateTime? lastConnected,
    @Default(0) int retryCount,
    @Default(0) int maxRetries,
  }) = _MCPServerStatus;

  factory MCPServerStatus.fromJson(Map<String, dynamic> json) =>
      _$MCPServerStatusFromJson(json);
}

/// AI Workflow Context for MCP requests
@freezed
class AIWorkflowContext with _$AIWorkflowContext {
  const factory AIWorkflowContext({
    required String userId,
    required MoodState currentMood,
    required List<UserActivity> recentActivity,
    required ExternalFactors externalFactors,
    required List<InterventionType> availableInterventions,
    required UserLearningProfile learningData,
  }) = _AIWorkflowContext;

  factory AIWorkflowContext.fromJson(Map<String, dynamic> json) =>
      _$AIWorkflowContextFromJson(json);
}

/// Mood State
enum MoodState {
  @JsonValue('positive')
  positive,
  @JsonValue('neutral')
  neutral,
  @JsonValue('negative')
  negative,
  @JsonValue('anxious')
  anxious,
  @JsonValue('motivated')
  motivated,
  @JsonValue('struggling')
  struggling,
}

/// User Activity
@freezed
class UserActivity with _$UserActivity {
  const factory UserActivity({
    required String activityType,
    required DateTime timestamp,
    required Map<String, dynamic> data,
  }) = _UserActivity;

  factory UserActivity.fromJson(Map<String, dynamic> json) =>
      _$UserActivityFromJson(json);
}

/// External Factors
@freezed
class ExternalFactors with _$ExternalFactors {
  const factory ExternalFactors({
    String? weather,
    String? location,
    String? timeOfDay,
    @Default({}) Map<String, dynamic> additionalFactors,
  }) = _ExternalFactors;

  factory ExternalFactors.fromJson(Map<String, dynamic> json) =>
      _$ExternalFactorsFromJson(json);
}

/// Intervention Type
enum InterventionType {
  @JsonValue('breathing')
  breathing,
  @JsonValue('motivation')
  motivation,
  @JsonValue('distraction')
  distraction,
  @JsonValue('community')
  community,
  @JsonValue('nrt')
  nrt,
  @JsonValue('panic_mode')
  panicMode,
}

/// User Learning Profile
@freezed
class UserLearningProfile with _$UserLearningProfile {
  const factory UserLearningProfile({
    @Default({}) Map<String, double> interventionEffectiveness,
    @Default({}) Map<String, int> preferredInterventions,
    @Default({}) Map<String, dynamic> personalizedData,
  }) = _UserLearningProfile;

  factory UserLearningProfile.fromJson(Map<String, dynamic> json) =>
      _$UserLearningProfileFromJson(json);
}