import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'breathing_performance_monitor.dart';

/// A utility class for optimizing memory usage in breathing exercises
class BreathingMemoryOptimizer {
  /// Singleton instance
  static final BreathingMemoryOptimizer _instance = BreathingMemoryOptimizer._internal();
  
  /// Get the singleton instance
  static BreathingMemoryOptimizer get instance => _instance;
  
  /// Private constructor
  BreathingMemoryOptimizer._internal();
  
  // Cache for loaded images
  final Map<String, _CachedImage> _imageCache = {};
  
  // Cache for loaded assets
  final Map<String, Uint8List> _assetCache = {};
  
  // Memory usage threshold in MB
  double _memoryThreshold = 100.0;
  
  // Current estimated memory usage in MB
  double _estimatedMemoryUsage = 0.0;
  
  // Timer for periodic cleanup
  Timer? _cleanupTimer;
  
  // Last cleanup time
  DateTime _lastCleanupTime = DateTime.now();
  
  // Listeners
  final List<VoidCallback> _memoryWarningListeners = [];
  
  /// Initialize the memory optimizer
  Future<void> initialize() async {
    // Start periodic cleanup
    _startPeriodicCleanup();
    
    // Set memory threshold based on device performance
    _setMemoryThresholdForDevice();
  }
  
  /// Set memory threshold based on device performance
  void _setMemoryThresholdForDevice() {
    final performanceTier = BreathingPerformanceMonitor.instance.performanceTier;
    
    switch (performanceTier) {
      case DevicePerformanceTier.high:
        _memoryThreshold = 200.0; // 200MB for high-end devices
        break;
      case DevicePerformanceTier.medium:
        _memoryThreshold = 100.0; // 100MB for mid-range devices
        break;
      case DevicePerformanceTier.low:
        _memoryThreshold = 50.0; // 50MB for low-end devices
        break;
    }
  }
  
  /// Start periodic cleanup of unused resources
  void _startPeriodicCleanup() {
    _cleanupTimer?.cancel();
    _cleanupTimer = Timer.periodic(const Duration(minutes: 2), (_) {
      cleanupUnusedResources();
    });
  }
  
  /// Stop periodic cleanup
  void stopPeriodicCleanup() {
    _cleanupTimer?.cancel();
    _cleanupTimer = null;
  }
  
  /// Load an image with caching
  Future<ui.Image?> loadCachedImage(String assetPath) async {
    // Check if image is already in cache
    if (_imageCache.containsKey(assetPath)) {
      final cachedImage = _imageCache[assetPath]!;
      cachedImage.lastAccessTime = DateTime.now();
      cachedImage.accessCount++;
      return cachedImage.image;
    }
    
    // Check if we need to clean up before loading new image
    if (_isMemoryUsageHigh()) {
      await cleanupUnusedResources();
    }
    
    try {
      // Load the image
      final data = await rootBundle.load(assetPath);
      final bytes = data.buffer.asUint8List();
      final codec = await ui.instantiateImageCodec(bytes);
      final frameInfo = await codec.getNextFrame();
      final image = frameInfo.image;
      
      // Estimate memory usage (width * height * 4 bytes per pixel)
      final memorySizeInMB = (image.width * image.height * 4) / (1024 * 1024);
      
      // Update estimated memory usage
      _estimatedMemoryUsage += memorySizeInMB;
      
      // Cache the image
      _imageCache[assetPath] = _CachedImage(
        image: image,
        sizeInMB: memorySizeInMB,
        lastAccessTime: DateTime.now(),
        accessCount: 1,
      );
      
      return image;
    } catch (e) {
      debugPrint('Error loading image: $e');
      return null;
    }
  }
  
