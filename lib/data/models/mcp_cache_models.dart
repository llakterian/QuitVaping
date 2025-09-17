import 'mcp_model.dart';

/// Cache entry for MCP responses
class MCPCacheEntry {
  final String key;
  final MCPResponse response;
  final DateTime cachedAt;
  final DateTime expiresAt;
  final int priority;
  final int accessCount;
  final DateTime lastAccessed;

  const MCPCacheEntry({
    required this.key,
    required this.response,
    required this.cachedAt,
    required this.expiresAt,
    required this.priority,
    required this.accessCount,
    required this.lastAccessed,
  });

  Map<String, dynamic> toJson() => {
    'key': key,
    'response': response.toJson(),
    'cachedAt': cachedAt.toIso8601String(),
    'expiresAt': expiresAt.toIso8601String(),
    'priority': priority,
    'accessCount': accessCount,
    'lastAccessed': lastAccessed.toIso8601String(),
  };

  factory MCPCacheEntry.fromJson(Map<String, dynamic> json) => MCPCacheEntry(
    key: json['key'],
    response: MCPResponse.fromJson(json['response']),
    cachedAt: DateTime.parse(json['cachedAt']),
    expiresAt: DateTime.parse(json['expiresAt']),
    priority: json['priority'],
    accessCount: json['accessCount'],
    lastAccessed: DateTime.parse(json['lastAccessed']),
  );

  MCPCacheEntry copyWith({
    String? key,
    MCPResponse? response,
    DateTime? cachedAt,
    DateTime? expiresAt,
    int? priority,
    int? accessCount,
    DateTime? lastAccessed,
  }) => MCPCacheEntry(
    key: key ?? this.key,
    response: response ?? this.response,
    cachedAt: cachedAt ?? this.cachedAt,
    expiresAt: expiresAt ?? this.expiresAt,
    priority: priority ?? this.priority,
    accessCount: accessCount ?? this.accessCount,
    lastAccessed: lastAccessed ?? this.lastAccessed,
  );
}

/// Offline fallback content
class OfflineFallbackContent {
  final MCPResponseType responseType;
  final Map<String, dynamic> content;
  final String context;
  final DateTime createdAt;

  const OfflineFallbackContent({
    required this.responseType,
    required this.content,
    required this.context,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'responseType': responseType.name,
    'content': content,
    'context': context,
    'createdAt': createdAt.toIso8601String(),
  };

  factory OfflineFallbackContent.fromJson(Map<String, dynamic> json) => OfflineFallbackContent(
    responseType: MCPResponseType.values.firstWhere((e) => e.name == json['responseType']),
    content: Map<String, dynamic>.from(json['content']),
    context: json['context'],
    createdAt: DateTime.parse(json['createdAt']),
  );
}

/// Sync queue item for offline operations
class SyncQueueItem {
  final String id;
  final String operation;
  final Map<String, dynamic> data;
  final DateTime queuedAt;
  final int retryCount;

  const SyncQueueItem({
    required this.id,
    required this.operation,
    required this.data,
    required this.queuedAt,
    this.retryCount = 0,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'operation': operation,
    'data': data,
    'queuedAt': queuedAt.toIso8601String(),
    'retryCount': retryCount,
  };

  factory SyncQueueItem.fromJson(Map<String, dynamic> json) => SyncQueueItem(
    id: json['id'],
    operation: json['operation'],
    data: Map<String, dynamic>.from(json['data']),
    queuedAt: DateTime.parse(json['queuedAt']),
    retryCount: json['retryCount'] ?? 0,
  );

  SyncQueueItem copyWith({
    String? id,
    String? operation,
    Map<String, dynamic>? data,
    DateTime? queuedAt,
    int? retryCount,
  }) => SyncQueueItem(
    id: id ?? this.id,
    operation: operation ?? this.operation,
    data: data ?? this.data,
    queuedAt: queuedAt ?? this.queuedAt,
    retryCount: retryCount ?? this.retryCount,
  );
}

/// Cache statistics
class MCPCacheStats {
  final int totalEntries;
  final int offlineContentEntries;
  final int syncQueueEntries;
  final double cacheHitRate;
  final bool isOnline;
  final DateTime? lastSyncTime;
  final DateTime lastCleanup;

  const MCPCacheStats({
    required this.totalEntries,
    required this.offlineContentEntries,
    required this.syncQueueEntries,
    this.cacheHitRate = 0.0,
    required this.isOnline,
    this.lastSyncTime,
    required this.lastCleanup,
  });

