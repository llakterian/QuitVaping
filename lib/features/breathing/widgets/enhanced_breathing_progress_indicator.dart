import 'package:quit_vaping/features/breathing/models/breathing_phase.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/breathing_animation_widget.dart';

/// A circular progress indicator that shows the current position within a breathing phase
/// and provides a visual countdown for phase transitions.
class EnhancedBreathingProgressIndicator extends StatefulWidget {
  /// The current breathing phase
  final BreathingPhase currentPhase;
  
  /// The number of seconds remaining in the current phase
  final int secondsRemaining;
  
  /// The total number of seconds in the current phase
  final int totalPhaseSeconds;
  
  /// The size of the indicator
  final double size;
  
  /// Whether to show the countdown text
  final bool showCountdown;
  
  /// Whether to use haptic feedback for transitions
  final bool useHapticFeedback;
  
  /// Custom colors for different phases
  final Map<BreathingPhase, Color>? phaseColors;

  /// Creates a new EnhancedBreathingProgressIndicator
  const EnhancedBreathingProgressIndicator({
    Key? key,
    required this.currentPhase,
    required this.secondsRemaining,
    required this.totalPhaseSeconds,
    this.size = 60,
    this.showCountdown = true,
    this.useHapticFeedback = true,
    this.phaseColors,
  }) : super(key: key);

  @override
  State<EnhancedBreathingProgressIndicator> createState() => _EnhancedBreathingProgressIndicatorState();
}

class _EnhancedBreathingProgressIndicatorState extends State<EnhancedBreathingProgressIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  BreathingPhase? _previousPhase;
  int? _previousSecondsRemaining;
  
  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller for pulse effect
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut)
    );
    
    _pulseController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _pulseController.reverse();
      }
    });
    
    _previousPhase = widget.currentPhase;
    _previousSecondsRemaining = widget.secondsRemaining;
  }
  
  @override
  void didUpdateWidget(EnhancedBreathingProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Check for phase changes
    if (widget.currentPhase != _previousPhase) {
      _handlePhaseChange();
      _previousPhase = widget.currentPhase;
    }
    
    // Check for approaching transition
    if (widget.secondsRemaining <= 3 && 
        widget.secondsRemaining != _previousSecondsRemaining && 
        widget.secondsRemaining > 0) {
      _handleApproachingTransition();
    }
    
    _previousSecondsRemaining = widget.secondsRemaining;
  }
  
  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }
  
  /// Handle phase change
  void _handlePhaseChange() {
    // Pulse animation
    _pulseController.forward(from: 0.0);
    
    // Haptic feedback if enabled
    if (widget.useHapticFeedback) {
      HapticFeedback.mediumImpact();
    }
  }
  
  /// Handle approaching transition
  void _handleApproachingTransition() {
    // Haptic feedback if enabled (lighter)
    if (widget.useHapticFeedback && widget.secondsRemaining == 3) {
      HapticFeedback.lightImpact();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // Calculate progress (inverted because we're counting down)
    final progress = widget.totalPhaseSeconds > 0 
        ? (widget.totalPhaseSeconds - widget.secondsRemaining) / widget.totalPhaseSeconds 
        : 0.0;
    
    // Get color for the current phase
    final color = _getColorForPhase(widget.currentPhase, context);
    
    // Determine if we're approaching a phase transition (last 3 seconds)
    final isApproachingTransition = widget.secondsRemaining <= 3;
    
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        final scale = _pulseAnimation.value;
        return Transform.scale(
          scale: isApproachingTransition ? scale : 1.0,
          child: SizedBox(
            width: widget.size,
            height: widget.size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Circular progress indicator
                CustomPaint(
                  size: Size(widget.size, widget.size),
                  painter: CircularProgressPainter(
                    progress: progress,
                    color: color,
                    strokeWidth: widget.size * 0.1,
                    isApproachingTransition: isApproachingTransition,
                  ),
                ),
                
                // Phase icon
                Icon(
                  _getIconForPhase(widget.currentPhase),
                  size: widget.size * 0.4,
                  color: color,
                ),
                
                // Countdown text (if enabled and approaching transition)
                if (widget.showCountdown && isApproachingTransition)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.all(widget.size * 0.05),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${widget.secondsRemaining}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: widget.size * 0.25,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Get the appropriate icon for the current phase
  IconData _getIconForPhase(BreathingPhase phase) {
    switch (phase) {
      case BreathingPhase.inhale:
        return Icons.arrow_downward;
      case BreathingPhase.inhaleHold:
        return Icons.pause;
      case BreathingPhase.exhale:
        return Icons.arrow_upward;
      case BreathingPhase.exhaleHold:
        return Icons.pause;
    }
  }

  /// Get the appropriate color for the current phase
  Color _getColorForPhase(BreathingPhase phase, BuildContext context) {
    // Use custom color if provided
    if (widget.phaseColors != null && widget.phaseColors!.containsKey(phase)) {
      return widget.phaseColors![phase]!;
    }
    
    // Default colors
    switch (phase) {
      case BreathingPhase.inhale:
        return Colors.blue;
      case BreathingPhase.inhaleHold:
        return Colors.purple;
      case BreathingPhase.exhale:
        return Colors.red;
      case BreathingPhase.exhaleHold:
        return Colors.orange;
    }
  }
}

/// Custom painter for the circular progress indicator
class CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;
  final bool isApproachingTransition;
  
  CircularProgressPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
    required this.isApproachingTransition,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    
    // Background circle
    final backgroundPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    
    canvas.drawCircle(center, radius, backgroundPaint);
    
    // Progress arc
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    
    // Add pulsing effect if approaching transition
    if (isApproachingTransition) {
      progressPaint.strokeWidth = strokeWidth * (1.0 + sin(DateTime.now().millisecondsSinceEpoch / 200) * 0.2);
    }
    
    final progressAngle = 2 * pi * progress;
    
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start from the top
      progressAngle,
      false,
      progressPaint,
    );
  }
  
  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
           oldDelegate.color != color ||
           oldDelegate.isApproachingTransition != isApproachingTransition;
  }
}

