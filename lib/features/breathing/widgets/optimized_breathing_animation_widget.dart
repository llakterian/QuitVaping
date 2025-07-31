import 'package:quit_vaping/features/breathing/models/breathing_phase.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../../data/models/breathing_exercise_model.dart';
import '../models/breathing_phase.dart';
import '../utils/breathing_accessibility_utils.dart';
import '../utils/breathing_memory_optimizer.dart';
import '../utils/breathing_resource_manager.dart';
import 'breathing_animation_widget.dart';
import 'optimized_breathing_animation_painter.dart';

/// An optimized widget that provides animated visual guidance for breathing exercises
/// using a custom painter for better performance
class OptimizedBreathingAnimationWidget extends StatefulWidget {
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
  
  /// Animation complexity level
  final AnimationComplexity complexity;

  /// Creates a new OptimizedBreathingAnimationWidget
  const OptimizedBreathingAnimationWidget({
    Key? key,
    required this.pattern,
    required this.isPlaying,
    this.size = 200,
    this.onPhaseChanged,
    this.onCycleCompleted,
    this.phaseColors,
    this.complexity = AnimationComplexity.standard,
  }) : super(key: key);

  @override
  State<OptimizedBreathingAnimationWidget> createState() => _OptimizedBreathingAnimationWidgetState();
}

/// Animation complexity levels for different device capabilities
enum AnimationComplexity {
  /// Simple animations for low-end devices
  simple,
  
  /// Standard animations for mid-range devices
  standard,
  
  /// Advanced animations with particles for high-end devices
  advanced,
}

