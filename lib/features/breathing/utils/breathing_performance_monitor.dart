import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import '../widgets/optimized_breathing_animation_widget.dart';
import 'breathing_memory_optimizer.dart';

/// A utility class for monitoring and optimizing performance of breathing animations
class BreathingPerformanceMonitor {
  /// Singleton instance
  static final BreathingPerformanceMonitor _instance = BreathingPerformanceMonitor._internal();
  
  /// Get the singleton instance
  static BreathingPerformanceMonitor get instance => _instance;
  
  /// Private constructor
  BreathingPerformanceMonitor._internal();
  
  // Performance metrics
  double _averageFrameTime = 0.0;
  int _frameCount = 0;
  int _droppedFrames = 0;
  double _cpuUsage = 0.0;
  double _memoryUsage = 0.0;
  
  // Performance tier
  DevicePerformanceTier _performanceTier = DevicePerformanceTier.medium;
  
  // Ticker for monitoring frame times
  Ticker? _ticker;
  DateTime? _lastTickTime;
  
  // Performance test status
  bool _isTestRunning = false;
  
  // Listeners
  final List<Function(PerformanceMetrics)> _listeners = [];
  
  // Device info
  String _deviceModel = 'unknown';
  int _totalMemoryMB = 0;
  int _processorCores = 0;
  
  // Performance test results
  double _startupTimeMs = 0.0;
  double _renderTestScore = 0.0;
  
  // Performance test completion
  final Completer<bool> _initCompleter = Completer<bool>();
  bool _isInitialized = false;
  
