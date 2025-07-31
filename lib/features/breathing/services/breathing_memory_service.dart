import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/breathing_memory_optimizer.dart';
import '../utils/breathing_performance_monitor.dart';
import '../utils/breathing_resource_manager.dart';
import '../utils/breathing_audio_resource_optimizer.dart';
import '../utils/image_cache_optimizer.dart';

/// A service for managing memory optimization in breathing exercises
class BreathingMemoryService {
  /// Singleton instance
  static final BreathingMemoryService _instance = BreathingMemoryService._internal();
  
  /// Get the singleton instance
  static BreathingMemoryService get instance => _instance;
  
  /// Private constructor
  BreathingMemoryService._internal();
  
  // Whether the service is initialized
  bool _isInitialized = false;
  
  // Timer for periodic memory checks
  Timer? _memoryCheckTimer;
  
  // Memory warning listeners
  final List<VoidCallback> _memoryWarningListeners = [];
  
  // Memory usage threshold in MB
  double _memoryWarningThreshold = 150.0;
  
  /// Initialize the memory service
  Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }
    
    // Initialize components
    await BreathingPerformanceMonitor.instance.initialize();
    await BreathingMemoryOptimizer.instance.initialize();
    await BreathingResourceManager.instance.initialize();
    await BreathingAudioResourceOptimizer.instance.initialize();
    ImageCacheOptimizer.instance.initialize();
    
    // Start periodic memory checks
    _startMemoryChecks();
    
    _isInitialized = true;
  }
  
  /// Start periodic memory checks
  void _startMemoryChecks() {
    _memoryCheckTimer?.cancel();
    _memoryCheckTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      _checkMemoryUsage();
    });
  }
  
  /// Check memory usage
  void _checkMemoryUsage() {
    final currentMemoryUsage = BreathingMemoryOptimizer.instance.memoryUsage;
    
    // If memory usage is above threshold, notify listeners
    if (currentMemoryUsage > _memoryWarningThreshold) {
      _notifyMemoryWarning();
      
      // Trigger cleanup
      BreathingResourceManager.instance.releaseUnusedResources();
    }
  }
  
  /// Add a memory warning listener
  void addMemoryWarningListener(VoidCallback listener) {
    _memoryWarningListeners.add(listener);
  }
  
  /// Remove a memory warning listener
  void removeMemoryWarningListener(VoidCallback listener) {
    _memoryWarningListeners.remove(listener);
  }
  
  /// Notify listeners of memory warning
  void _notifyMemoryWarning() {
    for (final listener in _memoryWarningListeners) {
      listener();
    }
  }
  
  /// Clean up resources
  Future<void> cleanupResources() async {
    await BreathingResourceManager.instance.releaseUnusedResources();
    await BreathingAudioResourceOptimizer.instance.cleanupUnusedResources();
    ImageCacheOptimizer.instance.clearCache();
  }
  
  /// Get memory usage statistics
  Map<String, dynamic> getMemoryStats() {
    return {
      'memoryUsage': BreathingMemoryOptimizer.instance.memoryUsage,
      'activeResources': BreathingResourceManager.instance.activeResourceCount,
      'preloadingResources': BreathingResourceManager.instance.preloadingResourceCount,
      'imageCache': ImageCacheOptimizer.instance.getCacheStats(),
      'audioResources': {
        'memoryUsage': BreathingAudioResourceOptimizer.instance.memoryUsage,
        'cachedAssets': BreathingAudioResourceOptimizer.instance.cachedAssetCount,
        'activePlayers': BreathingAudioResourceOptimizer.instance.activePlayerCount,
        'avgLoadTimeMs': BreathingAudioResourceOptimizer.instance.performanceMetrics.avgLoadTimeMs,
        'avgPlaybackLatencyMs': BreathingAudioResourceOptimizer.instance.performanceMetrics.avgPlaybackLatencyMs,
      },
    };
  }
  
  /// Dispose the memory service
  void dispose() {
    _memoryCheckTimer?.cancel();
    _memoryCheckTimer = null;
    _memoryWarningListeners.clear();
    ImageCacheOptimizer.instance.restoreOriginalSettings();
    BreathingAudioResourceOptimizer.instance.dispose();
    _isInitialized = false;
  }
}