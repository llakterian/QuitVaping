// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcp_error_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MCPErrorImpl _$$MCPErrorImplFromJson(Map<String, dynamic> json) =>
    _$MCPErrorImpl(
      id: json['id'] as String,
      errorType: $enumDecode(_$MCPErrorTypeEnumMap, json['errorType']),
      message: json['message'] as String,
      userFriendlyMessage: json['userFriendlyMessage'] as String,
      serverId: json['serverId'] as String?,
      operation: json['operation'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isRetryable: json['isRetryable'] as bool? ?? false,
      retryCount: (json['retryCount'] as num?)?.toInt() ?? 0,
      maxRetries: (json['maxRetries'] as num?)?.toInt() ?? 3,
      context: json['context'] as Map<String, dynamic>?,
      recoveryOptions: (json['recoveryOptions'] as List<dynamic>?)
          ?.map((e) => MCPRecoveryOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      severity:
          $enumDecodeNullable(_$MCPErrorSeverityEnumMap, json['severity']),
    );

Map<String, dynamic> _$$MCPErrorImplToJson(_$MCPErrorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'errorType': _$MCPErrorTypeEnumMap[instance.errorType]!,
      'message': instance.message,
      'userFriendlyMessage': instance.userFriendlyMessage,
      'serverId': instance.serverId,
      'operation': instance.operation,
      'timestamp': instance.timestamp.toIso8601String(),
      'isRetryable': instance.isRetryable,
      'retryCount': instance.retryCount,
      'maxRetries': instance.maxRetries,
      'context': instance.context,
      'recoveryOptions': instance.recoveryOptions,
      'severity': _$MCPErrorSeverityEnumMap[instance.severity],
    };

const _$MCPErrorTypeEnumMap = {
  MCPErrorType.connectionFailed: 'connection_failed',
  MCPErrorType.serverUnavailable: 'server_unavailable',
  MCPErrorType.timeout: 'timeout',
  MCPErrorType.authenticationFailed: 'authentication_failed',
  MCPErrorType.rateLimited: 'rate_limited',
  MCPErrorType.invalidRequest: 'invalid_request',
  MCPErrorType.serverError: 'server_error',
  MCPErrorType.networkError: 'network_error',
  MCPErrorType.offline: 'offline',
  MCPErrorType.degradedService: 'degraded_service',
};

const _$MCPErrorSeverityEnumMap = {
  MCPErrorSeverity.low: 'low',
  MCPErrorSeverity.medium: 'medium',
  MCPErrorSeverity.high: 'high',
  MCPErrorSeverity.critical: 'critical',
};

_$MCPRecoveryOptionImpl _$$MCPRecoveryOptionImplFromJson(
        Map<String, dynamic> json) =>
    _$MCPRecoveryOptionImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      actionType:
          $enumDecode(_$MCPRecoveryActionTypeEnumMap, json['actionType']),
      parameters: json['parameters'] as Map<String, dynamic>?,
      isAutomatic: json['isAutomatic'] as bool? ?? false,
      priority: (json['priority'] as num?)?.toDouble() ?? 1.0,
    );

Map<String, dynamic> _$$MCPRecoveryOptionImplToJson(
        _$MCPRecoveryOptionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'actionType': _$MCPRecoveryActionTypeEnumMap[instance.actionType]!,
      'parameters': instance.parameters,
      'isAutomatic': instance.isAutomatic,
      'priority': instance.priority,
    };

const _$MCPRecoveryActionTypeEnumMap = {
  MCPRecoveryActionType.retry: 'retry',
  MCPRecoveryActionType.useOfflineContent: 'use_offline_content',
  MCPRecoveryActionType.switchServer: 'switch_server',
  MCPRecoveryActionType.reduceFunctionality: 'reduce_functionality',
  MCPRecoveryActionType.manualRefresh: 'manual_refresh',
  MCPRecoveryActionType.contactSupport: 'contact_support',
  MCPRecoveryActionType.checkConnection: 'check_connection',
};

_$MCPServiceDegradationImpl _$$MCPServiceDegradationImplFromJson(
        Map<String, dynamic> json) =>
    _$MCPServiceDegradationImpl(
      serviceId: json['serviceId'] as String,
      level: $enumDecode(_$MCPDegradationLevelEnumMap, json['level']),
      description: json['description'] as String,
      affectedFeatures: (json['affectedFeatures'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      availableFeatures: (json['availableFeatures'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      estimatedResolution: json['estimatedResolution'] == null
          ? null
          : DateTime.parse(json['estimatedResolution'] as String),
      workaround: json['workaround'] as String?,
    );

Map<String, dynamic> _$$MCPServiceDegradationImplToJson(
        _$MCPServiceDegradationImpl instance) =>
    <String, dynamic>{
      'serviceId': instance.serviceId,
      'level': _$MCPDegradationLevelEnumMap[instance.level]!,
      'description': instance.description,
      'affectedFeatures': instance.affectedFeatures,
      'availableFeatures': instance.availableFeatures,
      'estimatedResolution': instance.estimatedResolution?.toIso8601String(),
      'workaround': instance.workaround,
    };

const _$MCPDegradationLevelEnumMap = {
  MCPDegradationLevel.none: 'none',
  MCPDegradationLevel.minor: 'minor',
  MCPDegradationLevel.moderate: 'moderate',
  MCPDegradationLevel.major: 'major',
  MCPDegradationLevel.complete: 'complete',
};

_$MCPRetryConfigImpl _$$MCPRetryConfigImplFromJson(Map<String, dynamic> json) =>
    _$MCPRetryConfigImpl(
      errorType: $enumDecode(_$MCPErrorTypeEnumMap, json['errorType']),
      maxRetries: (json['maxRetries'] as num?)?.toInt() ?? 3,
      baseDelay: json['baseDelay'] == null
          ? const Duration(seconds: 1)
          : Duration(microseconds: (json['baseDelay'] as num).toInt()),
      backoffMultiplier: (json['backoffMultiplier'] as num?)?.toDouble() ?? 2.0,
      maxDelay: json['maxDelay'] == null
          ? const Duration(seconds: 30)
          : Duration(microseconds: (json['maxDelay'] as num).toInt()),
      jitter: (json['jitter'] as num?)?.toDouble() ?? 0.1,
      exponentialBackoff: json['exponentialBackoff'] as bool? ?? true,
    );

Map<String, dynamic> _$$MCPRetryConfigImplToJson(
        _$MCPRetryConfigImpl instance) =>
    <String, dynamic>{
      'errorType': _$MCPErrorTypeEnumMap[instance.errorType]!,
      'maxRetries': instance.maxRetries,
      'baseDelay': instance.baseDelay.inMicroseconds,
      'backoffMultiplier': instance.backoffMultiplier,
      'maxDelay': instance.maxDelay.inMicroseconds,
      'jitter': instance.jitter,
      'exponentialBackoff': instance.exponentialBackoff,
    };

_$MCPUserNotificationImpl _$$MCPUserNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$MCPUserNotificationImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      type: $enumDecode(_$MCPNotificationTypeEnumMap, json['type']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      isDismissible: json['isDismissible'] as bool? ?? false,
      displayDuration: json['displayDuration'] == null
          ? const Duration(seconds: 5)
          : Duration(microseconds: (json['displayDuration'] as num).toInt()),
      actions: (json['actions'] as List<dynamic>?)
          ?.map(
              (e) => MCPNotificationAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$MCPUserNotificationImplToJson(
        _$MCPUserNotificationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'type': _$MCPNotificationTypeEnumMap[instance.type]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'isDismissible': instance.isDismissible,
      'displayDuration': instance.displayDuration.inMicroseconds,
      'actions': instance.actions,
      'metadata': instance.metadata,
    };

const _$MCPNotificationTypeEnumMap = {
  MCPNotificationType.info: 'info',
  MCPNotificationType.warning: 'warning',
  MCPNotificationType.error: 'error',
  MCPNotificationType.success: 'success',
  MCPNotificationType.degradation: 'degradation',
};

_$MCPNotificationActionImpl _$$MCPNotificationActionImplFromJson(
        Map<String, dynamic> json) =>
    _$MCPNotificationActionImpl(
      id: json['id'] as String,
      label: json['label'] as String,
      actionType:
          $enumDecode(_$MCPRecoveryActionTypeEnumMap, json['actionType']),
      parameters: json['parameters'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$MCPNotificationActionImplToJson(
        _$MCPNotificationActionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'actionType': _$MCPRecoveryActionTypeEnumMap[instance.actionType]!,
      'parameters': instance.parameters,
    };
