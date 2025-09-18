// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcp_cache_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MCPCacheEntryImpl _$$MCPCacheEntryImplFromJson(Map<String, dynamic> json) =>
    _$MCPCacheEntryImpl(
      key: json['key'] as String,
      response: MCPResponse.fromJson(json['response'] as Map<String, dynamic>),
      cachedAt: DateTime.parse(json['cachedAt'] as String),
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      priority: json['priority'] as int,
      accessCount: json['accessCount'] as int,
      lastAccessed: DateTime.parse(json['lastAccessed'] as String),
    );

Map<String, dynamic> _$$MCPCacheEntryImplToJson(_$MCPCacheEntryImpl instance) =>
    <String, dynamic>{
      'key': instance.key,
      'response': instance.response,
      'cachedAt': instance.cachedAt.toIso8601String(),
      'expiresAt': instance.expiresAt.toIso8601String(),
      'priority': instance.priority,
      'accessCount': instance.accessCount,
      'lastAccessed': instance.lastAccessed.toIso8601String(),
    };

_$OfflineFallbackContentImpl _$$OfflineFallbackContentImplFromJson(
        Map<String, dynamic> json) =>
    _$OfflineFallbackContentImpl(
      responseType: $enumDecode(_$MCPResponseTypeEnumMap, json['responseType']),
      content: json['content'] as Map<String, dynamic>,
      context: json['context'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$OfflineFallbackContentImplToJson(
        _$OfflineFallbackContentImpl instance) =>
    <String, dynamic>{
      'responseType': _$MCPResponseTypeEnumMap[instance.responseType]!,
      'content': instance.content,
      'context': instance.context,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$MCPResponseTypeEnumMap = {
  MCPResponseType.motivation: 'motivation',
  MCPResponseType.health: 'health',
  MCPResponseType.community: 'community',
  MCPResponseType.intervention: 'intervention',
  MCPResponseType.analytics: 'analytics',
  MCPResponseType.error: 'error',
};

_$SyncQueueItemImpl _$$SyncQueueItemImplFromJson(Map<String, dynamic> json) =>
    _$SyncQueueItemImpl(
      id: json['id'] as String,
      operation: json['operation'] as String,
      data: json['data'] as Map<String, dynamic>,
      timestamp: DateTime.parse(json['timestamp'] as String),
      retryCount: json['retryCount'] as int,
    );

Map<String, dynamic> _$$SyncQueueItemImplToJson(_$SyncQueueItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'operation': instance.operation,
      'data': instance.data,
      'timestamp': instance.timestamp.toIso8601String(),
      'retryCount': instance.retryCount,
    };

_$MCPCacheStatsImpl _$$MCPCacheStatsImplFromJson(Map<String, dynamic> json) =>
    _$MCPCacheStatsImpl(
      totalEntries: json['totalEntries'] as int,
      offlineContentEntries: json['offlineContentEntries'] as int,
      syncQueueEntries: json['syncQueueEntries'] as int,
      isOnline: json['isOnline'] as bool,
      lastCleanup: DateTime.parse(json['lastCleanup'] as String),
    );

Map<String, dynamic> _$$MCPCacheStatsImplToJson(_$MCPCacheStatsImpl instance) =>
    <String, dynamic>{
      'totalEntries': instance.totalEntries,
      'offlineContentEntries': instance.offlineContentEntries,
      'syncQueueEntries': instance.syncQueueEntries,
      'isOnline': instance.isOnline,
      'lastCleanup': instance.lastCleanup.toIso8601String(),
    };

_$BatteryOptimizationSettingsImpl _$$BatteryOptimizationSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$BatteryOptimizationSettingsImpl(
      enableBackgroundSync: json['enableBackgroundSync'] as bool? ?? true,
      syncInterval: json['syncInterval'] == null
          ? const Duration(minutes: 15)
          : Duration(microseconds: json['syncInterval'] as int),
      cacheCleanupInterval: json['cacheCleanupInterval'] == null
          ? const Duration(hours: 1)
          : Duration(microseconds: json['cacheCleanupInterval'] as int),
      lowBatteryThreshold:
          (json['lowBatteryThreshold'] as num?)?.toDouble() ?? 0.2,
      reducedFunctionalityOnLowBattery:
          json['reducedFunctionalityOnLowBattery'] as bool? ?? true,
      requestTimeout: json['requestTimeout'] == null
          ? const Duration(seconds: 30)
          : Duration(microseconds: json['requestTimeout'] as int),
    );

Map<String, dynamic> _$$BatteryOptimizationSettingsImplToJson(
        _$BatteryOptimizationSettingsImpl instance) =>
    <String, dynamic>{
      'enableBackgroundSync': instance.enableBackgroundSync,
      'syncInterval': instance.syncInterval.inMicroseconds,
      'cacheCleanupInterval': instance.cacheCleanupInterval.inMicroseconds,
      'lowBatteryThreshold': instance.lowBatteryThreshold,
      'reducedFunctionalityOnLowBattery':
          instance.reducedFunctionalityOnLowBattery,
      'requestTimeout': instance.requestTimeout.inMicroseconds,
    };

_$NetworkOptimizationSettingsImpl _$$NetworkOptimizationSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$NetworkOptimizationSettingsImpl(
      enableRequestBatching: json['enableRequestBatching'] as bool? ?? true,
      batchingDelay: json['batchingDelay'] == null
          ? const Duration(seconds: 5)
          : Duration(microseconds: json['batchingDelay'] as int),
      maxRetryAttempts: json['maxRetryAttempts'] as int? ?? 3,
      retryDelay: json['retryDelay'] == null
          ? const Duration(seconds: 2)
          : Duration(microseconds: json['retryDelay'] as int),
      enableCompression: json['enableCompression'] as bool? ?? true,
      maxCacheSize: json['maxCacheSize'] as int? ?? 1048576,
    );

Map<String, dynamic> _$$NetworkOptimizationSettingsImplToJson(
        _$NetworkOptimizationSettingsImpl instance) =>
    <String, dynamic>{
      'enableRequestBatching': instance.enableRequestBatching,
      'batchingDelay': instance.batchingDelay.inMicroseconds,
      'maxRetryAttempts': instance.maxRetryAttempts,
      'retryDelay': instance.retryDelay.inMicroseconds,
      'enableCompression': instance.enableCompression,
      'maxCacheSize': instance.maxCacheSize,
    };