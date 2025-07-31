import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/breathing_memory_optimizer.dart';
import '../utils/breathing_performance_monitor.dart';
import '../utils/breathing_resource_manager.dart';

/// A widget that detects and helps fix memory leaks in breathing exercises
class MemoryLeakDetector extends StatefulWidget {
  /// The child widget
  final Widget child;
  
  /// Whether to show debug information
  final bool showDebugInfo;
  
  /// Callback when a memory leak is detected
  final void Function(String leakInfo)? onLeakDetected;
  
  /// Creates a new MemoryLeakDetector
  const MemoryLeakDetector({
    Key? key,
    required this.child,
    this.showDebugInfo = false,
    this.onLeakDetected,
  }) : super(key: key);

  @override
  State<MemoryLeakDetector> createState() => _MemoryLeakDetectorState();
}

class _MemoryLeakDetectorState extends State<MemoryLeakDetector> {
  // Timer for periodic memory checks
  Timer? _memoryCheckTimer;
  
  // Memory usage history
  final List<double> _memoryUsageHistory = [];
  
  // Maximum history size
  final int _maxHistorySize = 10;
  
  // Memory leak threshold (MB increase over time)
  final double _leakThresholdMB = 5.0;
  
  // Debug information
  String _debugInfo = '';
  
  @override
  void initState() {
    super.initState();
    
    // Start periodic memory checks
    _startMemoryChecks();
  }
  
  @override
  void dispose() {
    // Stop memory checks
    _memoryCheckTimer?.cancel();
    super.dispose();
  }
  
  /// Start periodic memory checks
  void _startMemoryChecks() {
    _memoryCheckTimer?.cancel();
    _memoryCheckTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      _checkMemoryUsage();
    });
  }
  
  /// Check memory usage for leaks
  void _checkMemoryUsage() {
    final currentMemoryUsage = BreathingMemoryOptimizer.instance.memoryUsage;
    
    // Add to history
    _memoryUsageHistory.add(currentMemoryUsage);
    
    // Trim history if needed
    if (_memoryUsageHistory.length > _maxHistorySize) {
      _memoryUsageHistory.removeAt(0);
    }
    
    // Check for leaks if we have enough history
    if (_memoryUsageHistory.length >= 3) {
      _detectLeaks();
    }
    
    // Update debug info
    if (widget.showDebugInfo && mounted) {
      setState(() {
        _debugInfo = 'Memory: ${currentMemoryUsage.toStringAsFixed(1)} MB\n'
            'Active resources: ${BreathingResourceManager.instance.activeResourceCount}';
      });
    }
  }
  
  /// Detect memory leaks
  void _detectLeaks() {
    // Check if memory usage is consistently increasing
    bool isConsistentlyIncreasing = true;
    for (int i = 1; i < _memoryUsageHistory.length; i++) {
      if (_memoryUsageHistory[i] <= _memoryUsageHistory[i - 1]) {
        isConsistentlyIncreasing = false;
        break;
      }
    }
    
    // Calculate total increase
    final totalIncrease = _memoryUsageHistory.last - _memoryUsageHistory.first;
    
    // If memory is consistently increasing and above threshold, it might be a leak
    if (isConsistentlyIncreasing && totalIncrease > _leakThresholdMB) {
      // Try to fix the leak
      _attemptToFixLeak();
      
      // Notify listener
      if (widget.onLeakDetected != null) {
        final leakInfo = 'Potential memory leak detected: '
            '${totalIncrease.toStringAsFixed(1)} MB increase over '
            '${_memoryUsageHistory.length * 10} seconds';
        widget.onLeakDetected!(leakInfo);
      }
    }
  }
  
  /// Attempt to fix a memory leak
  Future<void> _attemptToFixLeak() async {
    // Force cleanup of unused resources
    await BreathingResourceManager.instance.releaseUnusedResources();
    
    // Clear memory history to start fresh
    _memoryUsageHistory.clear();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showDebugInfo) {
      return Column(
        children: [
          Expanded(child: widget.child),
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.black.withOpacity(0.7),
            width: double.infinity,
            child: Text(
              _debugInfo,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      );
    } else {
      return widget.child;
    }
  }
}