class _OptimizedBreathingAnimationWidgetState extends State<OptimizedBreathingAnimationWidget> 
    with SingleTickerProviderStateMixin {
  late Timer _timer;
  BreathingPhase _currentPhase = BreathingPhase.inhale;
  int _secondsRemaining = 0;
  int _totalPhaseSeconds = 0;
  double _phaseProgress = 0.0;
  bool _isAnimating = false;
  
  // Use a single AnimationController for all animations
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  
  // Cache colors to avoid recalculating them on every frame
  final Map<BreathingPhase, Color> _cachedColors = {};
  
  // Cache text to avoid rebuilding text widgets on every frame
  String _phaseText = '';
  
  // Use RepaintBoundary to optimize rendering
  final GlobalKey _animationKey = GlobalKey();
  
  // Ticker for smooth animation updates
  late Ticker _animationTicker;
  
  // Last update time for frame rate control
  DateTime _lastUpdateTime = DateTime.now();
  
  // Target frame rate based on complexity
  int _targetFrameRate = 60;

  @override
  void initState() {
    super.initState();
    
    // Set target frame rate based on complexity
    _setTargetFrameRate();
    
    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    
    // Initialize the animation ticker
    _animationTicker = createTicker(_onAnimationTick)..start();
    
    // Register with resource manager
    BreathingResourceManager.instance.registerResource(
      'breathing_animation_${widget.complexity}',
      priority: _getPriorityForComplexity(),
    );
    
    _resetPhase();
    
    // Start the timer if playing
    if (widget.isPlaying) {
      _startTimer();
    }
  }
  
  /// Get priority based on animation complexity
  int _getPriorityForComplexity() {
    switch (widget.complexity) {
      case AnimationComplexity.simple:
        return 1;
      case AnimationComplexity.standard:
        return 2;
      case AnimationComplexity.advanced:
        return 3;
    }
  }
  
  /// Set target frame rate based on animation complexity
  void _setTargetFrameRate() {
    switch (widget.complexity) {
      case AnimationComplexity.simple:
        _targetFrameRate = 30; // Lower frame rate for simple animations
        break;
      case AnimationComplexity.standard:
        _targetFrameRate = 45; // Medium frame rate for standard animations
        break;
      case AnimationComplexity.advanced:
        _targetFrameRate = 60; // High frame rate for advanced animations
        break;
    }
  }

  @override
  void didUpdateWidget(OptimizedBreathingAnimationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Handle pattern changes
    if (oldWidget.pattern != widget.pattern) {
      _resetPhase();
    }
    
    // Handle play/pause changes
    if (oldWidget.isPlaying != widget.isPlaying) {
      if (widget.isPlaying) {
        _startTimer();
      } else {
        _stopTimer();
      }
    }
    
    // Clear cached colors if phase colors change
    if (oldWidget.phaseColors != widget.phaseColors) {
      _cachedColors.clear();
    }
    
    // Update target frame rate if complexity changes
    if (oldWidget.complexity != widget.complexity) {
      _setTargetFrameRate();
    }
  }

  @override
  void dispose() {
    _stopTimer();
    _controller.dispose();
    _animationTicker.dispose();
    
    // Unregister from resource manager
    BreathingResourceManager.instance.unregisterResource(
      'breathing_animation_${widget.complexity}'
    );
    
    // Trigger cleanup of unused resources
    BreathingMemoryOptimizer.instance.cleanupUnusedResources();
    
    super.dispose();
  }
  
  /// Animation ticker callback for smooth updates
  void _onAnimationTick(Duration elapsed) {
    // Skip frames to match target frame rate
    final now = DateTime.now();
    final millisSinceLastUpdate = now.difference(_lastUpdateTime).inMilliseconds;
    final targetFrameInterval = 1000 ~/ _targetFrameRate;
    
    if (millisSinceLastUpdate < targetFrameInterval) {
      return; // Skip this frame
    }
    
    _lastUpdateTime = now;
    
    // Only update if animating
    if (!_isAnimating || !mounted) return;
    
    // Update phase progress
    if (_totalPhaseSeconds > 0) {
      setState(() {
        _phaseProgress = (_totalPhaseSeconds - _secondsRemaining) / _totalPhaseSeconds;
      });
    }
  }

  void _resetPhase() {
    _currentPhase = BreathingPhase.inhale;
    _secondsRemaining = widget.pattern.inhaleSeconds;
    _totalPhaseSeconds = widget.pattern.inhaleSeconds;
    _phaseProgress = 0.0;
    _updatePhaseText();
  }

  void _startTimer() {
    _stopTimer();
    _isAnimating = true;
    _timer = Timer.periodic(const Duration(seconds: 1), _onTimerTick);
  }

  void _stopTimer() {
    _isAnimating = false;
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
  }

  void _onTimerTick(Timer timer) {
    if (!mounted) return;
    
    setState(() {
      _secondsRemaining--;
      
      // Update phase progress
      if (_totalPhaseSeconds > 0) {
        _phaseProgress = (_totalPhaseSeconds - _secondsRemaining) / _totalPhaseSeconds;
      }
      
      if (_secondsRemaining <= 0) {
        _moveToNextPhase();
      }
      
      // Notify phase change
      if (widget.onPhaseChanged != null) {
        widget.onPhaseChanged!(_currentPhase, _secondsRemaining);
      }
      
      // Provide haptic feedback for accessibility
      BreathingAccessibilityUtils.provideHapticFeedback(_currentPhase);
    });
  }

  void _moveToNextPhase() {
    switch (_currentPhase) {
      case BreathingPhase.inhale:
        if (widget.pattern.inhaleHoldSeconds > 0) {
          _currentPhase = BreathingPhase.inhaleHold;
          _secondsRemaining = widget.pattern.inhaleHoldSeconds;
          _totalPhaseSeconds = widget.pattern.inhaleHoldSeconds;
        } else {
          _currentPhase = BreathingPhase.exhale;
          _secondsRemaining = widget.pattern.exhaleSeconds;
          _totalPhaseSeconds = widget.pattern.exhaleSeconds;
        }
        break;
      case BreathingPhase.inhaleHold:
        _currentPhase = BreathingPhase.exhale;
        _secondsRemaining = widget.pattern.exhaleSeconds;
        _totalPhaseSeconds = widget.pattern.exhaleSeconds;
        break;
      case BreathingPhase.exhale:
        if (widget.pattern.exhaleHoldSeconds > 0) {
          _currentPhase = BreathingPhase.exhaleHold;
          _secondsRemaining = widget.pattern.exhaleHoldSeconds;
          _totalPhaseSeconds = widget.pattern.exhaleHoldSeconds;
        } else {
          _currentPhase = BreathingPhase.inhale;
          _secondsRemaining = widget.pattern.inhaleSeconds;
          _totalPhaseSeconds = widget.pattern.inhaleSeconds;
          if (widget.onCycleCompleted != null) {
            widget.onCycleCompleted!();
          }
        }
        break;
      case BreathingPhase.exhaleHold:
        _currentPhase = BreathingPhase.inhale;
        _secondsRemaining = widget.pattern.inhaleSeconds;
        _totalPhaseSeconds = widget.pattern.inhaleSeconds;
        if (widget.onCycleCompleted != null) {
          widget.onCycleCompleted!();
        }
        break;
    }
    
    _phaseProgress = 0.0;
    _updatePhaseText();
  }

  void _updatePhaseText() {
    switch (_currentPhase) {
      case BreathingPhase.inhale:
        _phaseText = 'Inhale';
        break;
      case BreathingPhase.inhaleHold:
        _phaseText = 'Hold';
        break;
      case BreathingPhase.exhale:
        _phaseText = 'Exhale';
        break;
      case BreathingPhase.exhaleHold:
        _phaseText = 'Hold';
        break;
    }
  }

  Color _getColorForPhase(BreathingPhase phase) {
    // Use cached color if available
    if (_cachedColors.containsKey(phase)) {
      return _cachedColors[phase]!;
    }
    
    // Get color from widget or use default
    Color defaultColor;
    switch (phase) {
      case BreathingPhase.inhale:
        defaultColor = Colors.blue;
        break;
      case BreathingPhase.inhaleHold:
        defaultColor = Colors.purple;
        break;
      case BreathingPhase.exhale:
        defaultColor = Colors.red;
        break;
      case BreathingPhase.exhaleHold:
        defaultColor = Colors.orange;
        break;
    }
    
    final color = widget.phaseColors?[phase] ?? defaultColor;
    
    // Apply accessibility adjustments
    final accessibleColor = BreathingAccessibilityUtils.getAccessibleColorForPhase(
      phase, 
      color
    );
    
    // Cache the color
    _cachedColors[phase] = accessibleColor;
    
    return accessibleColor;
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColorForPhase(_currentPhase);
    final textColor = BreathingAccessibilityUtils.getAccessibleTextColor(color);
    
    // Calculate animation size based on phase
    double animationSize;
    switch (_currentPhase) {
      case BreathingPhase.inhale:
      case BreathingPhase.inhaleHold:
        animationSize = widget.size;
        break;
      case BreathingPhase.exhale:
      case BreathingPhase.exhaleHold:
        animationSize = widget.size * 0.6;
        break;
    }
    
    // Determine if we should show particles based on complexity
    final showParticles = widget.complexity == AnimationComplexity.advanced;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Use RepaintBoundary to optimize rendering
        RepaintBoundary(
          key: _animationKey,
          child: SizedBox(
            width: widget.size,
            height: widget.size,
            child: CustomPaint(
              painter: OptimizedBreathingAnimationPainter(
                size: animationSize,
                color: color,
                phase: _currentPhase,
                phaseProgress: _phaseProgress,
                showParticles: showParticles,
              ),
              // Use Semantics for accessibility
              child: Semantics(
                label: BreathingAccessibilityUtils.getPhaseSemanticLabel(
                  _currentPhase, 
                  _secondsRemaining
                ),
                child: const SizedBox.expand(),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Use Text.rich for more efficient text rendering
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: _phaseText,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              TextSpan(
                text: ' $_secondsRemaining',
                style: TextStyle(
                  fontSize: 24,
                  color: textColor,
                ),
              ),
            ],
          ),
          // Use Semantics for accessibility
          semanticsLabel: '$_phaseText for $_secondsRemaining seconds',
        ),
      ],
    );
  }
}