/// A widget that displays the current phase in the breathing cycle
class BreathingCycleIndicator extends StatelessWidget {
  /// The current breathing phase
  final BreathingPhase currentPhase;
  
  /// The duration of each phase in seconds
  final Map<BreathingPhase, int> phaseDurations;
  
  /// The size of each indicator
  final double indicatorSize;
  
  /// Custom colors for different phases
  final Map<BreathingPhase, Color>? phaseColors;

  /// Creates a new BreathingCycleIndicator
  const BreathingCycleIndicator({
    Key? key,
    required this.currentPhase,
    required this.phaseDurations,
    this.indicatorSize = 12,
    this.phaseColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter out phases with zero duration
    final activePhases = BreathingPhase.values.where(
      (phase) => phaseDurations[phase] != null && phaseDurations[phase]! > 0
    ).toList();
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: activePhases.map((phase) {
        final isActive = phase == currentPhase;
        final color = _getColorForPhase(phase, context);
        
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Phase indicator
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: indicatorSize,
                height: indicatorSize,
                decoration: BoxDecoration(
                  color: isActive ? color : color.withOpacity(0.3),
                  shape: BoxShape.circle,
                  border: isActive 
                    ? Border.all(color: Colors.white, width: 2) 
                    : null,
                  boxShadow: isActive 
                    ? [BoxShadow(color: color.withOpacity(0.5), blurRadius: 4, spreadRadius: 1)]
                    : null,
                ),
              ),
              
              // Phase label
              const SizedBox(height: 4),
              Text(
                _getLabelForPhase(phase),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive ? color : Colors.grey,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// Get the label for a phase
  String _getLabelForPhase(BreathingPhase phase) {
    switch (phase) {
      case BreathingPhase.inhale:
        return 'Inhale';
      case BreathingPhase.inhaleHold:
        return 'Hold';
      case BreathingPhase.exhale:
        return 'Exhale';
      case BreathingPhase.exhaleHold:
        return 'Hold';
    }
  }

  /// Get the appropriate color for a phase
  Color _getColorForPhase(BreathingPhase phase, BuildContext context) {
    // Use custom color if provided
    if (phaseColors != null && phaseColors!.containsKey(phase)) {
      return phaseColors![phase]!;
    }
    
    // Default colors
    switch (phase) {
      case BreathingPhase.inhale:
        return Colors.blue;
      case BreathingPhase.inhaleHold:
        return Colors.purple;
      case BreathingPhase.exhale:
        return Colors.red;
      case BreathingPhase.exhaleHold:
        return Colors.orange;
    }
  }
}