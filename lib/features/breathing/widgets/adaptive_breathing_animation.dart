import 'package:quit_vaping/features/breathing/models/breathing_phase.dart';
import 'package:flutter/material.dart';
import '../../../data/models/breathing_exercise_model.dart';
import '../models/breathing_phase.dart';
import '../utils/breathing_performance_monitor.dart';
import '../widgets/breathing_animation_widget.dart';
import '../widgets/optimized_breathing_animation_widget.dart';

/// A widget that provides adaptive breathing animations based on device performance
class AdaptiveBreathingAnimation extends StatefulWidget {
  /// The breathing pattern to animate
  final BreathingPattern pattern;
  
  /// Whether the animation is currently playing
  final bool isPlaying;
  
  /// The size of the animation
  final double size;
  
  /// Callback when a phase changes
  final void Function(BreathingPhase phase, int secondsRemaining)? onPhaseChanged;
  
  /// Callback when a complete cycle is finished
  final VoidCallback? onCycleCompleted;
  
  /// Custom colors for the phases
  final Map<BreathingPhase, Color>? phaseColors;
  
  /// Whether to automatically adapt to device performance
  final bool autoAdapt;
  
  /// Manual override for animation complexity
  final AnimationComplexity? complexityOverride;

  /// Creates a new AdaptiveBreathingAnimation
  const AdaptiveBreathingAnimation({
    Key? key,
    required this.pattern,
    required this.isPlaying,
    this.size = 200,
    this.onPhaseChanged,
    this.onCycleCompleted,
    this.phaseColors,
    this.autoAdapt = true,
    this.complexityOverride,
  }) : super(key: key);

  @override
  State<AdaptiveBreathingAnimation> createState() => _AdaptiveBreathingAnimationState();
}

