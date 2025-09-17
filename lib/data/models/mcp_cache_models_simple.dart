// Simplified MCP cache models to avoid code generation issues

class BatteryOptimizationSettings {
  final bool enableBackgroundSync;
  final Duration syncInterval;
  final double lowBatteryThreshold;
  final bool reducedFunctionalityOnLowBattery;
  final Duration requestTimeout;
  final Duration cacheCleanupInterval;

  const BatteryOptimizationSettings({
    this.enableBackgroundSync = true,
    this.syncInterval = const Duration(minutes: 15),
    this.lowBatteryThreshold = 0.2,
    this.reducedFunctionalityOnLowBattery = true,
    this.requestTimeout = const Duration(seconds: 30),
    this.cacheCleanupInterval = const Duration(hours: 24),
  });
}

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
    this.isOnline = true,
    this.lastSyncTime,
    required this.lastCleanup,
  });
}

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
}

class MCPCacheEntry {
  final String key;
  final Map<String, dynamic> response;
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
    this.priority = 1,
    this.accessCount = 1,
    required this.lastAccessed,
  });

  Map<String, dynamic> toJson() => {
    'key': key,
    'response': response,
    'cachedAt': cachedAt.toIso8601String(),
    'expiresAt': expiresAt.toIso8601String(),
    'priority': priority,
    'accessCount': accessCount,
    'lastAccessed': lastAccessed.toIso8601String(),
  };

  factory MCPCacheEntry.fromJson(Map<String, dynamic> json) => MCPCacheEntry(
    key: json['key'],
    response: Map<String, dynamic>.from(json['response']),
    cachedAt: DateTime.parse(json['cachedAt']),
    expiresAt: DateTime.parse(json['expiresAt']),
    priority: json['priority'] ?? 1,
    accessCount: json['accessCount'] ?? 1,
    lastAccessed: DateTime.parse(json['lastAccessed']),
  );
}

class OfflineFallbackContent {
  final String responseType;
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
    'responseType': responseType,
    'content': content,
    'context': context,
    'createdAt': createdAt.toIso8601String(),
  };

  factory OfflineFallbackContent.fromJson(Map<String, dynamic> json) => OfflineFallbackContent(
    responseType: json['responseType'],
    content: Map<String, dynamic>.from(json['content']),
    context: json['context'],
    createdAt: DateTime.parse(json['createdAt']),
  );
}