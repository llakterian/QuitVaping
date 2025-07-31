import 'package:quit_vaping/features/breathing/models/breathing_phase.dart';
import 'package:flutter/material.dart';
import '../../../data/models/breathing_exercise_model.dart';
import '../models/breathing_phase.dart';
import '../services/breathing_optimization_service.dart';
import '../utils/breathing_performance_monitor.dart';
import '../widgets/adaptive_breathing_animation.dart';
import '../widgets/memory_optimized_container.dart';
import '../widgets/optimized_image_widget.dart';

/// A container widget that applies all optimizations to breathing exercises
class OptimizedBreathingExerciseContainer extends StatefulWidget {
  /// The breathing pattern to use
  final BreathingPattern pattern;
  
  /// Whether the exercise is currently playing
  final bool isPlaying;
  
  /// The background image path (optional)
  final String? backgroundImagePath;
  
  /// Callback when a phase changes
  final void Function(BreathingPhase phase, int secondsRemaining)? onPhaseChanged;
  
  /// Callback when a complete cycle is finished
  final VoidCallback? onCycleCompleted;
  
  /// Whether to show debug information
  final bool showDebugInfo;
  
  /// Creates a new OptimizedBreathingExerciseContainer
  const OptimizedBreathingExerciseContainer({
    Key? key,
    required this.pattern,
    required this.isPlaying,
    this.backgroundImagePath,
    this.onPhaseChanged,
    this.onCycleCompleted,
    this.showDebugInfo = false,
  }) : super(key: key);

  @override
  State<OptimizedBreathingExerciseContainer> createState() => _OptimizedBreathingExerciseContainerState();
}

class _OptimizedBreathingExerciseContainerState extends State<OptimizedBreathingExerciseContainer> {
  // Optimization service
  final BreathingOptimizationService _optimizationService = BreathingOptimizationService.instance;
  
  // Optimization stats
  OptimizationStats? _stats;
  
  // Whether optimization is in progress
  bool _isOptimizing = false;
  
  // Last optimization event
  OptimizationEvent? _lastEvent;

  @override
  void initState() {
    super.initState();
    
    // Initialize optimization service if not already initialized
    _ensureOptimizationServiceInitialized();
    
    // Add listener for optimization events
    _optimizationService.addListener(_onOptimizationEvent);
    
    // Get initial stats
    _updateStats();
  }
  
  @override
  void dispose() {
    // Remove listener
    _optimizationService.removeListener(_onOptimizationEvent);
    
    super.dispose();
  }
  
  /// Ensure optimization service is initialized
  Future<void> _ensureOptimizationServiceInitialized() async {
    try {
      await _optimizationService.initialize();
    } catch (e) {
      debugPrint('Error initializing optimization service: $e');
    }
  }
  
  /// Handle optimization events
  void _onOptimizationEvent(OptimizationEvent event) {
    if (!mounted) return;
    
    setState(() {
      _lastEvent = event;
      
      switch (event) {
        case OptimizationEvent.optimizationStarted:
          _isOptimizing = true;
          break;
        case OptimizationEvent.optimizationCompleted:
        case OptimizationEvent.optimizationFailed:
          _isOptimizing = false;
          _updateStats();
          break;
        case OptimizationEvent.highMemoryUsage:
        case OptimizationEvent.lowFrameRate:
          _updateStats();
          break;
        default:
          break;
      }
    });
  }
  
  /// Update optimization stats
  void _updateStats() {
    if (!mounted) return;
    
    setState(() {
      _stats = _optimizationService.getOptimizationStats();
    });
  }
  
  /// Run manual optimization
  Future<void> _runManualOptimization() async {
    if (_isOptimizing) return;
    
    setState(() {
      _isOptimizing = true;
    });
    
    await _optimizationService.runManualOptimization();
    
    if (mounted) {
      setState(() {
        _isOptimizing = false;
        _updateStats();
      });
    }
  }
  
  /// Build debug overlay
  Widget _buildDebugOverlay() {
    if (!widget.showDebugInfo || _stats == null) {
      return const SizedBox.shrink();
    }
    
    final stats = _stats!;
    
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.black.withOpacity(0.7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Memory: ${stats.memoryUsage.toStringAsFixed(1)} MB | '
              'FPS: ${stats.frameRate.toStringAsFixed(1)} | '
              'Resources: ${stats.activeResourceCount}',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            Text(
              'Tier: ${stats.performanceTier.name} | '
              'Audio: ${stats.cachedAudioAssetCount} cached, ${stats.activeAudioPlayerCount} active',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            if (_lastEvent != null)
              Text(
                'Last event: ${_lastEvent!.name}',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: _isOptimizing ? null : _runManualOptimization,
                  child: Text(
                    _isOptimizing ? 'Optimizing...' : 'Optimize Now',
                    style: const TextStyle(color: Colors.lightBlue, fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MemoryOptimizedContainer(
      showDebugInfo: false, // We'll use our own debug overlay
      onLeakDetected: (leakInfo) {
        debugPrint('Memory leak detected: $leakInfo');
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image (if provided)
          if (widget.backgroundImagePath != null)
            Positioned.fill(
              child: OptimizedImageWidget(
                assetPath: widget.backgroundImagePath!,
                fit: BoxFit.cover,
              ),
            ),
          
          // Breathing animation
          Center(
            child: AdaptiveBreathingAnimation(
              pattern: widget.pattern,
              isPlaying: widget.isPlaying,
              size: MediaQuery.of(context).size.width * 0.8,
              onPhaseChanged: widget.onPhaseChanged,
              onCycleCompleted: widget.onCycleCompleted,
              autoAdapt: true,
            ),
          ),
          
          // Debug overlay
          _buildDebugOverlay(),
        ],
      ),
    );
  }
}