  Map<String, dynamic> toJson() => {
    'totalEntries': totalEntries,
    'offlineContentEntries': offlineContentEntries,
    'syncQueueEntries': syncQueueEntries,
    'cacheHitRate': cacheHitRate,
    'isOnline': isOnline,
    'lastSyncTime': lastSyncTime?.toIso8601String(),
    'lastCleanup': lastCleanup.toIso8601String(),
  };

  factory MCPCacheStats.fromJson(Map<String, dynamic> json) => MCPCacheStats(
    totalEntries: json['totalEntries'],
    offlineContentEntries: json['offlineContentEntries'],
    syncQueueEntries: json['syncQueueEntries'],
    cacheHitRate: json['cacheHitRate']?.toDouble() ?? 0.0,
    isOnline: json['isOnline'],
    lastSyncTime: json['lastSyncTime'] != null ? DateTime.parse(json['lastSyncTime']) : null,
    lastCleanup: DateTime.parse(json['lastCleanup']),
  );
}

/// Battery optimization settings
class BatteryOptimizationSettings {
  final bool enableBackgroundSync;
  final Duration syncInterval;
  final Duration cacheCleanupInterval;
  final double lowBatteryThreshold;
  final bool reducedFunctionalityOnLowBattery;
  final Duration requestTimeout;

  const BatteryOptimizationSettings({
    this.enableBackgroundSync = true,
    this.syncInterval = const Duration(minutes: 15),
    this.cacheCleanupInterval = const Duration(hours: 1),
    this.lowBatteryThreshold = 0.2,
    this.reducedFunctionalityOnLowBattery = true,
    this.requestTimeout = const Duration(seconds: 30),
  });

  Map<String, dynamic> toJson() => {
    'enableBackgroundSync': enableBackgroundSync,
    'syncInterval': syncInterval.inMilliseconds,
    'cacheCleanupInterval': cacheCleanupInterval.inMilliseconds,
    'lowBatteryThreshold': lowBatteryThreshold,
    'reducedFunctionalityOnLowBattery': reducedFunctionalityOnLowBattery,
    'requestTimeout': requestTimeout.inMilliseconds,
  };

  factory BatteryOptimizationSettings.fromJson(Map<String, dynamic> json) => BatteryOptimizationSettings(
    enableBackgroundSync: json['enableBackgroundSync'] ?? true,
    syncInterval: Duration(milliseconds: json['syncInterval'] ?? 900000),
    cacheCleanupInterval: Duration(milliseconds: json['cacheCleanupInterval'] ?? 3600000),
    lowBatteryThreshold: json['lowBatteryThreshold']?.toDouble() ?? 0.2,
    reducedFunctionalityOnLowBattery: json['reducedFunctionalityOnLowBattery'] ?? true,
    requestTimeout: Duration(milliseconds: json['requestTimeout'] ?? 30000),
  );
}

/// Network optimization settings
class NetworkOptimizationSettings {
  final bool enableRequestBatching;
  final Duration batchingDelay;
  final int maxRetryAttempts;
  final Duration retryDelay;
  final bool enableCompression;
  final int maxCacheSize;

  const NetworkOptimizationSettings({
    this.enableRequestBatching = true,
    this.batchingDelay = const Duration(seconds: 5),
    this.maxRetryAttempts = 3,
    this.retryDelay = const Duration(seconds: 2),
    this.enableCompression = true,
    this.maxCacheSize = 1024 * 1024, // 1MB
  });

  Map<String, dynamic> toJson() => {
    'enableRequestBatching': enableRequestBatching,
    'batchingDelay': batchingDelay.inMilliseconds,
    'maxRetryAttempts': maxRetryAttempts,
    'retryDelay': retryDelay.inMilliseconds,
    'enableCompression': enableCompression,
    'maxCacheSize': maxCacheSize,
  };

  factory NetworkOptimizationSettings.fromJson(Map<String, dynamic> json) => NetworkOptimizationSettings(
    enableRequestBatching: json['enableRequestBatching'] ?? true,
    batchingDelay: Duration(milliseconds: json['batchingDelay'] ?? 5000),
    maxRetryAttempts: json['maxRetryAttempts'] ?? 3,
    retryDelay: Duration(milliseconds: json['retryDelay'] ?? 2000),
    enableCompression: json['enableCompression'] ?? true,
    maxCacheSize: json['maxCacheSize'] ?? 1024 * 1024,
  );
}