  /// Initialize performance monitoring
  Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }
    
    // Start timing for startup performance
    final startTime = DateTime.now();
    
    // Initialize memory optimizer
    await BreathingMemoryOptimizer.instance.initialize();
    
    // Collect device information
    await _collectDeviceInfo();
    
    // Calculate startup time
    _startupTimeMs = DateTime.now().difference(startTime).inMilliseconds.toDouble();
    
    // Run initial performance test
    await runPerformanceTest();
    
    _isInitialized = true;
    if (!_initCompleter.isCompleted) {
      _initCompleter.complete(true);
    }
  }
  
  /// Collect device information
  Future<void> _collectDeviceInfo() async {
    try {
      // Get device model
      if (Platform.isAndroid || Platform.isIOS) {
        _deviceModel = await _getDeviceModel();
      }
      
      // Estimate total memory
      _totalMemoryMB = await _estimateTotalMemory();
      
      // Estimate processor cores
      _processorCores = await _estimateProcessorCores();
      
      debugPrint('Device info: $_deviceModel, $_totalMemoryMB MB, $_processorCores cores');
    } catch (e) {
      debugPrint('Error collecting device info: $e');
    }
  }
  
  /// Get device model
  Future<String> _getDeviceModel() async {
    try {
      if (Platform.isAndroid) {
        const platform = MethodChannel('com.quitvaping/device_info');
        final result = await platform.invokeMethod('getDeviceModel');
        return result ?? 'unknown_android';
      } else if (Platform.isIOS) {
        const platform = MethodChannel('com.quitvaping/device_info');
        final result = await platform.invokeMethod('getDeviceModel');
        return result ?? 'unknown_ios';
      }
    } catch (e) {
      debugPrint('Error getting device model: $e');
    }
    return 'unknown';
  }
  
  /// Estimate total memory
  Future<int> _estimateTotalMemory() async {
    try {
      // Default estimates based on platform
      if (Platform.isAndroid) {
        return 2048; // Default to 2GB for Android
      } else if (Platform.isIOS) {
        return 3072; // Default to 3GB for iOS
      }
    } catch (e) {
      debugPrint('Error estimating total memory: $e');
    }
    return 1024; // Default to 1GB
  }
  
  /// Estimate processor cores
  Future<int> _estimateProcessorCores() async {
    try {
      // Use compute platform to estimate available cores
      return compute((message) => Platform.numberOfProcessors, null);
    } catch (e) {
      debugPrint('Error estimating processor cores: $e');
    }
    return 2; // Default to 2 cores
  }
  
  /// Run a performance test to determine device capabilities
  Future<DevicePerformanceProfile> runPerformanceTest() async {
    if (_isTestRunning) {
      // Return cached profile if test is already running
      return DevicePerformanceProfile(
        tier: _performanceTier,
        cpuScore: _cpuUsage,
        memoryScore: _memoryUsage,
        renderScore: _averageFrameTime > 0 ? 16.0 / _averageFrameTime : 1.0,
      );
    }
    
    _isTestRunning = true;
    _frameCount = 0;
    _droppedFrames = 0;
    _averageFrameTime = 0.0;
    
    // Start monitoring frame times
    _startFrameMonitoring();
    
    // Run render test
    await _runRenderTest();
    
    // Run memory test
    await _runMemoryTest();
    
    // Stop monitoring
    _stopFrameMonitoring();
    
    // Calculate performance tier
    _calculatePerformanceTier();
    
    _isTestRunning = false;
    
    // Return performance profile
    return DevicePerformanceProfile(
      tier: _performanceTier,
      cpuScore: _cpuUsage,
      memoryScore: _memoryUsage,
      renderScore: _renderTestScore,
      deviceModel: _deviceModel,
      totalMemoryMB: _totalMemoryMB,
      processorCores: _processorCores,
      startupTimeMs: _startupTimeMs,
    );
  }
  
  /// Run a render performance test
  Future<void> _runRenderTest() async {
    // Reset metrics
    _frameCount = 0;
    _droppedFrames = 0;
    _averageFrameTime = 0.0;
    
    // Run test for 2 seconds
    await Future.delayed(const Duration(seconds: 2));
    
    // Calculate render test score (higher is better)
    _renderTestScore = _frameCount > 0 
        ? ((_frameCount - _droppedFrames) / _frameCount) * (16.0 / (_averageFrameTime > 0 ? _averageFrameTime : 16.0))
        : 1.0;
  }
  
  /// Run a memory allocation test
  Future<void> _runMemoryTest() async {
    try {
      // Start with small allocations
      final List<Uint8List> allocations = [];
      int totalAllocated = 0;
      const maxAllocation = 50 * 1024 * 1024; // 50MB max
      const chunkSize = 1 * 1024 * 1024; // 1MB chunks
      
      // Try to allocate memory in chunks
      for (int i = 0; i < 50 && totalAllocated < maxAllocation; i++) {
        try {
          final buffer = Uint8List(chunkSize);
          // Write some data to ensure it's actually allocated
          for (int j = 0; j < buffer.length; j += 1024) {
            buffer[j] = 1;
          }
          allocations.add(buffer);
          totalAllocated += chunkSize;
          await Future.delayed(const Duration(milliseconds: 10));
        } catch (e) {
          break; // Stop if allocation fails
        }
      }
      
      // Calculate memory score based on how much we could allocate
      _memoryUsage = totalAllocated / (1024 * 1024);
      
      // Clean up allocations
      allocations.clear();
      
      // Force garbage collection
      await Future.delayed(const Duration(milliseconds: 100));
    } catch (e) {
      debugPrint('Error during memory test: $e');
    }
  }
  
  /// Start monitoring frame times
  void _startFrameMonitoring() {
    _stopFrameMonitoring();
    
    _ticker = Ticker((elapsed) {
      final now = DateTime.now();
      
      if (_lastTickTime != null) {
        final frameTime = now.difference(_lastTickTime!).inMicroseconds / 1000.0;
        
        // Update average frame time
        if (_frameCount == 0) {
          _averageFrameTime = frameTime;
        } else {
          _averageFrameTime = (_averageFrameTime * _frameCount + frameTime) / (_frameCount + 1);
        }
        
        // Count dropped frames (assuming 60fps target)
        if (frameTime > 20.0) { // More than 20ms (50fps)
          _droppedFrames++;
        }
        
        _frameCount++;
        
        // Notify listeners
        _notifyListeners();
      }
      
      _lastTickTime = now;
    });
    
    _ticker!.start();
  }
  
  /// Stop monitoring frame times
  void _stopFrameMonitoring() {
    _ticker?.stop();
    _ticker?.dispose();
    _ticker = null;
    _lastTickTime = null;
  }
  
  /// Calculate performance tier based on metrics
  void _calculatePerformanceTier() {
    // Calculate drop rate
    final dropRate = _frameCount > 0 ? _droppedFrames / _frameCount : 0.0;
    
    // Determine performance tier
    if (_averageFrameTime < 8.0 && dropRate < 0.05) {
      _performanceTier = DevicePerformanceTier.high;
    } else if (_averageFrameTime < 16.0 && dropRate < 0.15) {
      _performanceTier = DevicePerformanceTier.medium;
    } else {
      _performanceTier = DevicePerformanceTier.low;
    }
  }
  
  /// Get recommended settings for current device
  OptimizedSettings getRecommendedSettings() {
    switch (_performanceTier) {
      case DevicePerformanceTier.high:
        return OptimizedSettings(
          animationComplexity: AnimationComplexity.advanced,
          audioOptimizationLevel: OptimizationLevel.high,
          enableBackgroundMode: true,
          useHapticFeedback: true,
        );
      case DevicePerformanceTier.medium:
        return OptimizedSettings(
          animationComplexity: AnimationComplexity.standard,
          audioOptimizationLevel: OptimizationLevel.medium,
          enableBackgroundMode: true,
          useHapticFeedback: true,
        );
      case DevicePerformanceTier.low:
        return OptimizedSettings(
          animationComplexity: AnimationComplexity.simple,
          audioOptimizationLevel: OptimizationLevel.low,
          enableBackgroundMode: false,
          useHapticFeedback: false,
        );
    }
  }
  
  /// Monitor performance during exercise
  void startMonitoring() {
    _startFrameMonitoring();
  }
  
  /// Stop monitoring performance
  void stopMonitoring() {
    _stopFrameMonitoring();
  }
  
  /// Add a listener for performance metrics
  void addListener(Function(PerformanceMetrics) listener) {
    _listeners.add(listener);
  }
  
  /// Remove a listener
  void removeListener(Function(PerformanceMetrics) listener) {
    _listeners.remove(listener);
  }
  
  /// Notify listeners of performance metrics
  void _notifyListeners() {
    // Update memory usage from memory optimizer
    _memoryUsage = BreathingMemoryOptimizer.instance.memoryUsage;
    
    final metrics = PerformanceMetrics(
      frameRate: _averageFrameTime > 0 ? 1000.0 / _averageFrameTime : 60.0,
      frameTime: _averageFrameTime,
      droppedFrameRate: _frameCount > 0 ? _droppedFrames / _frameCount : 0.0,
      cpuUsage: _cpuUsage,
      memoryUsage: _memoryUsage,
    );
    
    for (final listener in _listeners) {
      listener(metrics);
    }
  }
  
  /// Notify listeners of performance metrics (public method for testing)
  void notifyListeners() {
    _notifyListeners();
  }
  
  /// Record a frame time for monitoring
  void recordFrameTime(double frameTimeMs) {
    // Only record if not already monitoring via ticker
    if (_ticker == null) {
      // Update average frame time
      if (_frameCount == 0) {
        _averageFrameTime = frameTimeMs;
      } else {
        _averageFrameTime = (_averageFrameTime * _frameCount + frameTimeMs) / (_frameCount + 1);
      }
      
      // Count dropped frames (assuming 60fps target)
      if (frameTimeMs > 20.0) { // More than 20ms (50fps)
        _droppedFrames++;
      }
      
      _frameCount++;
    }
  }
  
  /// Adapt settings based on current performance
  OptimizedSettings adaptSettings(PerformanceMetrics metrics) {
    // Determine performance tier based on metrics
    DevicePerformanceTier tier;
    
    if (metrics.frameRate >= 55.0 && metrics.droppedFrameRate < 0.05) {
      tier = DevicePerformanceTier.high;
    } else if (metrics.frameRate >= 40.0 && metrics.droppedFrameRate < 0.15) {
      tier = DevicePerformanceTier.medium;
    } else {
      tier = DevicePerformanceTier.low;
    }
    
    // Update current tier if different
    if (tier != _performanceTier) {
      _performanceTier = tier;
    }
    
    // Return recommended settings for the tier
    return getRecommendedSettings();
  }
  
  /// Get the current performance tier
  DevicePerformanceTier get performanceTier => _performanceTier;
  
  /// Get current performance metrics
  PerformanceMetrics get currentMetrics => PerformanceMetrics(
    frameRate: _averageFrameTime > 0 ? 1000.0 / _averageFrameTime : 60.0,
    frameTime: _averageFrameTime,
    droppedFrameRate: _frameCount > 0 ? _droppedFrames / _frameCount : 0.0,
    cpuUsage: _cpuUsage,
    memoryUsage: _memoryUsage,
  );
}

