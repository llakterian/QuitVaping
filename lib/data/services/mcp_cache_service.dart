import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../models/mcp_model.dart';
import '../models/mcp_cache_models.dart';

/// Intelligent caching service for MCP responses with offline functionality
class MCPCacheService {
  static const String _cacheBoxName = 'mcp_cache_box';
  static const String _offlineContentBoxName = 'offline_content_box';
  static const String _syncQueueBoxName = 'sync_queue_box';
  
  // Cache expiry times for different content types
  static const Map<MCPResponseType, Duration> _cacheExpiry = {
    MCPResponseType.motivation: Duration(hours: 1),
    MCPResponseType.health: Duration(hours: 6),
    MCPResponseType.community: Duration(minutes: 30),
    MCPResponseType.intervention: Duration(minutes: 15),
    MCPResponseType.analytics: Duration(hours: 2),
    MCPResponseType.error: Duration(minutes: 5),
  };
  
  // Priority levels for different content types
  static const Map<MCPResponseType, int> _cachePriority = {
    MCPResponseType.intervention: 1, // Highest priority
    MCPResponseType.motivation: 2,
    MCPResponseType.health: 3,
    MCPResponseType.analytics: 4,
    MCPResponseType.community: 5,
    MCPResponseType.error: 6, // Lowest priority
  };

  late Box _cacheBox;
  late Box _offlineContentBox;
  late Box _syncQueueBox;
  
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  
  bool _isOnline = true;
  final StreamController<bool> _connectivityController = 
      StreamController<bool>.broadcast();
  final StreamController<MCPResponse> _syncController = 
      StreamController<MCPResponse>.broadcast();

  /// Stream of connectivity status changes
  Stream<bool> get connectivityStream => _connectivityController.stream;
  
  /// Stream of synchronized responses when connection is restored
  Stream<MCPResponse> get syncStream => _syncController.stream;
  
  /// Current connectivity status
  bool get isOnline => _isOnline;

  /// Initialize the cache service
  Future<void> initialize() async {
    // Open Hive boxes
    _cacheBox = await Hive.openBox(_cacheBoxName);
    _offlineContentBox = await Hive.openBox(_offlineContentBoxName);
    _syncQueueBox = await Hive.openBox(_syncQueueBoxName);
    
    // Initialize connectivity monitoring
    await _initializeConnectivity();
    
    // Preload offline content
    await _preloadOfflineContent();
    
    // Clean up expired cache entries
    await _cleanupExpiredCache();
    
    debugPrint('MCP Cache Service initialized');
  }

  /// Initialize connectivity monitoring
  Future<void> _initializeConnectivity() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    _isOnline = connectivityResult != ConnectivityResult.none;
    
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        final wasOnline = _isOnline;
        _isOnline = result != ConnectivityResult.none;
        
        _connectivityController.add(_isOnline);
        
        if (!wasOnline && _isOnline) {
          // Connection restored, sync queued data
          await _syncQueuedData();
        }
        
