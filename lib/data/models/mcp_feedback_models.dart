import 'package:freezed_annotation/freezed_annotation.dart';

import 'mcp_error_models.dart';

part 'mcp_feedback_models.freezed.dart';
part 'mcp_feedback_models.g.dart';

/// Service status model
@freezed
class MCPServiceStatus with _$MCPServiceStatus {
  const factory MCPServiceStatus({
    required String serviceId,
    required String serviceName,
    required MCPServiceHealthStatus status,
    required DateTime lastUpdated,
    required List<MCPServiceFeature> features,
    String? error,
    @Default(0) int retryCount,
    @Default(0) int maxRetries,
    MCPServiceDegradation? degradation,
  }) = _MCPServiceStatus;

  factory MCPServiceStatus.fromJson(Map<String, dynamic> json) =>
      _$MCPServiceStatusFromJson(json);
}

/// Service health status
enum MCPServiceHealthStatus {
  @JsonValue('healthy')
  healthy,
  @JsonValue('connecting')
  connecting,
  @JsonValue('degraded')
  degraded,
  @JsonValue('unhealthy')
  unhealthy,
  @JsonValue('offline')
  offline,
  @JsonValue('unknown')
  unknown,
}

/// Service feature model
@freezed
class MCPServiceFeature with _$MCPServiceFeature {
  const factory MCPServiceFeature({
    required String id,
    required String name,
    required String description,
    required bool isEssential,
    required MCPFeatureStatus status,
    String? statusMessage,
  }) = _MCPServiceFeature;

  factory MCPServiceFeature.fromJson(Map<String, dynamic> json) =>
      _$MCPServiceFeatureFromJson(json);
}

/// Feature status
enum MCPFeatureStatus {
  @JsonValue('available')
  available,
  @JsonValue('limited')
  limited,
  @JsonValue('offline')
  offline,
  @JsonValue('unavailable')
  unavailable,
  @JsonValue('unknown')
  unknown,
}

/// User feedback model
@freezed
class MCPUserFeedback with _$MCPUserFeedback {
  const factory MCPUserFeedback({
    required String id,
    required MCPUserFeedbackType type,
    required String title,
    required String message,
    required String serviceName,
    required DateTime timestamp,
    required MCPFeedbackPriority priority,
    required bool isActionable,
    MCPFeedbackDetails? details,
  }) = _MCPUserFeedback;

  factory MCPUserFeedback.fromJson(Map<String, dynamic> json) =>
      _$MCPUserFeedbackFromJson(json);
}

/// User feedback type
enum MCPUserFeedbackType {
  @JsonValue('info')
  info,
  @JsonValue('success')
  success,
  @JsonValue('warning')
  warning,
  @JsonValue('error')
  error,
  @JsonValue('offline')
  offline,
  @JsonValue('degradation')
  degradation,
}

/// Feedback priority
enum MCPFeedbackPriority {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
}

/// Feedback details
@freezed
class MCPFeedbackDetails with _$MCPFeedbackDetails {
  const factory MCPFeedbackDetails({
    List<String>? affectedFeatures,
    List<String>? availableFeatures,
    String? workaround,
    DateTime? estimatedResolution,
    String? technicalDetails,
    String? retryInfo,
  }) = _MCPFeedbackDetails;

  factory MCPFeedbackDetails.fromJson(Map<String, dynamic> json) =>
      _$MCPFeedbackDetailsFromJson(json);
}

/// System health model
@freezed
class MCPSystemHealth with _$MCPSystemHealth {
  const factory MCPSystemHealth({
    required MCPSystemHealthLevel level,
    required int healthyServices,
    required int degradedServices,
    required int unhealthyServices,
    required int offlineServices,
    required int totalServices,
    required DateTime lastUpdated,
  }) = _MCPSystemHealth;

  factory MCPSystemHealth.fromJson(Map<String, dynamic> json) =>
      _$MCPSystemHealthFromJson(json);
}

/// System health level
enum MCPSystemHealthLevel {
  @JsonValue('healthy')
  healthy,
  @JsonValue('degraded')
  degraded,
  @JsonValue('critical')
  critical,
  @JsonValue('unknown')
  unknown,
}