/// Device performance tiers
enum DevicePerformanceTier {
  /// Low-end devices with limited resources
  low,
  
  /// Mid-range devices with moderate resources
  medium,
  
  /// High-end devices with abundant resources
  high,
}

/// Audio optimization levels
enum OptimizationLevel {
  /// Low quality, low resource usage
  low,
  
  /// Medium quality, moderate resource usage
  medium,
  
  /// High quality, higher resource usage
  high,
}

/// Device performance profile
class DevicePerformanceProfile {
  /// The performance tier of the device
  final DevicePerformanceTier tier;
  
  /// CPU performance score (higher is better)
  final double cpuScore;
  
  /// Memory performance score (higher is better)
  final double memoryScore;
  
  /// Rendering performance score (higher is better)
  final double renderScore;
  
  /// Device model identifier
  final String? deviceModel;
  
  /// Total device memory in MB
  final int? totalMemoryMB;
  
  /// Number of processor cores
  final int? processorCores;
  
  /// App startup time in milliseconds
  final double? startupTimeMs;
  
  /// Creates a new DevicePerformanceProfile
  const DevicePerformanceProfile({
    required this.tier,
    required this.cpuScore,
    required this.memoryScore,
    required this.renderScore,
    this.deviceModel,
    this.totalMemoryMB,
    this.processorCores,
    this.startupTimeMs,
  });
  
