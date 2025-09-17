import 'dart:async';
import 'dart:collection';
import 'dart:isolate';
import 'package:flutter/foundation.dart';

/// Performance optimization service for MCP operations
/// 
/// This service provides intelligent performance optimizations including:
/// - Request batching and deduplication
/// - Response caching with intelligent TTL
/// - Background processing using isolates
/// - Memory management and cleanup
/// - Network request optimization
class MCPPerformanceOptimizer {
  static final MCPPerformanceOptimizer _instance = MCPPerformanceOptimizer._internal();
  factory MCPPerformanceOptimizer() => _instance;
  MCPPerformanceOptimizer._internal();

  // Request batching
  final Map<String, List<_PendingRequest>> _pendingRequests = {};
  final Map<String, Timer> _batchTimers = {};
  
  // Response caching with intelligent TTL
  final Map<String, _CachedResponse> _responseCache = {};
  final Queue<String> _cacheAccessOrder = Queue<String>();
  
  // Performance metrics
  final Map<String, _PerformanceMetrics> _metrics = {};
  
  // Configuration
  static const int _maxCacheSize = 100;
  static const Duration _batchDelay = Duration(milliseconds: 50);
  static const Duration _defaultCacheTTL = Duration(minutes: 5);
  
  /// Initialize the performance optimizer
  Future<void> initialize() async {
    debugPrint('🚀 Initializing MCP Performance Optimizer');
    
    // Start periodic cleanup
    Timer.periodic(Duration(minutes: 10), (_) => _performCleanup());
    
    // Start metrics collection
    Timer.periodic(Duration(seconds: 30), (_) => _collectMetrics());
  }

  /// Optimize a request by batching similar requests
  Future<T> optimizeRequest<T>(
    String requestType,
    String requestKey,
    Future<T> Function() requestFunction, {
    Duration? cacheTTL,
    bool enableBatching = true,
    bool enableCaching = true,
  }) async {
    final startTime = DateTime.now();
    
    try {
      // Check cache first if enabled
      if (enableCaching) {
        final cachedResult = _getCachedResponse<T>(requestKey);
        if (cachedResult != null) {
          _recordMetrics(requestType, startTime, true);
          return cachedResult;
        }
      }
      
      // Use batching if enabled
      if (enableBatching) {
        return await _batchRequest<T>(
          requestType,
          requestKey,
          requestFunction,
          cacheTTL ?? _defaultCacheTTL,
        );
      }
      
      // Execute request directly
      final result = await requestFunction();
      
      // Cache result if enabled
      if (enableCaching) {
        _cacheResponse(requestKey, result, cacheTTL ?? _defaultCacheTTL);
      }
      
      _recordMetrics(requestType, startTime, false);
      return result;
      
    } catch (e) {
      _recordMetrics(requestType, startTime, false, error: e.toString());
      rethrow;
    }
  }

  /// Batch similar requests together
  Future<T> _batchRequest<T>(
    String requestType,
    String requestKey,
    Future<T> Function() requestFunction,
    Duration cacheTTL,
  ) async {
    final completer = Completer<T>();
    final pendingRequest = _PendingRequest<T>(
      key: requestKey,
      function: requestFunction,
      completer: completer,
      cacheTTL: cacheTTL,
    );
    
    // Add to pending requests
    _pendingRequests.putIfAbsent(requestType, () => []);
    _pendingRequests[requestType]!.add(pendingRequest);
    
    // Start batch timer if not already running
    if (!_batchTimers.containsKey(requestType)) {
      _batchTimers[requestType] = Timer(_batchDelay, () => _executeBatch(requestType));
    }
    
    return completer.future;
  }

  /// Execute a batch of requests
  Future<void> _executeBatch(String requestType) async {
    final requests = _pendingRequests.remove(requestType) ?? [];
    _batchTimers.remove(requestType);
    
    if (requests.isEmpty) return;
    
    debugPrint('📦 Executing batch of ${requests.length} $requestType requests');
    
    // Group requests by key to deduplicate
    final Map<String, List<_PendingRequest>> groupedRequests = {};
    for (final request in requests) {
      groupedRequests.putIfAbsent(request.key, () => []);
      groupedRequests[request.key]!.add(request);
    }
    
    // Execute unique requests
    for (final entry in groupedRequests.entries) {
      final key = entry.key;
      final duplicateRequests = entry.value;
      final firstRequest = duplicateRequests.first;
      
      try {
        final result = await firstRequest.function();
        
        // Cache the result
        _cacheResponse(key, result, firstRequest.cacheTTL);
        
        // Complete all duplicate requests with the same result
        for (final request in duplicateRequests) {
          if (!request.completer.isCompleted) {
            request.completer.complete(result);
          }
        }
        
      } catch (e) {
        // Complete all requests with the error
        for (final request in duplicateRequests) {
          if (!request.completer.isCompleted) {
            request.completer.completeError(e);
          }
        }
      }
    }
  }

  /// Get cached response if available and not expired
  T? _getCachedResponse<T>(String key) {
    final cached = _responseCache[key];
    if (cached == null) return null;
    
    if (DateTime.now().isAfter(cached.expiresAt)) {
      _responseCache.remove(key);
      _cacheAccessOrder.remove(key);
      return null;
    }
    
    // Update access order for LRU
    _cacheAccessOrder.remove(key);
    _cacheAccessOrder.addLast(key);
    
    return cached.data as T?;
  }

