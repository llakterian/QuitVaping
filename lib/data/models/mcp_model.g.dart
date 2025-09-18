// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MCPServerConfigImpl _$$MCPServerConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$MCPServerConfigImpl(
      serverId: json['serverId'] as String,
      command: json['command'] as String,
      args: (json['args'] as List<dynamic>).map((e) => e as String).toList(),
      env: Map<String, String>.from(json['env'] as Map),
      disabled: json['disabled'] as bool? ?? false,
      autoApprove: (json['autoApprove'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$MCPServerConfigImplToJson(
        _$MCPServerConfigImpl instance) =>
    <String, dynamic>{
      'serverId': instance.serverId,
      'command': instance.command,
      'args': instance.args,
      'env': instance.env,
      'disabled': instance.disabled,
      'autoApprove': instance.autoApprove,
    };

_$MCPRequestImpl _$$MCPRequestImplFromJson(Map<String, dynamic> json) =>
    _$MCPRequestImpl(
      id: json['id'] as String,
      method: json['method'] as String,
      params: json['params'] as Map<String, dynamic>,
      serverId: json['serverId'] as String,
      timeoutSeconds: (json['timeoutSeconds'] as num?)?.toInt() ?? 30,
    );

Map<String, dynamic> _$$MCPRequestImplToJson(_$MCPRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'method': instance.method,
      'params': instance.params,
      'serverId': instance.serverId,
      'timeoutSeconds': instance.timeoutSeconds,
    };

_$MCPResponseImpl _$$MCPResponseImplFromJson(Map<String, dynamic> json) =>
    _$MCPResponseImpl(
      id: json['id'] as String,
      serverId: json['serverId'] as String,
      responseType: $enumDecode(_$MCPResponseTypeEnumMap, json['responseType']),
      data: json['data'] as Map<String, dynamic>,
      confidence: (json['confidence'] as num?)?.toDouble() ?? 1.0,
      nextActions: (json['nextActions'] as List<dynamic>?)
              ?.map(
                  (e) => RecommendedAction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      timestamp: DateTime.parse(json['timestamp'] as String),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$MCPResponseImplToJson(_$MCPResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serverId': instance.serverId,
      'responseType': _$MCPResponseTypeEnumMap[instance.responseType]!,
      'data': instance.data,
      'confidence': instance.confidence,
      'nextActions': instance.nextActions,
      'timestamp': instance.timestamp.toIso8601String(),
      'error': instance.error,
    };

const _$MCPResponseTypeEnumMap = {
  MCPResponseType.motivation: 'motivation',
  MCPResponseType.health: 'health',
  MCPResponseType.community: 'community',
  MCPResponseType.intervention: 'intervention',
  MCPResponseType.analytics: 'analytics',
  MCPResponseType.error: 'error',
};

_$RecommendedActionImpl _$$RecommendedActionImplFromJson(
        Map<String, dynamic> json) =>
    _$RecommendedActionImpl(
      actionType: json['actionType'] as String,
      description: json['description'] as String,
      parameters: json['parameters'] as Map<String, dynamic>,
      priority: (json['priority'] as num?)?.toDouble() ?? 1.0,
    );

Map<String, dynamic> _$$RecommendedActionImplToJson(
        _$RecommendedActionImpl instance) =>
    <String, dynamic>{
      'actionType': instance.actionType,
      'description': instance.description,
      'parameters': instance.parameters,
      'priority': instance.priority,
    };

_$MCPServerStatusImpl _$$MCPServerStatusImplFromJson(
        Map<String, dynamic> json) =>
    _$MCPServerStatusImpl(
      serverId: json['serverId'] as String,
      status: $enumDecode(_$MCPConnectionStatusEnumMap, json['status']),
      error: json['error'] as String?,
      lastConnected: json['lastConnected'] == null
          ? null
          : DateTime.parse(json['lastConnected'] as String),
      retryCount: (json['retryCount'] as num?)?.toInt() ?? 0,
      maxRetries: (json['maxRetries'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$MCPServerStatusImplToJson(
        _$MCPServerStatusImpl instance) =>
    <String, dynamic>{
      'serverId': instance.serverId,
      'status': _$MCPConnectionStatusEnumMap[instance.status]!,
      'error': instance.error,
      'lastConnected': instance.lastConnected?.toIso8601String(),
      'retryCount': instance.retryCount,
      'maxRetries': instance.maxRetries,
    };

const _$MCPConnectionStatusEnumMap = {
  MCPConnectionStatus.disconnected: 'disconnected',
  MCPConnectionStatus.connecting: 'connecting',
  MCPConnectionStatus.connected: 'connected',
  MCPConnectionStatus.error: 'error',
  MCPConnectionStatus.retrying: 'retrying',
};

_$AIWorkflowContextImpl _$$AIWorkflowContextImplFromJson(
        Map<String, dynamic> json) =>
    _$AIWorkflowContextImpl(
      userId: json['userId'] as String,
      currentMood: $enumDecode(_$MoodStateEnumMap, json['currentMood']),
      recentActivity: (json['recentActivity'] as List<dynamic>)
          .map((e) => UserActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
      externalFactors: ExternalFactors.fromJson(
          json['externalFactors'] as Map<String, dynamic>),
      availableInterventions: (json['availableInterventions'] as List<dynamic>)
          .map((e) => $enumDecode(_$InterventionTypeEnumMap, e))
          .toList(),
      learningData: UserLearningProfile.fromJson(
          json['learningData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AIWorkflowContextImplToJson(
        _$AIWorkflowContextImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'currentMood': _$MoodStateEnumMap[instance.currentMood]!,
      'recentActivity': instance.recentActivity,
      'externalFactors': instance.externalFactors,
      'availableInterventions': instance.availableInterventions
          .map((e) => _$InterventionTypeEnumMap[e]!)
          .toList(),
      'learningData': instance.learningData,
    };

const _$MoodStateEnumMap = {
  MoodState.positive: 'positive',
  MoodState.neutral: 'neutral',
  MoodState.negative: 'negative',
  MoodState.anxious: 'anxious',
  MoodState.motivated: 'motivated',
  MoodState.struggling: 'struggling',
};

const _$InterventionTypeEnumMap = {
  InterventionType.breathing: 'breathing',
  InterventionType.motivation: 'motivation',
  InterventionType.distraction: 'distraction',
  InterventionType.community: 'community',
  InterventionType.nrt: 'nrt',
  InterventionType.panicMode: 'panic_mode',
};

_$UserActivityImpl _$$UserActivityImplFromJson(Map<String, dynamic> json) =>
    _$UserActivityImpl(
      activityType: json['activityType'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$UserActivityImplToJson(_$UserActivityImpl instance) =>
    <String, dynamic>{
      'activityType': instance.activityType,
      'timestamp': instance.timestamp.toIso8601String(),
      'data': instance.data,
    };

_$ExternalFactorsImpl _$$ExternalFactorsImplFromJson(
        Map<String, dynamic> json) =>
    _$ExternalFactorsImpl(
      weather: json['weather'] as String?,
      location: json['location'] as String?,
      timeOfDay: json['timeOfDay'] as String?,
      additionalFactors:
          json['additionalFactors'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$ExternalFactorsImplToJson(
        _$ExternalFactorsImpl instance) =>
    <String, dynamic>{
      'weather': instance.weather,
      'location': instance.location,
      'timeOfDay': instance.timeOfDay,
      'additionalFactors': instance.additionalFactors,
    };

_$UserLearningProfileImpl _$$UserLearningProfileImplFromJson(
        Map<String, dynamic> json) =>
    _$UserLearningProfileImpl(
      interventionEffectiveness:
          (json['interventionEffectiveness'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toDouble()),
              ) ??
              const {},
      preferredInterventions:
          (json['preferredInterventions'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toInt()),
              ) ??
              const {},
      personalizedData:
          json['personalizedData'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$UserLearningProfileImplToJson(
        _$UserLearningProfileImpl instance) =>
    <String, dynamic>{
      'interventionEffectiveness': instance.interventionEffectiveness,
      'preferredInterventions': instance.preferredInterventions,
      'personalizedData': instance.personalizedData,
    };
