import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/breathing_audio_resource_optimizer.dart';
import '../utils/breathing_memory_optimizer.dart';
import '../utils/breathing_performance_monitor.dart';
import '../utils/breathing_resource_manager.dart';
import '../utils/image_cache_optimizer.dart';

/// A service that coordinates all optimization components for breathing exercises
class BreathingOptimizationService {
  /// Singleton instance
  static final BreathingOptimizationService _instance = BreathingOptimizationService._internal();
  
  /// Get the singleton instance
  static BreathingOptimizationService get instance => _instance;
  
  /// Private constructor
  BreathingOptimizationService._internal();
  
  // Whether the service is initialized
  bool _isInitialized = false;
  
  // Timer for periodic optimization
  Timer? _optimizationTimer;
  
  // Performance metrics
  PerformanceMetrics? _lastMetrics;
  
  // Listeners for optimization events
  final List<Function(OptimizationEvent)> _listeners = [];
  
  /// Initialize the optimization service
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      // Initialize performance monitor first to detect device capabilities
      await BreathingPerformanceMonitor.instance.initialize();
      
      // Initialize memory optimizer
      await BreathingMemoryOptimizer.instance.initialize();
      
      // Initialize resource manager
      await BreathingResourceManager.instance.initialize();
      
      // Initialize audio resource optimizer
      await BreathingAudioResourceOptimizer.instance.initialize();
      
      // Initialize image cache optimizer
      ImageCacheOptimizer.instance.initialize();
      
      // Start performance monitoring
      BreathingPerformanceMonitor.instance.startMonitoring();
      BreathingPerformanceMonitor.instance.addListener(_onPerformanceUpdate);
      
      // Start periodic optimization
      _startPeriodicOptimization();
      
      _isInitialized = true;
      
      // Notify listeners
      _notifyListeners(OptimizationEvent.initialized);
    } catch (e) {
      debugPrint('Error initializing optimization service: $e');
      rethrow;
    }
  }
  
  /// Start periodic optimization
  void _startPeriodicOptimization() {
    _optimizationTimer?.cancel();
    _optimizationTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      _runOptimization();
    });
  }
  
  /// Run optimization tasks
  Future<OptimizationResult?> _runOptimization() async {
    if (!_isInitialized) return null;
    
    try {
      // Notify listeners
      _notifyListeners(OptimizationEvent.optimizationStarted);
      
      // Clean up unused resources
      await BreathingResourceManager.instance.releaseUnusedResources();
      
      // Run performance test
      final profile = await BreathingPerformanceMonitor.instance.runPerformanceTest();
      
      // Get recommended settings
      final settings = BreathingPerformanceMonitor.instance.getRecommendedSettings();
      
      // Notify listeners
      _notifyListeners(OptimizationEvent.optimizationCompleted);
      
      return OptimizationResult(
        memoryUsage: BreathingMemoryOptimizer.instance.memoryUsage,
        performanceProfile: profile,
        recommendedSettings: settings,
      );
    } catch (e) {
      debugPrint('Error running optimization: $e');
      
      // Notify listeners
      _notifyListeners(OptimizationEvent.optimizationFailed);
      
      return null;
    }
  }
  
  /// Handle performance updates
  void _onPerformanceUpdate(PerformanceMetrics metrics) {
    _lastMetrics = metrics;
    
    // Check if memory usage is high
    if (metrics.memoryUsage > 150) { // 150MB threshold
      // Run cleanup
      BreathingResourceManager.instance.releaseUnusedResources();
      
      // Notify listeners
      _notifyListeners(OptimizationEvent.highMemoryUsage);
    }
    
    // Check if frame rate is low
    if (metrics.frameRate < 30) {
      // Notify listeners
      _notifyListeners(OptimizationEvent.lowFrameRate);
    }
  }
  
  /// Add a listener for optimization events
  void addListener(Function(OptimizationEvent) listener) {
    _listeners.add(listener);
  }
  
  /// Remove a listener
  void removeListener(Function(OptimizationEvent) listener) {
    _listeners.remove(listener);
  }
  
  /// Notify listeners of an event
  void _notifyListeners(OptimizationEvent event) {
    for (final listener in _listeners) {
      listener(event);
    }
  }
  
  /// Get the last performance metrics
  PerformanceMetrics? get lastMetrics => _lastMetrics;
  
  /// Get optimization statistics
  OptimizationStats getOptimizationStats() {
    return OptimizationStats(
      memoryUsage: BreathingMemoryOptimizer.instance.memoryUsage,
      activeResourceCount: BreathingResourceManager.instance.activeResourceCount,
      cachedAudioAssetCount: BreathingAudioResourceOptimizer.instance.cachedAssetCount,
      activeAudioPlayerCount: BreathingAudioResourceOptimizer.instance.activePlayerCount,
      performanceTier: BreathingPerformanceMonitor.instance.performanceTier,
      frameRate: _lastMetrics?.frameRate ?? 0.0,
      cpuUsage: _lastMetrics?.cpuUsage ?? 0.0,
    );
  }
  
  /// Run a manual optimization
  Future<OptimizationResult?> runManualOptimization() async {
    return _runOptimization();
  }
  
  /// Dispose the optimization service
  void dispose() {
    _optimizationTimer?.cancel();
    BreathingPerformanceMonitor.instance.removeListener(_onPerformanceUpdate);
    BreathingPerformanceMonitor.instance.stopMonitoring();
    _isInitialized = false;
  }
}

/// Optimization events
enum OptimizationEvent {
  /// Service initialized
  initialized,
  
  /// Optimization started
  optimizationStarted,
  
  /// Optimization completed
  optimizationCompleted,
  
  /// Optimization failed
  optimizationFailed,
  
  /// High memory usage detected
  highMemoryUsage,
  
  /// Low frame rate detected
  lowFrameRate,
}

/// Optimization statistics
class OptimizationStats {
  /// Current memory usage in MB
  final double memoryUsage;
  
  /// Number of active resources
  final int activeResourceCount;
  
  /// Number of cached audio assets
  final int cachedAudioAssetCount;
  
  /// Number of active audio players
  final int activeAudioPlayerCount;
  
  /// Current performance tier
  final DevicePerformanceTier performanceTier;
  
  /// Current frame rate
  final double frameRate;
  
  /// Current CPU usage
  final double cpuUsage;
  
  /// Creates a new OptimizationStats
  const OptimizationStats({
    required this.memoryUsage,
    required this.activeResourceCount,
    required this.cachedAudioAssetCount,
    required this.activeAudioPlayerCount,
    required this.performanceTier,
    required this.frameRate,
    required this.cpuUsage,
  });
}

/// Optimization result
class OptimizationResult {
  /// Current memory usage in MB
  final double memoryUsage;
  
  /// Performance profile
  final DevicePerformanceProfile performanceProfile;
  
  /// Recommended settings
  final OptimizedSettings recommendedSettings;
  
  /// Creates a new OptimizationResult
  const OptimizationResult({
    required this.memoryUsage,
    required this.performanceProfile,
    required this.recommendedSettings,
  });
}