        debugPrint('Connectivity changed: ${_isOnline ? 'Online' : 'Offline'}');
      },
    );
  }

  /// Cache an MCP response with intelligent storage management
  Future<void> cacheResponse(String key, MCPResponse response) async {
    try {
      final cacheEntry = MCPCacheEntry(
        key: key,
        response: response,
        cachedAt: DateTime.now(),
        expiresAt: DateTime.now().add(_getCacheExpiry(response.responseType)),
        priority: _getCachePriority(response.responseType),
        accessCount: 1,
        lastAccessed: DateTime.now(),
      );
      
      await _cacheBox.put(key, jsonEncode(cacheEntry.toJson()));
      
      // Manage cache size
      await _manageCacheSize();
      
      debugPrint('Cached MCP response: $key (${response.responseType})');
    } catch (e) {
      debugPrint('Failed to cache MCP response: $e');
    }
  }

  /// Retrieve cached MCP response
  Future<MCPResponse?> getCachedResponse(String key) async {
    try {
      final cachedData = _cacheBox.get(key);
      if (cachedData == null) return null;
      
      final cacheEntry = MCPCacheEntry.fromJson(jsonDecode(cachedData));
      
      // Check if cache entry is expired
      if (DateTime.now().isAfter(cacheEntry.expiresAt)) {
        await _cacheBox.delete(key);
        return null;
      }
      
      // Update access statistics
      final updatedEntry = cacheEntry.copyWith(
        accessCount: cacheEntry.accessCount + 1,
        lastAccessed: DateTime.now(),
      );
      await _cacheBox.put(key, jsonEncode(updatedEntry.toJson()));
      
      debugPrint('Retrieved cached MCP response: $key');
      return cacheEntry.response;
    } catch (e) {
      debugPrint('Failed to retrieve cached response: $e');
      return null;
    }
  }

  /// Get offline fallback content for when MCP servers are unavailable
  Future<MCPResponse?> getOfflineFallback(MCPResponseType responseType, String context) async {
    try {
      final fallbackKey = '${responseType.name}_$context';
      final fallbackData = _offlineContentBox.get(fallbackKey);
      
      if (fallbackData != null) {
        final fallbackContent = OfflineFallbackContent.fromJson(jsonDecode(fallbackData));
        
        // Create a fallback MCP response
        return MCPResponse(
          id: 'offline_${DateTime.now().millisecondsSinceEpoch}',
          serverId: 'offline_fallback',
          responseType: responseType,
          data: fallbackContent.content,
          confidence: 0.7, // Lower confidence for offline content
          timestamp: DateTime.now(),
        );
      }
      
      return null;
    } catch (e) {
      debugPrint('Failed to get offline fallback: $e');
      return null;
    }
  }

  /// Queue data for synchronization when connection is restored
  Future<void> queueForSync(String operation, Map<String, dynamic> data) async {
    try {
      final syncItem = SyncQueueItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        operation: operation,
        data: data,
        queuedAt: DateTime.now(),
        retryCount: 0,
      );
      
      await _syncQueueBox.put(syncItem.id, jsonEncode(syncItem.toJson()));
      debugPrint('Queued for sync: $operation');
    } catch (e) {
      debugPrint('Failed to queue for sync: $e');
    }
  }

  /// Sync queued data when connection is restored
  Future<void> _syncQueuedData() async {
    try {
      final queuedItems = <SyncQueueItem>[];
      
      for (final key in _syncQueueBox.keys) {
        final itemData = _syncQueueBox.get(key);
        if (itemData != null) {
          queuedItems.add(SyncQueueItem.fromJson(jsonDecode(itemData)));
        }
      }
      
      if (queuedItems.isEmpty) return;
      
      debugPrint('Syncing ${queuedItems.length} queued items');
      
      for (final item in queuedItems) {
        try {
          // Process sync item based on operation type
          await _processSyncItem(item);
          
          // Remove successfully synced item
          await _syncQueueBox.delete(item.id);
          
          debugPrint('Successfully synced: ${item.operation}');
        } catch (e) {
          // Update retry count for failed items
          final updatedItem = item.copyWith(retryCount: item.retryCount + 1);
          
          if (updatedItem.retryCount < 3) {
            await _syncQueueBox.put(item.id, jsonEncode(updatedItem.toJson()));
          } else {
            // Remove items that have failed too many times
            await _syncQueueBox.delete(item.id);
            debugPrint('Removed failed sync item after 3 retries: ${item.operation}');
          }
        }
      }
    } catch (e) {
      debugPrint('Failed to sync queued data: $e');
    }
  }

  /// Process individual sync item
  Future<void> _processSyncItem(SyncQueueItem item) async {
    // This would integrate with the actual MCP client to send queued requests
    // For now, we'll simulate the sync process
    
    switch (item.operation) {
      case 'user_activity':
        // Sync user activity data
        await Future.delayed(Duration(milliseconds: 100));
        break;
      case 'craving_log':
        // Sync craving logs
        await Future.delayed(Duration(milliseconds: 100));
        break;
      case 'intervention_feedback':
        // Sync intervention feedback
        await Future.delayed(Duration(milliseconds: 100));
        break;
      default:
        debugPrint('Unknown sync operation: ${item.operation}');
    }
    
    // Emit sync event
    _syncController.add(MCPResponse(
      id: item.id,
      serverId: 'sync_service',
      responseType: MCPResponseType.analytics,
      data: {'operation': item.operation, 'status': 'synced'},
      timestamp: DateTime.now(),
    ));
  }

  /// Preload essential offline content
  Future<void> _preloadOfflineContent() async {
    try {
      // Preload motivational content
      await _preloadMotivationalContent();
      
      // Preload health recovery information
      await _preloadHealthContent();
      
      // Preload intervention strategies
      await _preloadInterventionContent();
      
      debugPrint('Offline content preloaded');
    } catch (e) {
      debugPrint('Failed to preload offline content: $e');
    }
  }

  /// Preload motivational content for offline use
  Future<void> _preloadMotivationalContent() async {
    final motivationalContent = [
      {
        'content': 'Every moment you choose not to vape is a victory for your health and future.',
        'contentType': 'motivational_message',
        'context': 'general',
      },
      {
        'content': 'You\'ve already proven you\'re stronger than your cravings. Keep going!',
        'contentType': 'motivational_message',
        'context': 'craving',
      },
      {
        'content': 'Your lungs are healing, your circulation is improving, and your future is brighter.',
        'contentType': 'health_motivation',
        'context': 'health_focus',
      },
      {
        'content': 'Take a deep breath. This craving will pass, but your strength will remain.',
        'contentType': 'intervention_message',
        'context': 'panic_mode',
      },
    ];
    
    for (final content in motivationalContent) {
      final fallbackContent = OfflineFallbackContent(
        responseType: MCPResponseType.motivation,
        content: content,
        context: content['context'] as String,
        createdAt: DateTime.now(),
      );
      
      final key = '${MCPResponseType.motivation.name}_${content['context']}';
      await _offlineContentBox.put(key, jsonEncode(fallbackContent.toJson()));
    }
  }

  /// Preload health content for offline use
  Future<void> _preloadHealthContent() async {
    final healthContent = [
      {
        'timeline': [
          {'time': '20 minutes', 'benefit': 'Heart rate and blood pressure drop'},
          {'time': '12 hours', 'benefit': 'Carbon monoxide level normalizes'},
          {'time': '2-12 weeks', 'benefit': 'Circulation improves and lung function increases'},
          {'time': '1-9 months', 'benefit': 'Coughing and shortness of breath decrease'},
        ],
        'context': 'recovery_timeline',
      },
      {
        'benefits': [
          'Improved lung capacity and breathing',
          'Better circulation and heart health',
          'Enhanced taste and smell',
          'Reduced risk of respiratory infections',
        ],
        'context': 'health_benefits',
      },
    ];
    
    for (final content in healthContent) {
      final fallbackContent = OfflineFallbackContent(
        responseType: MCPResponseType.health,
        content: content,
        context: content['context'] as String,
        createdAt: DateTime.now(),
      );
      
      final key = '${MCPResponseType.health.name}_${content['context']}';
      await _offlineContentBox.put(key, jsonEncode(fallbackContent.toJson()));
    }
  }

  /// Preload intervention content for offline use
  Future<void> _preloadInterventionContent() async {
    final interventionContent = [
      {
        'strategies': [
          {
            'type': 'breathing',
            'title': '4-7-8 Breathing',
            'instructions': 'Inhale for 4, hold for 7, exhale for 8. Repeat 4 times.',
          },
          {
            'type': 'distraction',
            'title': 'Five Senses',
            'instructions': 'Name 5 things you see, 4 you hear, 3 you feel, 2 you smell, 1 you taste.',
          },
          {
            'type': 'motivation',
            'title': 'Remember Your Why',
            'instructions': 'Think about your main reason for quitting and visualize your success.',
          },
        ],
        'context': 'craving_intervention',
      },
      {
        'emergencyStrategies': [
          'Call a supportive friend or family member',
          'Go for a walk or do light exercise',
          'Drink a large glass of water',
          'Practice deep breathing for 2 minutes',
        ],
        'context': 'panic_mode',
      },
    ];
    
    for (final content in interventionContent) {
      final fallbackContent = OfflineFallbackContent(
        responseType: MCPResponseType.intervention,
        content: content,
        context: content['context'] as String,
        createdAt: DateTime.now(),
      );
      
      final key = '${MCPResponseType.intervention.name}_${content['context']}';
      await _offlineContentBox.put(key, jsonEncode(fallbackContent.toJson()));
    }
  }

  /// Clean up expired cache entries
  Future<void> _cleanupExpiredCache() async {
    try {
      final keysToDelete = <String>[];
      final now = DateTime.now();
      
      for (final key in _cacheBox.keys) {
        final cachedData = _cacheBox.get(key);
        if (cachedData != null) {
          try {
            final cacheEntry = MCPCacheEntry.fromJson(jsonDecode(cachedData));
            if (now.isAfter(cacheEntry.expiresAt)) {
              keysToDelete.add(key);
            }
          } catch (e) {
            // Remove corrupted cache entries
            keysToDelete.add(key);
          }
        }
      }
      
      for (final key in keysToDelete) {
        await _cacheBox.delete(key);
      }
      
      if (keysToDelete.isNotEmpty) {
        debugPrint('Cleaned up ${keysToDelete.length} expired cache entries');
      }
    } catch (e) {
      debugPrint('Failed to cleanup expired cache: $e');
    }
  }

  /// Manage cache size by removing least recently used entries
  Future<void> _manageCacheSize() async {
    const maxCacheEntries = 1000;
    
    if (_cacheBox.length <= maxCacheEntries) return;
    
    try {
      final cacheEntries = <MCPCacheEntry>[];
      
      for (final key in _cacheBox.keys) {
        final cachedData = _cacheBox.get(key);
        if (cachedData != null) {
          try {
            cacheEntries.add(MCPCacheEntry.fromJson(jsonDecode(cachedData)));
          } catch (e) {
            // Remove corrupted entries
            await _cacheBox.delete(key);
          }
        }
      }
      
      // Sort by priority (lower number = higher priority) and last accessed time
      cacheEntries.sort((a, b) {
        final priorityComparison = a.priority.compareTo(b.priority);
        if (priorityComparison != 0) return priorityComparison;
        return a.lastAccessed.compareTo(b.lastAccessed);
      });
      
      // Remove least important entries
      final entriesToRemove = cacheEntries.length - maxCacheEntries;
      for (int i = cacheEntries.length - entriesToRemove; i < cacheEntries.length; i++) {
        await _cacheBox.delete(cacheEntries[i].key);
      }
      
      debugPrint('Removed $entriesToRemove cache entries to manage size');
    } catch (e) {
      debugPrint('Failed to manage cache size: $e');
    }
  }

  /// Get cache expiry duration for response type
  Duration _getCacheExpiry(MCPResponseType responseType) {
    return _cacheExpiry[responseType] ?? Duration(hours: 1);
  }

  /// Get cache priority for response type
  int _getCachePriority(MCPResponseType responseType) {
    return _cachePriority[responseType] ?? 5;
  }

  /// Get cache statistics
  Future<MCPCacheStats> getCacheStats() async {
    try {
      final stats = MCPCacheStats(
        totalEntries: _cacheBox.length,
        offlineContentEntries: _offlineContentBox.length,
        syncQueueEntries: _syncQueueBox.length,
        isOnline: _isOnline,
        lastCleanup: DateTime.now(),
      );
      
      return stats;
    } catch (e) {
      debugPrint('Failed to get cache stats: $e');
      return MCPCacheStats(
        totalEntries: 0,
        offlineContentEntries: 0,
        syncQueueEntries: 0,
        isOnline: _isOnline,
        lastCleanup: DateTime.now(),
      );
    }
  }

  /// Clear all cache data
  Future<void> clearCache() async {
    try {
      await _cacheBox.clear();
      debugPrint('Cache cleared');
    } catch (e) {
      debugPrint('Failed to clear cache: $e');
    }
  }

  /// Clear sync queue
  Future<void> clearSyncQueue() async {
    try {
      await _syncQueueBox.clear();
      debugPrint('Sync queue cleared');
    } catch (e) {
      debugPrint('Failed to clear sync queue: $e');
    }
  }

  /// Dispose of the cache service
  Future<void> dispose() async {
    await _connectivitySubscription.cancel();
    await _connectivityController.close();
    await _syncController.close();
  }
}