  /// Get a description of the device performance
  String getDescription() {
    final deviceInfo = deviceModel != null ? 'Device: $deviceModel, ' : '';
    final memoryInfo = totalMemoryMB != null ? '$totalMemoryMB MB RAM, ' : '';
    final coreInfo = processorCores != null ? '$processorCores cores, ' : '';
    final startupInfo = startupTimeMs != null ? 'Startup: ${startupTimeMs!.toStringAsFixed(1)}ms, ' : '';
    
    return '$deviceInfo${memoryInfo}${coreInfo}${startupInfo}Performance Tier: ${tier.toString().split('.').last}';
  }
  
  /// Get a map representation of the profile
  Map<String, dynamic> toMap() {
    return {
      'tier': tier.toString().split('.').last,
      'cpuScore': cpuScore,
      'memoryScore': memoryScore,
      'renderScore': renderScore,
      'deviceModel': deviceModel,
      'totalMemoryMB': totalMemoryMB,
      'processorCores': processorCores,
      'startupTimeMs': startupTimeMs,
    };
  }
}

/// Optimized settings for breathing exercises
class OptimizedSettings {
  /// Animation complexity level
  final AnimationComplexity animationComplexity;
  
  /// Audio optimization level
  final OptimizationLevel audioOptimizationLevel;
  
  /// Whether to enable background mode
  final bool enableBackgroundMode;
  
  /// Whether to use haptic feedback
  final bool useHapticFeedback;
  
  /// Creates a new OptimizedSettings
  const OptimizedSettings({
    required this.animationComplexity,
    required this.audioOptimizationLevel,
    required this.enableBackgroundMode,
    required this.useHapticFeedback,
  });
}

/// Performance metrics
class PerformanceMetrics {
  /// Current frame rate (frames per second)
  final double frameRate;
  
  /// Average frame time in milliseconds
  final double frameTime;
  
  /// Rate of dropped frames (0.0 to 1.0)
  final double droppedFrameRate;
  
  /// CPU usage (0.0 to 1.0)
  final double cpuUsage;
  
  /// Memory usage in MB
  final double memoryUsage;
  
  /// Creates a new PerformanceMetrics
  const PerformanceMetrics({
    required this.frameRate,
    required this.frameTime,
    required this.droppedFrameRate,
    required this.cpuUsage,
    required this.memoryUsage,
  });
}