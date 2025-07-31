import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'breathing_performance_monitor.dart';

/// A utility class for optimizing image caching in breathing exercises
class ImageCacheOptimizer {
  /// Singleton instance
  static final ImageCacheOptimizer _instance = ImageCacheOptimizer._internal();
  
  /// Get the singleton instance
  static ImageCacheOptimizer get instance => _instance;
  
  /// Private constructor
  ImageCacheOptimizer._internal();
  
  // Original image cache size and capacity
  int? _originalMaxSizeBytes;
  int? _originalMaxSize;
  
  /// Initialize the image cache optimizer
  void initialize() {
    // Save original values
    _originalMaxSizeBytes = PaintingBinding.instance.imageCache.maximumSizeBytes;
    _originalMaxSize = PaintingBinding.instance.imageCache.maximumSize;
    
    // Set cache size based on device performance
    _setCacheSizeForDevice();
  }
  
  /// Set cache size based on device performance
  void _setCacheSizeForDevice() {
    final performanceTier = BreathingPerformanceMonitor.instance.performanceTier;
    
    switch (performanceTier) {
      case DevicePerformanceTier.high:
        // High-end devices can handle larger caches
        PaintingBinding.instance.imageCache.maximumSizeBytes = 100 * 1024 * 1024; // 100MB
        PaintingBinding.instance.imageCache.maximumSize = 200;
        break;
      case DevicePerformanceTier.medium:
        // Medium devices need moderate cache sizes
        PaintingBinding.instance.imageCache.maximumSizeBytes = 50 * 1024 * 1024; // 50MB
        PaintingBinding.instance.imageCache.maximumSize = 100;
        break;
      case DevicePerformanceTier.low:
        // Low-end devices need smaller caches
        PaintingBinding.instance.imageCache.maximumSizeBytes = 25 * 1024 * 1024; // 25MB
        PaintingBinding.instance.imageCache.maximumSize = 50;
        break;
    }
  }
  
  /// Clear the image cache
  void clearCache() {
    PaintingBinding.instance.imageCache.clear();
  }
  
  /// Evict an image from the cache
  void evictImage(String assetPath) {
    PaintingBinding.instance.imageCache.evict(AssetImage(assetPath));
  }
  
  /// Restore original cache settings
  void restoreOriginalSettings() {
    if (_originalMaxSizeBytes != null) {
      PaintingBinding.instance.imageCache.maximumSizeBytes = _originalMaxSizeBytes!;
    }
    
    if (_originalMaxSize != null) {
      PaintingBinding.instance.imageCache.maximumSize = _originalMaxSize!;
    }
  }
  
  /// Get current cache statistics
  Map<String, dynamic> getCacheStats() {
    return {
      'currentSizeBytes': PaintingBinding.instance.imageCache.currentSizeBytes,
      'currentSize': PaintingBinding.instance.imageCache.currentSize,
      'maximumSizeBytes': PaintingBinding.instance.imageCache.maximumSizeBytes,
      'maximumSize': PaintingBinding.instance.imageCache.maximumSize,
    };
  }
  
  /// Optimize image for loading
  ImageProvider optimizeImageProvider(ImageProvider provider, {double? width, double? height}) {
    if (provider is AssetImage && width != null && height != null) {
      return ResizeImage(
        provider,
        width: width.toInt(),
        height: height.toInt(),
      );
    }
    return provider;
  }
}