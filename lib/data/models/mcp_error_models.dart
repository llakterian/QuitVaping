import 'package:freezed_annotation/freezed_annotation.dart';

part 'mcp_error_models.freezed.dart';
part 'mcp_error_models.g.dart';

/// Comprehensive error handling model for MCP operations
@freezed
class MCPError with _$MCPError {
  const factory MCPError({
    required String id,
    required MCPErrorType errorType,
    required String message,
    required String userFriendlyMessage,
    String? serverId,
    String? operation,
    required DateTime timestamp,
    @Default(false) bool isRetryable,
    @Default(0) int retryCount,
    @Default(3) int maxRetries,
    Map<String, dynamic>? context,
    List<MCPRecoveryOption>? recoveryOptions,
    MCPErrorSeverity? severity,
  }) = _MCPError;

  factory MCPError.fromJson(Map<String, dynamic> json) =>
      _$MCPErrorFromJson(json);
}

/// Types of MCP errors
enum MCPErrorType {
  @JsonValue('connection_failed')
  connectionFailed,
  @JsonValue('server_unavailable')
  serverUnavailable,
  @JsonValue('timeout')
  timeout,
  @JsonValue('authentication_failed')
  authenticationFailed,
  @JsonValue('rate_limited')
  rateLimited,
  @JsonValue('invalid_request')
  invalidRequest,
  @JsonValue('server_error')
  serverError,
  @JsonValue('network_error')
  networkError,
  @JsonValue('offline')
  offline,
  @JsonValue('degraded_service')
  degradedService,
}

/// Error severity levels
enum MCPErrorSeverity {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
  @JsonValue('critical')
  critical,
}

/// Recovery options for MCP errors
@freezed
class MCPRecoveryOption with _$MCPRecoveryOption {
  const factory MCPRecoveryOption({
    required String id,
    required String title,
    required String description,
    required MCPRecoveryActionType actionType,
    Map<String, dynamic>? parameters,
    @Default(false) bool isAutomatic,
    @Default(1.0) double priority,
  }) = _MCPRecoveryOption;

  factory MCPRecoveryOption.fromJson(Map<String, dynamic> json) =>
      _$MCPRecoveryOptionFromJson(json);
}

/// Types of recovery actions
enum MCPRecoveryActionType {
  @JsonValue('retry')
  retry,
  @JsonValue('use_offline_content')
  useOfflineContent,
  @JsonValue('switch_server')
  switchServer,
  @JsonValue('reduce_functionality')
  reduceFunctionality,
  @JsonValue('manual_refresh')
  manualRefresh,
  @JsonValue('contact_support')
  contactSupport,
  @JsonValue('check_connection')
  checkConnection,
}

/// Service degradation status
@freezed
class MCPServiceDegradation with _$MCPServiceDegradation {
  const factory MCPServiceDegradation({
    required String serviceId,
    required MCPDegradationLevel level,
    required String description,
    required List<String> affectedFeatures,
    required List<String> availableFeatures,
    DateTime? estimatedResolution,
    String? workaround,
  }) = _MCPServiceDegradation;

  factory MCPServiceDegradation.fromJson(Map<String, dynamic> json) =>
      _$MCPServiceDegradationFromJson(json);
}

/// Levels of service degradation
enum MCPDegradationLevel {
  @JsonValue('none')
  none,
  @JsonValue('minor')
  minor,
  @JsonValue('moderate')
  moderate,
  @JsonValue('major')
  major,
  @JsonValue('complete')
  complete,
}

/// Retry configuration for different error types
@freezed
class MCPRetryConfig with _$MCPRetryConfig {
  const factory MCPRetryConfig({
    required MCPErrorType errorType,
    @Default(3) int maxRetries,
    @Default(Duration(seconds: 1)) Duration baseDelay,
    @Default(2.0) double backoffMultiplier,
    @Default(Duration(seconds: 30)) Duration maxDelay,
    @Default(0.1) double jitter,
    @Default(true) bool exponentialBackoff,
  }) = _MCPRetryConfig;

  factory MCPRetryConfig.fromJson(Map<String, dynamic> json) =>
      _$MCPRetryConfigFromJson(json);
}

/// User notification for MCP errors
@freezed
class MCPUserNotification with _$MCPUserNotification {
  const factory MCPUserNotification({
    required String id,
    required String title,
    required String message,
    required MCPNotificationType type,
    required DateTime timestamp,
    @Default(false) bool isDismissible,
    @Default(Duration(seconds: 5)) Duration displayDuration,
    List<MCPNotificationAction>? actions,
    Map<String, dynamic>? metadata,
  }) = _MCPUserNotification;

  factory MCPUserNotification.fromJson(Map<String, dynamic> json) =>
      _$MCPUserNotificationFromJson(json);
}

/// Types of user notifications
enum MCPNotificationType {
  @JsonValue('info')
  info,
  @JsonValue('warning')
  warning,
  @JsonValue('error')
  error,
  @JsonValue('success')
  success,
  @JsonValue('degradation')
  degradation,
}

/// Actions available in notifications
@freezed
class MCPNotificationAction with _$MCPNotificationAction {
  const factory MCPNotificationAction({
    required String id,
    required String label,
    required MCPRecoveryActionType actionType,
    Map<String, dynamic>? parameters,
  }) = _MCPNotificationAction;

  factory MCPNotificationAction.fromJson(Map<String, dynamic> json) =>
      _$MCPNotificationActionFromJson(json);
}