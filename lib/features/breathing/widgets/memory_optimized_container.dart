import 'package:flutter/material.dart';
import '../utils/breathing_memory_optimizer.dart';
import '../utils/breathing_performance_monitor.dart';
import '../utils/breathing_resource_manager.dart';
import 'memory_leak_detector.dart';

/// A container widget that applies memory optimization to its children
class MemoryOptimizedContainer extends StatefulWidget {
  /// The child widget
  final Widget child;
  
  /// Whether to show debug information
  final bool showDebugInfo;
  
  /// Callback when a memory leak is detected
  final void Function(String leakInfo)? onLeakDetected;
  
  /// Whether to automatically clean up resources when the widget is disposed
  final bool autoCleanup;
  
  /// Creates a new MemoryOptimizedContainer
  const MemoryOptimizedContainer({
    Key? key,
    required this.child,
    this.showDebugInfo = false,
    this.onLeakDetected,
    this.autoCleanup = true,
  }) : super(key: key);

  @override
  State<MemoryOptimizedContainer> createState() => _MemoryOptimizedContainerState();
}

class _MemoryOptimizedContainerState extends State<MemoryOptimizedContainer> with WidgetsBindingObserver {
  // Performance metrics
  PerformanceMetrics? _currentMetrics;
  
  // Whether the app is in the background
  bool _isInBackground = false;
  
  @override
  void initState() {
    super.initState();
    
    // Register with WidgetsBinding to detect app lifecycle changes
    WidgetsBinding.instance.addObserver(this);
    
    // Start performance monitoring
    BreathingPerformanceMonitor.instance.startMonitoring();
    
    // Add listener for performance metrics
    BreathingPerformanceMonitor.instance.addListener(_onPerformanceMetricsUpdated);
    
    // Initialize memory optimizer if not already initialized
    _ensureMemoryOptimizerInitialized();
  }
  
  @override
  void dispose() {
    // Remove observer
    WidgetsBinding.instance.removeObserver(this);
    
    // Remove listener
    BreathingPerformanceMonitor.instance.removeListener(_onPerformanceMetricsUpdated);
    
    // Clean up resources if auto cleanup is enabled
    if (widget.autoCleanup) {
      BreathingResourceManager.instance.releaseUnusedResources();
    }
    
    super.dispose();
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    // Handle app lifecycle changes
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        // App is going to background
        _isInBackground = true;
        
        // Aggressively clean up resources when app goes to background
        BreathingResourceManager.instance.releaseUnusedResources();
        break;
      case AppLifecycleState.resumed:
        // App is coming to foreground
        _isInBackground = false;
        break;
      default:
        break;
    }
  }
  
  /// Ensure memory optimizer is initialized
  Future<void> _ensureMemoryOptimizerInitialized() async {
    try {
      await BreathingMemoryOptimizer.instance.initialize();
      await BreathingResourceManager.instance.initialize();
    } catch (e) {
      debugPrint('Error initializing memory optimizer: $e');
    }
  }
  
  /// Handle performance metrics updates
  void _onPerformanceMetricsUpdated(PerformanceMetrics metrics) {
    if (mounted) {
      setState(() {
        _currentMetrics = metrics;
      });
      
      // If memory usage is high, trigger cleanup
      if (metrics.memoryUsage > 150) { // 150MB threshold
        BreathingResourceManager.instance.releaseUnusedResources();
      }
      
      // If frame rate is low, adapt settings
      if (metrics.frameRate < 30) {
        final optimizedSettings = BreathingPerformanceMonitor.instance.adaptSettings(metrics);
        // Settings will be applied by the performance monitor
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MemoryLeakDetector(
      showDebugInfo: widget.showDebugInfo,
      onLeakDetected: widget.onLeakDetected,
      child: widget.child,
    );
  }
}