  /// Cache a response with TTL
  void _cacheResponse<T>(String key, T data, Duration ttl) {
    // Remove oldest entries if cache is full
    while (_responseCache.length >= _maxCacheSize && _cacheAccessOrder.isNotEmpty) {
      final oldestKey = _cacheAccessOrder.removeFirst();
      _responseCache.remove(oldestKey);
    }
    
    _responseCache[key] = _CachedResponse(
      data: data,
      expiresAt: DateTime.now().add(ttl),
    );
    
    _cacheAccessOrder.addLast(key);
  }

  /// Record performance metrics
  void _recordMetrics(String requestType, DateTime startTime, bool cacheHit, {String? error}) {
    final duration = DateTime.now().difference(startTime);
    
    _metrics.putIfAbsent(requestType, () => _PerformanceMetrics());
    final metrics = _metrics[requestType]!;
    
    metrics.totalRequests++;
    metrics.totalDuration += duration;
    
    if (cacheHit) {
      metrics.cacheHits++;
    }
    
    if (error != null) {
      metrics.errors++;
    }
    
    // Track response times
    if (metrics.responseTimes.length >= 100) {
      metrics.responseTimes.removeFirst();
    }
    metrics.responseTimes.addLast(duration);
  }

  /// Get performance statistics
  Map<String, Map<String, dynamic>> getPerformanceStats() {
    final stats = <String, Map<String, dynamic>>{};
    
    for (final entry in _metrics.entries) {
      final requestType = entry.key;
      final metrics = entry.value;
      
      final avgDuration = metrics.totalRequests > 0 
          ? metrics.totalDuration.inMilliseconds / metrics.totalRequests
          : 0.0;
      
      final cacheHitRate = metrics.totalRequests > 0
          ? (metrics.cacheHits / metrics.totalRequests * 100)
          : 0.0;
      
      final errorRate = metrics.totalRequests > 0
          ? (metrics.errors / metrics.totalRequests * 100)
          : 0.0;
      
      // Calculate percentiles
      final sortedTimes = metrics.responseTimes.toList()
        ..sort((a, b) => a.inMilliseconds.compareTo(b.inMilliseconds));
      
      final p50 = _getPercentile(sortedTimes, 0.5);
      final p95 = _getPercentile(sortedTimes, 0.95);
      final p99 = _getPercentile(sortedTimes, 0.99);
      
      stats[requestType] = {
        'totalRequests': metrics.totalRequests,
        'averageResponseTime': avgDuration,
        'cacheHitRate': cacheHitRate,
        'errorRate': errorRate,
        'p50ResponseTime': p50?.inMilliseconds ?? 0,
        'p95ResponseTime': p95?.inMilliseconds ?? 0,
        'p99ResponseTime': p99?.inMilliseconds ?? 0,
      };
    }
    
    return stats;
  }

  /// Calculate percentile from sorted durations
  Duration? _getPercentile(List<Duration> sortedTimes, double percentile) {
    if (sortedTimes.isEmpty) return null;
    
    final index = (sortedTimes.length * percentile).floor();
    return sortedTimes[index.clamp(0, sortedTimes.length - 1)];
  }

  /// Perform periodic cleanup
  void _performCleanup() {
    final now = DateTime.now();
    final expiredKeys = <String>[];
    
    // Find expired cache entries
    for (final entry in _responseCache.entries) {
      if (now.isAfter(entry.value.expiresAt)) {
        expiredKeys.add(entry.key);
      }
    }
    
    // Remove expired entries
    for (final key in expiredKeys) {
      _responseCache.remove(key);
      _cacheAccessOrder.remove(key);
    }
    
    if (expiredKeys.isNotEmpty) {
      debugPrint('🧹 Cleaned up ${expiredKeys.length} expired cache entries');
    }
  }

  /// Collect and log performance metrics
  void _collectMetrics() {
    final stats = getPerformanceStats();
    
    if (stats.isNotEmpty) {
      debugPrint('📊 MCP Performance Metrics:');
      for (final entry in stats.entries) {
        final type = entry.key;
        final metrics = entry.value;
        debugPrint('  $type: ${metrics['totalRequests']} requests, '
                  '${metrics['averageResponseTime'].toStringAsFixed(1)}ms avg, '
                  '${metrics['cacheHitRate'].toStringAsFixed(1)}% cache hit rate');
      }
    }
  }

  /// Clear all caches and reset metrics
  void reset() {
    _responseCache.clear();
    _cacheAccessOrder.clear();
    _metrics.clear();
    _pendingRequests.clear();
    
    for (final timer in _batchTimers.values) {
      timer.cancel();
    }
    _batchTimers.clear();
    
    debugPrint('🔄 MCP Performance Optimizer reset');
  }
}

/// Represents a pending request in a batch
class _PendingRequest<T> {
  final String key;
  final Future<T> Function() function;
  final Completer<T> completer;
  final Duration cacheTTL;
  
  _PendingRequest({
    required this.key,
    required this.function,
    required this.completer,
    required this.cacheTTL,
  });
}

/// Represents a cached response with expiration
class _CachedResponse {
  final dynamic data;
  final DateTime expiresAt;
  
  _CachedResponse({
    required this.data,
    required this.expiresAt,
  });
}

/// Performance metrics for a request type
class _PerformanceMetrics {
  int totalRequests = 0;
  int cacheHits = 0;
  int errors = 0;
  Duration totalDuration = Duration.zero;
  final Queue<Duration> responseTimes = Queue<Duration>();
}