class _AdaptiveBreathingAnimationState extends State<AdaptiveBreathingAnimation> 
    with SingleTickerProviderStateMixin {
  // Performance monitor
  final BreathingPerformanceMonitor _performanceMonitor = BreathingPerformanceMonitor.instance;
  
  // Current animation complexity
  late AnimationComplexity _currentComplexity;
  
  // Target animation complexity (for smooth transitions)
  late AnimationComplexity _targetComplexity;
  
  // Transition controller for smooth complexity changes
  late AnimationController _transitionController;
  
  // Transition progress (0.0 = current, 1.0 = target)
  double _transitionProgress = 0.0;
  
  // Performance metrics for debugging
  PerformanceMetrics? _currentMetrics;
  
  // Whether performance monitoring is active
  bool _isMonitoring = false;
  
  // Complexity transition timer
  DateTime? _lastComplexityChange;
  
  // Minimum time between complexity changes (to prevent rapid oscillation)
  static const _minComplexityChangeInterval = Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    
    // Initialize transition controller
    _transitionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    
    _transitionController.addListener(() {
      setState(() {
        _transitionProgress = _transitionController.value;
      });
    });
    
    // Initialize performance monitoring
    _performanceMonitor.initialize();
    
    // Set initial complexity
    _setInitialComplexity();
    
    // Start monitoring if auto-adapt is enabled
    if (widget.autoAdapt) {
      _startMonitoring();
    }
  }
  
  @override
  void didUpdateWidget(AdaptiveBreathingAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Update monitoring if auto-adapt changed
    if (widget.autoAdapt != oldWidget.autoAdapt) {
      if (widget.autoAdapt) {
        _startMonitoring();
      } else {
        _stopMonitoring();
      }
    }
    
    // Update complexity if override changed
    if (widget.complexityOverride != oldWidget.complexityOverride) {
      _updateComplexity();
    }
  }
  
  @override
  void dispose() {
    _stopMonitoring();
    _transitionController.dispose();
    super.dispose();
  }
  
  /// Set initial animation complexity
  void _setInitialComplexity() {
    if (widget.complexityOverride != null) {
      _currentComplexity = widget.complexityOverride!;
      _targetComplexity = widget.complexityOverride!;
    } else {
      // Get recommended settings based on device performance
      final settings = _performanceMonitor.getRecommendedSettings();
      _currentComplexity = settings.animationComplexity;
      _targetComplexity = settings.animationComplexity;
    }
    
    _lastComplexityChange = DateTime.now();
  }
  
  /// Start performance monitoring
  void _startMonitoring() {
    if (_isMonitoring) return;
    
    _isMonitoring = true;
    _performanceMonitor.startMonitoring();
    _performanceMonitor.addListener(_onPerformanceUpdate);
  }
  
  /// Stop performance monitoring
  void _stopMonitoring() {
    if (!_isMonitoring) return;
    
    _isMonitoring = false;
    _performanceMonitor.stopMonitoring();
    _performanceMonitor.removeListener(_onPerformanceUpdate);
  }
  
  /// Handle performance updates
  void _onPerformanceUpdate(PerformanceMetrics metrics) {
    if (!mounted || !widget.autoAdapt) return;
    
    setState(() {
      _currentMetrics = metrics;
      
      // Adapt settings based on performance
      final settings = _performanceMonitor.adaptSettings(metrics);
      
      // Check if we should update complexity
      if (_targetComplexity != settings.animationComplexity) {
        // Check if enough time has passed since last change
        final now = DateTime.now();
        if (_lastComplexityChange == null || 
            now.difference(_lastComplexityChange!) > _minComplexityChangeInterval) {
          
          // Start transition to new complexity
          _startComplexityTransition(settings.animationComplexity);
          _lastComplexityChange = now;
        }
      }
    });
  }
  
  /// Start transition to new complexity
  void _startComplexityTransition(AnimationComplexity newComplexity) {
    // Set target complexity
    _targetComplexity = newComplexity;
    
    // Reset transition controller
    _transitionController.reset();
    
    // Start transition animation
    _transitionController.forward();
  }
  
  /// Update animation complexity
  void _updateComplexity() {
    AnimationComplexity newComplexity;
    
    if (widget.complexityOverride != null) {
      newComplexity = widget.complexityOverride!;
    } else if (widget.autoAdapt) {
      final settings = _performanceMonitor.getRecommendedSettings();
      newComplexity = settings.animationComplexity;
    } else {
      // Default to standard if no override or auto-adapt
      newComplexity = AnimationComplexity.standard;
    }
    
    // If complexity changed, start transition
    if (_targetComplexity != newComplexity) {
      _startComplexityTransition(newComplexity);
      _lastComplexityChange = DateTime.now();
    }
  }
  
  /// Get current effective complexity based on transition progress
  AnimationComplexity get _effectiveComplexity {
    // If transition is complete, update current complexity
    if (_transitionProgress >= 1.0) {
      _currentComplexity = _targetComplexity;
      return _targetComplexity;
    }
    
    // If transition is just starting, return current complexity
    if (_transitionProgress <= 0.0) {
      return _currentComplexity;
    }
    
    // During transition, return the higher complexity to ensure smooth transition
    // This prevents visual glitches when transitioning between complexity levels
    return _getHigherComplexity(_currentComplexity, _targetComplexity);
  }
  
  /// Get the higher of two complexity levels
  AnimationComplexity _getHigherComplexity(
    AnimationComplexity a, 
    AnimationComplexity b
  ) {
    if (a == AnimationComplexity.advanced || b == AnimationComplexity.advanced) {
      return AnimationComplexity.advanced;
    }
    
    if (a == AnimationComplexity.standard || b == AnimationComplexity.standard) {
      return AnimationComplexity.standard;
    }
    
    return AnimationComplexity.simple;
  }

  @override
  Widget build(BuildContext context) {
    // Use RepaintBoundary to optimize rendering
    return RepaintBoundary(
      child: OptimizedBreathingAnimationWidget(
        pattern: widget.pattern,
        isPlaying: widget.isPlaying,
        size: widget.size,
        onPhaseChanged: widget.onPhaseChanged,
        onCycleCompleted: widget.onCycleCompleted,
        phaseColors: widget.phaseColors,
        complexity: _effectiveComplexity,
      ),
    );
  }
}