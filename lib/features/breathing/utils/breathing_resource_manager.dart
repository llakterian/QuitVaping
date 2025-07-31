import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'breathing_memory_optimizer.dart';
import 'breathing_performance_monitor.dart';
import 'breathing_audio_resource_optimizer.dart';

/// A utility class for managing resources used in breathing exercises
class BreathingResourceManager {
  /// Singleton instance
  static final BreathingResourceManager _instance = BreathingResourceManager._internal();
  
  /// Get the singleton instance
  static BreathingResourceManager get instance => _instance;
  
  /// Private constructor
  BreathingResourceManager._internal();
  
  // Set of currently active resources
  final Set<String> _activeResources = {};
  
  // Set of resources that are being preloaded
  final Set<String> _preloadingResources = {};
  
  // Map of resource priorities (higher number = higher priority)
  final Map<String, int> _resourcePriorities = {};
  
  // Resource loading queue
  final List<_ResourceLoadRequest> _loadQueue = [];
  
  // Whether the manager is currently processing the queue
  bool _isProcessingQueue = false;
  
  // Maximum concurrent resource loads
  int _maxConcurrentLoads = 2;
  
  /// Initialize the resource manager
  Future<void> initialize() async {
    // Set max concurrent loads based on device performance
    _setMaxConcurrentLoadsForDevice();
  }
  
  /// Set max concurrent loads based on device performance
  void _setMaxConcurrentLoadsForDevice() {
    final performanceTier = BreathingPerformanceMonitor.instance.performanceTier;
    
    switch (performanceTier) {
      case DevicePerformanceTier.high:
        _maxConcurrentLoads = 4; // More concurrent loads for high-end devices
        break;
      case DevicePerformanceTier.medium:
        _maxConcurrentLoads = 2; // Moderate concurrent loads for mid-range devices
        break;
      case DevicePerformanceTier.low:
        _maxConcurrentLoads = 1; // Single load at a time for low-end devices
        break;
    }
  }
  
  /// Register a resource as active
  void registerResource(String resourcePath, {int priority = 0}) {
    _activeResources.add(resourcePath);
    _resourcePriorities[resourcePath] = priority;
  }
  
  /// Unregister a resource
  void unregisterResource(String resourcePath) {
    _activeResources.remove(resourcePath);
    
    // If resource is no longer active, consider releasing it
    if (!_activeResources.contains(resourcePath)) {
      // Don't release immediately, let the memory optimizer handle it
      // based on its cleanup policy
    }
  }
  
  /// Preload a resource
  Future<bool> preloadResource(String resourcePath, {int priority = 0}) async {
    // If already preloading, return
    if (_preloadingResources.contains(resourcePath)) {
      return true;
    }
    
    // Register the resource
    registerResource(resourcePath, priority: priority);
    
    // Add to preloading set
    _preloadingResources.add(resourcePath);
    
    // Add to load queue
    _loadQueue.add(_ResourceLoadRequest(
      resourcePath: resourcePath,
      priority: priority,
    ));
    
    // Sort queue by priority
    _loadQueue.sort((a, b) => b.priority.compareTo(a.priority));
    
    // Start processing queue if not already processing
    if (!_isProcessingQueue) {
      _processLoadQueue();
    }
    
    // Return true to indicate request was queued
    return true;
  }
  
  /// Process the load queue
  Future<void> _processLoadQueue() async {
    if (_loadQueue.isEmpty || _isProcessingQueue) {
      return;
    }
    
    _isProcessingQueue = true;
    
    // Process up to max concurrent loads
    final batch = <_ResourceLoadRequest>[];
    while (batch.length < _maxConcurrentLoads && _loadQueue.isNotEmpty) {
      batch.add(_loadQueue.removeAt(0));
    }
    
    // Load resources in parallel
    await Future.wait(
      batch.map((request) => _loadResource(request.resourcePath)),
    );
    
    _isProcessingQueue = false;
    
    // Continue processing if there are more items in the queue
    if (_loadQueue.isNotEmpty) {
      _processLoadQueue();
    }
  }
  
  /// Load a resource
  Future<bool> _loadResource(String resourcePath) async {
    try {
      final result = await BreathingMemoryOptimizer.instance.preloadAsset(resourcePath);
      
      // Remove from preloading set
      _preloadingResources.remove(resourcePath);
      
      return result;
    } catch (e) {
      debugPrint('Error loading resource: $e');
      
      // Remove from preloading set
      _preloadingResources.remove(resourcePath);
      
      return false;
    }
  }
  
  /// Release all resources
  Future<void> releaseAllResources() async {
    // Clear active resources
    _activeResources.clear();
    
    // Clear preloading resources
    _preloadingResources.clear();
    
    // Clear load queue
    _loadQueue.clear();
    
    // Force cleanup
    await BreathingMemoryOptimizer.instance.cleanupUnusedResources();
  }
  
  /// Release unused resources
  Future<void> releaseUnusedResources() async {
    // Clean up memory resources
    await BreathingMemoryOptimizer.instance.cleanupUnusedResources();
    
    // Clean up audio resources if the audio resource optimizer is available
    try {
      // Import the audio resource optimizer dynamically to avoid circular dependencies
      // This is a safer approach than using Type.fromName
      final audioOptimizer = BreathingAudioResourceOptimizer.instance;
      await audioOptimizer.cleanupUnusedResources();
    } catch (e) {
      // Audio resource optimizer might not be initialized yet
      debugPrint('Note: Audio resource optimizer not available for cleanup: ${e.toString()}');
    }
  }
  
  /// Get a list of active resources
  List<String> get activeResources => _activeResources.toList();
  
  /// Get the number of active resources
  int get activeResourceCount => _activeResources.length;
  
  /// Get the number of preloading resources
  int get preloadingResourceCount => _preloadingResources.length;
}

/// A resource load request
class _ResourceLoadRequest {
  /// The path of the resource to load
  final String resourcePath;
  
  /// The priority of the resource (higher = more important)
  final int priority;
  
  /// Creates a new _ResourceLoadRequest
  _ResourceLoadRequest({
    required this.resourcePath,
    required this.priority,
  });
}