  /// Preload an asset into memory
  Future<bool> preloadAsset(String assetPath) async {
    // Check if asset is already in cache
    if (_assetCache.containsKey(assetPath)) {
      return true;
    }
    
    // Check if we need to clean up before loading new asset
    if (_isMemoryUsageHigh()) {
      await cleanupUnusedResources();
    }
    
    try {
      // Load the asset
      final data = await rootBundle.load(assetPath);
      final bytes = data.buffer.asUint8List();
      
      // Estimate memory usage
      final memorySizeInMB = bytes.length / (1024 * 1024);
      
      // Update estimated memory usage
      _estimatedMemoryUsage += memorySizeInMB;
      
      // Cache the asset
      _assetCache[assetPath] = bytes;
      
      return true;
    } catch (e) {
      debugPrint('Error preloading asset: $e');
      return false;
    }
  }
  
  /// Get a preloaded asset
  Uint8List? getPreloadedAsset(String assetPath) {
    return _assetCache[assetPath];
  }
  
  /// Release a specific image from cache
  void releaseImage(String assetPath) {
    if (_imageCache.containsKey(assetPath)) {
      final cachedImage = _imageCache[assetPath]!;
      _estimatedMemoryUsage -= cachedImage.sizeInMB;
      _imageCache.remove(assetPath);
    }
  }
  
  /// Release a specific asset from cache
  void releaseAsset(String assetPath) {
    if (_assetCache.containsKey(assetPath)) {
      final bytes = _assetCache[assetPath]!;
      _estimatedMemoryUsage -= bytes.length / (1024 * 1024);
      _assetCache.remove(assetPath);
    }
  }
  
  /// Clean up unused resources
  Future<void> cleanupUnusedResources() async {
    final now = DateTime.now();
    _lastCleanupTime = now;
    
    // Clean up images that haven't been accessed in the last 5 minutes
    final imagesToRemove = <String>[];
    for (final entry in _imageCache.entries) {
      final cachedImage = entry.value;
      final minutesSinceLastAccess = now.difference(cachedImage.lastAccessTime).inMinutes;
      
      if (minutesSinceLastAccess > 5) {
        imagesToRemove.add(entry.key);
        _estimatedMemoryUsage -= cachedImage.sizeInMB;
      }
    }
    
    // Remove unused images
    for (final key in imagesToRemove) {
      _imageCache.remove(key);
    }
    
    // Clean up assets that haven't been accessed in the last 10 minutes
    final assetsToRemove = <String>[];
    for (final entry in _assetCache.entries) {
      final bytes = entry.value;
      // We don't track access time for assets, so remove based on memory pressure
      if (_isMemoryUsageHigh()) {
        assetsToRemove.add(entry.key);
        _estimatedMemoryUsage -= bytes.length / (1024 * 1024);
      }
    }
    
    // Remove unused assets
    for (final key in assetsToRemove) {
      _assetCache.remove(key);
    }
    
    // Force garbage collection if memory usage is still high
    if (_isMemoryUsageHigh()) {
      await _forceGarbageCollection();
    }
  }
  
  /// Force garbage collection
  Future<void> _forceGarbageCollection() async {
    // This is a hint to the VM to perform GC
    // It's not guaranteed to run immediately
    await Future.delayed(const Duration(milliseconds: 100));
    
    // Run multiple microtasks to encourage GC
    for (int i = 0; i < 5; i++) {
      await Future.microtask(() {});
    }
  }
  
  /// Check if memory usage is high
  bool _isMemoryUsageHigh() {
    return _estimatedMemoryUsage > _memoryThreshold;
  }
  
  /// Get current memory usage in MB
  double get memoryUsage => _estimatedMemoryUsage;
  
  /// Add a listener for memory warnings
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
  
  /// Dispose the memory optimizer
  void dispose() {
    stopPeriodicCleanup();
    _imageCache.clear();
    _assetCache.clear();
    _estimatedMemoryUsage = 0.0;
  }
}

/// A cached image with metadata
class _CachedImage {
  /// The image
  final ui.Image image;
  
  /// Size of the image in MB
  final double sizeInMB;
  
  /// Last access time
  DateTime lastAccessTime;
  
  /// Number of times the image has been accessed
  int accessCount;
  
  /// Creates a new _CachedImage
  _CachedImage({
    required this.image,
    required this.sizeInMB,
    required this.lastAccessTime,
    required this.accessCount,
  });
}