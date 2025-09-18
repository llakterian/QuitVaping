// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcp_feedback_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MCPServiceStatusImpl _$$MCPServiceStatusImplFromJson(
        Map<String, dynamic> json) =>
    _$MCPServiceStatusImpl(
      serviceId: json['serviceId'] as String,
      serviceName: json['serviceName'] as String,
      status: $enumDecode(_$MCPServiceHealthStatusEnumMap, json['status']),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      features: (json['features'] as List<dynamic>)
          .map((e) => MCPServiceFeature.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as String?,
      retryCount: (json['retryCount'] as num?)?.toInt() ?? 0,
      maxRetries: (json['maxRetries'] as num?)?.toInt() ?? 0,
      degradation: json['degradation'] == null
          ? null
          : MCPServiceDegradation.fromJson(
              json['degradation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MCPServiceStatusImplToJson(
        _$MCPServiceStatusImpl instance) =>
    <String, dynamic>{
      'serviceId': instance.serviceId,
      'serviceName': instance.serviceName,
      'status': _$MCPServiceHealthStatusEnumMap[instance.status]!,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'features': instance.features,
      'error': instance.error,
      'retryCount': instance.retryCount,
      'maxRetries': instance.maxRetries,
      'degradation': instance.degradation,
    };

const _$MCPServiceHealthStatusEnumMap = {
  MCPServiceHealthStatus.healthy: 'healthy',
  MCPServiceHealthStatus.connecting: 'connecting',
  MCPServiceHealthStatus.degraded: 'degraded',
  MCPServiceHealthStatus.unhealthy: 'unhealthy',
  MCPServiceHealthStatus.offline: 'offline',
  MCPServiceHealthStatus.unknown: 'unknown',
};

_$MCPServiceFeatureImpl _$$MCPServiceFeatureImplFromJson(
        Map<String, dynamic> json) =>
    _$MCPServiceFeatureImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      isEssential: json['isEssential'] as bool,
      status: $enumDecode(_$MCPFeatureStatusEnumMap, json['status']),
      statusMessage: json['statusMessage'] as String?,
    );

Map<String, dynamic> _$$MCPServiceFeatureImplToJson(
        _$MCPServiceFeatureImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'isEssential': instance.isEssential,
      'status': _$MCPFeatureStatusEnumMap[instance.status]!,
      'statusMessage': instance.statusMessage,
    };

const _$MCPFeatureStatusEnumMap = {
  MCPFeatureStatus.available: 'available',
  MCPFeatureStatus.limited: 'limited',
  MCPFeatureStatus.offline: 'offline',
  MCPFeatureStatus.unavailable: 'unavailable',
  MCPFeatureStatus.unknown: 'unknown',
};

_$MCPUserFeedbackImpl _$$MCPUserFeedbackImplFromJson(
        Map<String, dynamic> json) =>
    _$MCPUserFeedbackImpl(
      id: json['id'] as String,
      type: $enumDecode(_$MCPUserFeedbackTypeEnumMap, json['type']),
      title: json['title'] as String,
      message: json['message'] as String,
      serviceName: json['serviceName'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      priority: $enumDecode(_$MCPFeedbackPriorityEnumMap, json['priority']),
      isActionable: json['isActionable'] as bool,
      details: json['details'] == null
          ? null
          : MCPFeedbackDetails.fromJson(
              json['details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MCPUserFeedbackImplToJson(
        _$MCPUserFeedbackImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$MCPUserFeedbackTypeEnumMap[instance.type]!,
      'title': instance.title,
      'message': instance.message,
      'serviceName': instance.serviceName,
      'timestamp': instance.timestamp.toIso8601String(),
      'priority': _$MCPFeedbackPriorityEnumMap[instance.priority]!,
      'isActionable': instance.isActionable,
      'details': instance.details,
    };

const _$MCPUserFeedbackTypeEnumMap = {
  MCPUserFeedbackType.info: 'info',
  MCPUserFeedbackType.success: 'success',
  MCPUserFeedbackType.warning: 'warning',
  MCPUserFeedbackType.error: 'error',
  MCPUserFeedbackType.offline: 'offline',
  MCPUserFeedbackType.degradation: 'degradation',
};

const _$MCPFeedbackPriorityEnumMap = {
  MCPFeedbackPriority.low: 'low',
  MCPFeedbackPriority.medium: 'medium',
  MCPFeedbackPriority.high: 'high',
};

_$MCPFeedbackDetailsImpl _$$MCPFeedbackDetailsImplFromJson(
        Map<String, dynamic> json) =>
    _$MCPFeedbackDetailsImpl(
      affectedFeatures: (json['affectedFeatures'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      availableFeatures: (json['availableFeatures'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      workaround: json['workaround'] as String?,
      estimatedResolution: json['estimatedResolution'] == null
          ? null
          : DateTime.parse(json['estimatedResolution'] as String),
      technicalDetails: json['technicalDetails'] as String?,
      retryInfo: json['retryInfo'] as String?,
    );

Map<String, dynamic> _$$MCPFeedbackDetailsImplToJson(
        _$MCPFeedbackDetailsImpl instance) =>
    <String, dynamic>{
      'affectedFeatures': instance.affectedFeatures,
      'availableFeatures': instance.availableFeatures,
      'workaround': instance.workaround,
      'estimatedResolution': instance.estimatedResolution?.toIso8601String(),
      'technicalDetails': instance.technicalDetails,
      'retryInfo': instance.retryInfo,
    };

_$MCPSystemHealthImpl _$$MCPSystemHealthImplFromJson(
        Map<String, dynamic> json) =>
    _$MCPSystemHealthImpl(
      level: $enumDecode(_$MCPSystemHealthLevelEnumMap, json['level']),
      healthyServices: (json['healthyServices'] as num).toInt(),
      degradedServices: (json['degradedServices'] as num).toInt(),
      unhealthyServices: (json['unhealthyServices'] as num).toInt(),
      offlineServices: (json['offlineServices'] as num).toInt(),
      totalServices: (json['totalServices'] as num).toInt(),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$MCPSystemHealthImplToJson(
        _$MCPSystemHealthImpl instance) =>
    <String, dynamic>{
      'level': _$MCPSystemHealthLevelEnumMap[instance.level]!,
      'healthyServices': instance.healthyServices,
      'degradedServices': instance.degradedServices,
      'unhealthyServices': instance.unhealthyServices,
      'offlineServices': instance.offlineServices,
      'totalServices': instance.totalServices,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
    };

const _$MCPSystemHealthLevelEnumMap = {
  MCPSystemHealthLevel.healthy: 'healthy',
  MCPSystemHealthLevel.degraded: 'degraded',
  MCPSystemHealthLevel.critical: 'critical',
  MCPSystemHealthLevel.unknown: 'unknown',
};
