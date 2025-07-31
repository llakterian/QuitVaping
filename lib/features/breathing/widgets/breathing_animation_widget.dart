import 'package:quit_vaping/features/breathing/models/breathing_phase.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import '../../../data/models/breathing_exercise_model.dart';
import '../models/breathing_phase.dart';
import '../utils/breathing_accessibility_utils.dart';

/// A widget that provides animated visual guidance for breathing exercises
class BreathingAnimationWidget extends StatefulWidget {
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

  /// Creates a new BreathingAnimationWidget
  const BreathingAnimationWidget({
    Key? key,
    required this.pattern,
    required this.isPlaying,
    this.size = 200,
    this.onPhaseChanged,
    this.onCycleCompleted,
    this.phaseColors,
  }) : super(key: key);

  @override
  State<BreathingAnimationWidget> createState() => _BreathingAnimationWidgetState();
}

class _BreathingAnimationWidgetState extends State<BreathingAnimationWidget> with SingleTickerProviderStateMixin {
  late Timer _timer;
  BreathingPhase _currentPhase = BreathingPhase.inhale;
  int _secondsRemaining = 0;
  double _animationSize = 0;
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

  @override
  void initState() {
    super.initState();
    
    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    
    _resetPhase();
    
    // Start the timer if playing
    if (widget.isPlaying) {
      _startTimer();
    }
  }

  @override
  void didUpdateWidget(BreathingAnimationWidget oldWidget) {
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
  }

  @override
  void dispose() {
    _stopTimer();
    _controller.dispose();
    super.dispose();
  }

  void _resetPhase() {
    _currentPhase = BreathingPhase.inhale;
    _secondsRemaining = widget.pattern.inhaleSeconds;
    _updatePhaseText();
    _updateAnimationSize();
  }

  void _startTimer() {
    _stopTimer();
    _isAnimating = true;
    _timer = Timer.periodic(const Duration(seconds: 1), _onTimerTick);
  }

  void _stopTimer() {
    _isAnimating = false;
    if (_timer.isActive) {
      _timer.cancel();
    }
  }

  void _onTimerTick(Timer timer) {
    if (!mounted) return;
    
    setState(() {
      _secondsRemaining--;
      
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
        } else {
          _currentPhase = BreathingPhase.exhale;
          _secondsRemaining = widget.pattern.exhaleSeconds;
        }
        break;
      case BreathingPhase.inhaleHold:
        _currentPhase = BreathingPhase.exhale;
        _secondsRemaining = widget.pattern.exhaleSeconds;
        break;
      case BreathingPhase.exhale:
        if (widget.pattern.exhaleHoldSeconds > 0) {
          _currentPhase = BreathingPhase.exhaleHold;
          _secondsRemaining = widget.pattern.exhaleHoldSeconds;
        } else {
          _currentPhase = BreathingPhase.inhale;
          _secondsRemaining = widget.pattern.inhaleSeconds;
          if (widget.onCycleCompleted != null) {
            widget.onCycleCompleted!();
          }
        }
        break;
      case BreathingPhase.exhaleHold:
        _currentPhase = BreathingPhase.inhale;
        _secondsRemaining = widget.pattern.inhaleSeconds;
        if (widget.onCycleCompleted != null) {
          widget.onCycleCompleted!();
        }
        break;
    }
    
    _updatePhaseText();
    _updateAnimationSize();
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

  void _updateAnimationSize() {
    double targetSize;
    
    switch (_currentPhase) {
      case BreathingPhase.inhale:
        targetSize = widget.size;
        break;
      case BreathingPhase.inhaleHold:
        targetSize = widget.size;
        break;
      case BreathingPhase.exhale:
        targetSize = widget.size * 0.6;
        break;
      case BreathingPhase.exhaleHold:
        targetSize = widget.size * 0.6;
        break;
    }
    
    // Create a new animation for the size change
    _sizeAnimation = Tween<double>(
      begin: _animationSize,
      end: targetSize,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    
    // Update the current size
    _animationSize = targetSize;
    
    // Reset and forward the animation
    _controller.reset();
    _controller.forward();
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
    
    // Use AnimatedBuilder to efficiently rebuild only what changes
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final currentSize = _sizeAnimation.value;
        
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Use RepaintBoundary to optimize rendering
            RepaintBoundary(
              key: _animationKey,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                width: currentSize,
                height: currentSize,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                // Use Semantics for accessibility
                child: Semantics(
                  label: BreathingAccessibilityUtils.getPhaseSemanticLabel(
                    _currentPhase, 
                    _secondsRemaining
                  ),
                  child: const SizedBox(),
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
      },
    );
  }
}