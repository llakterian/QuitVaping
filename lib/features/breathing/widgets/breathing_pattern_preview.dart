import 'package:quit_vaping/features/breathing/models/breathing_phase.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../data/models/breathing_exercise_model.dart';
import '../widgets/breathing_animation_widget.dart';

/// A widget that provides a visual preview of a breathing pattern
/// with an interactive rhythm visualization.
class BreathingPatternPreview extends StatefulWidget {
  /// The breathing pattern to preview
  final BreathingPattern pattern;
  
  /// The size of the preview
  final double size;
  
  /// Whether to animate the preview automatically
  final bool autoAnimate;
  
  /// The speed multiplier for the animation (1.0 = normal speed)
  final double speedMultiplier;
  
  /// Whether to use haptic feedback
  final bool useHapticFeedback;
  
  /// Custom colors for different phases
  final Map<BreathingPhase, Color>? phaseColors;
  
  /// Callback when the pattern is tapped
  final VoidCallback? onTap;

  /// Creates a new BreathingPatternPreview
  const BreathingPatternPreview({
    Key? key,
    required this.pattern,
    this.size = 150,
    this.autoAnimate = true,
    this.speedMultiplier = 2.0,
    this.useHapticFeedback = false,
    this.phaseColors,
    this.onTap,
  }) : super(key: key);

  @override
  State<BreathingPatternPreview> createState() => _BreathingPatternPreviewState();
}

class _BreathingPatternPreviewState extends State<BreathingPatternPreview> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  BreathingPhase _currentPhase = BreathingPhase.inhale;
  double _animationProgress = 0.0;
  bool _isAnimating = false;
  
  // Cache for performance optimization
  final Map<BreathingPhase, Color> _cachedColors = {};
  
  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    
    _controller.addListener(_updateAnimationProgress);
    _controller.addStatusListener(_handleAnimationStatus);
    
    // Start auto animation if enabled
    if (widget.autoAnimate) {
      _startAnimation();
    }
  }
  
  @override
  void didUpdateWidget(BreathingPatternPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Handle pattern changes
    if (oldWidget.pattern != widget.pattern) {
      _resetAnimation();
    }
    
    // Handle auto-animate changes
    if (widget.autoAnimate != oldWidget.autoAnimate) {
      if (widget.autoAnimate) {
        _startAnimation();
      } else {
        _stopAnimation();
      }
    }
    
    // Handle speed multiplier changes
    if (widget.speedMultiplier != oldWidget.speedMultiplier && _isAnimating) {
      _updateAnimationDuration();
    }
    
    // Clear cached colors if phase colors change
    if (oldWidget.phaseColors != widget.phaseColors) {
      _cachedColors.clear();
    }
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  /// Update the animation progress
  void _updateAnimationProgress() {
    if (!mounted) return;
    
    setState(() {
      _animationProgress = _controller.value;
    });
  }
  
  /// Handle animation status changes
  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _moveToNextPhase();
    }
  }
  
  /// Start the animation
  void _startAnimation() {
    if (!mounted) return;
    
    setState(() {
      _isAnimating = true;
    });
    
    _updateAnimationDuration();
    _controller.forward(from: 0.0);
  }
  
  /// Stop the animation
  void _stopAnimation() {
    if (!mounted) return;
    
    setState(() {
      _isAnimating = false;
    });
    
    _controller.stop();
  }
  
  /// Reset the animation to the initial state
  void _resetAnimation() {
    _stopAnimation();
    
    setState(() {
      _currentPhase = BreathingPhase.inhale;
      _animationProgress = 0.0;
    });
    
    if (widget.autoAnimate) {
      _startAnimation();
    }
  }
  
  /// Update the animation duration based on the current phase and speed multiplier
  void _updateAnimationDuration() {
    // Get the duration for the current phase
    int phaseDuration;
    switch (_currentPhase) {
      case BreathingPhase.inhale:
        phaseDuration = widget.pattern.inhaleSeconds;
        break;
      case BreathingPhase.inhaleHold:
        phaseDuration = widget.pattern.inhaleHoldSeconds;
        break;
      case BreathingPhase.exhale:
        phaseDuration = widget.pattern.exhaleSeconds;
        break;
      case BreathingPhase.exhaleHold:
        phaseDuration = widget.pattern.exhaleHoldSeconds;
        break;
    }
    
    // Apply speed multiplier and convert to milliseconds
    final animationDuration = (phaseDuration * 1000) ~/ widget.speedMultiplier;
    
    // Update controller duration
    _controller.duration = Duration(milliseconds: max(animationDuration, 100));
    
    // Restart the animation if it was running
    if (_isAnimating) {
      _controller.forward(from: 0.0);
    }
  }
  
  /// Move to the next phase in the breathing cycle
  void _moveToNextPhase() {
    if (!mounted) return;
    
    setState(() {
      switch (_currentPhase) {
        case BreathingPhase.inhale:
          if (widget.pattern.inhaleHoldSeconds > 0) {
            _currentPhase = BreathingPhase.inhaleHold;
          } else {
            _currentPhase = BreathingPhase.exhale;
          }
          break;
        case BreathingPhase.inhaleHold:
          _currentPhase = BreathingPhase.exhale;
          break;
        case BreathingPhase.exhale:
          if (widget.pattern.exhaleHoldSeconds > 0) {
            _currentPhase = BreathingPhase.exhaleHold;
          } else {
            _currentPhase = BreathingPhase.inhale;
          }
          break;
        case BreathingPhase.exhaleHold:
          _currentPhase = BreathingPhase.inhale;
          break;
      }
    });
    
    // Provide haptic feedback if enabled
    if (widget.useHapticFeedback) {
      HapticFeedback.lightImpact();
    }
    
    // Update animation duration for the new phase
    _updateAnimationDuration();
  }
  
  /// Get the appropriate color for the current phase
  Color _getColorForPhase(BreathingPhase phase) {
    // Use cached color if available
    if (_cachedColors.containsKey(phase)) {
      return _cachedColors[phase]!;
    }
    
    // Use custom color if provided
    if (widget.phaseColors != null && widget.phaseColors!.containsKey(phase)) {
      final color = widget.phaseColors![phase]!;
      _cachedColors[phase] = color;
      return color;
    }
    
    // Default colors
    Color color;
    switch (phase) {
      case BreathingPhase.inhale:
        color = Colors.blue;
        break;
      case BreathingPhase.inhaleHold:
        color = Colors.purple;
        break;
      case BreathingPhase.exhale:
        color = Colors.red;
        break;
      case BreathingPhase.exhaleHold:
        color = Colors.orange;
        break;
    }
    
    _cachedColors[phase] = color;
    return color;
  }
  
  /// Get the label for the current phase
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
  
  /// Get the duration in seconds for the current phase
  int _getDurationForPhase(BreathingPhase phase) {
    switch (phase) {
      case BreathingPhase.inhale:
        return widget.pattern.inhaleSeconds;
      case BreathingPhase.inhaleHold:
        return widget.pattern.inhaleHoldSeconds;
      case BreathingPhase.exhale:
        return widget.pattern.exhaleSeconds;
      case BreathingPhase.exhaleHold:
        return widget.pattern.exhaleHoldSeconds;
    }
  }
  
  /// Calculate the size of the breathing circle based on the current phase and animation progress
  double _calculateBreathingSize() {
    final baseSize = widget.size * 0.7;
    
    switch (_currentPhase) {
      case BreathingPhase.inhale:
        // Grow from 60% to 100% during inhale
        return baseSize * (0.6 + 0.4 * _animationProgress);
      case BreathingPhase.inhaleHold:
        // Stay at 100% during inhale hold
        return baseSize;
      case BreathingPhase.exhale:
        // Shrink from 100% to 60% during exhale
        return baseSize * (1.0 - 0.4 * _animationProgress);
      case BreathingPhase.exhaleHold:
        // Stay at 60% during exhale hold
        return baseSize * 0.6;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final color = _getColorForPhase(_currentPhase);
    final phaseLabel = _getLabelForPhase(_currentPhase);
    final phaseDuration = _getDurationForPhase(_currentPhase);
    final breathingSize = _calculateBreathingSize();
    
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        } else {
          // Toggle animation if no tap handler provided
          if (_isAnimating) {
            _stopAnimation();
          } else {
            _startAnimation();
          }
        }
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Pattern visualization
            CustomPaint(
              size: Size(widget.size, widget.size),
              painter: PatternVisualizationPainter(
                pattern: widget.pattern,
                currentPhase: _currentPhase,
                progress: _animationProgress,
                phaseColors: widget.phaseColors ?? _cachedColors,
              ),
            ),
            
            // Breathing circle
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: breathingSize,
              height: breathingSize,
              decoration: BoxDecoration(
                color: color.withOpacity(0.3),
                shape: BoxShape.circle,
                border: Border.all(
                  color: color,
                  width: 2,
                ),
              ),
            ),
            
            // Phase indicator
            Positioned(
              bottom: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$phaseLabel ($phaseDuration s)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            // Play/pause indicator
            if (!widget.autoAnimate)
              Positioned(
                top: 10,
                right: 10,
                child: Icon(
                  _isAnimating ? Icons.pause : Icons.play_arrow,
                  color: color,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Custom painter for visualizing the breathing pattern
class PatternVisualizationPainter extends CustomPainter {
  final BreathingPattern pattern;
  final BreathingPhase currentPhase;
  final double progress;
  final Map<BreathingPhase, Color> phaseColors;
  
  PatternVisualizationPainter({
    required this.pattern,
    required this.currentPhase,
    required this.progress,
    required this.phaseColors,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.4;
    
    // Calculate total cycle duration
    final totalDuration = pattern.inhaleSeconds + 
                         pattern.inhaleHoldSeconds + 
                         pattern.exhaleSeconds + 
                         pattern.exhaleHoldSeconds;
    
    if (totalDuration <= 0) return;
    
    // Calculate arc angles for each phase
    final inhaleAngle = 2 * pi * (pattern.inhaleSeconds / totalDuration);
    final inhaleHoldAngle = 2 * pi * (pattern.inhaleHoldSeconds / totalDuration);
    final exhaleAngle = 2 * pi * (pattern.exhaleSeconds / totalDuration);
    final exhaleHoldAngle = 2 * pi * (pattern.exhaleHoldSeconds / totalDuration);
    
    // Starting angle (top of the circle)
    double startAngle = -pi / 2;
    
    // Draw inhale arc
    if (pattern.inhaleSeconds > 0) {
      _drawPhaseArc(
        canvas, 
        center, 
        radius, 
        startAngle, 
        inhaleAngle, 
        BreathingPhase.inhale,
        currentPhase == BreathingPhase.inhale ? progress : null,
      );
      startAngle += inhaleAngle;
    }
    
    // Draw inhale hold arc
    if (pattern.inhaleHoldSeconds > 0) {
      _drawPhaseArc(
        canvas, 
        center, 
        radius, 
        startAngle, 
        inhaleHoldAngle, 
        BreathingPhase.inhaleHold,
        currentPhase == BreathingPhase.inhaleHold ? progress : null,
      );
      startAngle += inhaleHoldAngle;
    }
    
    // Draw exhale arc
    if (pattern.exhaleSeconds > 0) {
      _drawPhaseArc(
        canvas, 
        center, 
        radius, 
        startAngle, 
        exhaleAngle, 
        BreathingPhase.exhale,
        currentPhase == BreathingPhase.exhale ? progress : null,
      );
      startAngle += exhaleAngle;
    }
    
    // Draw exhale hold arc
    if (pattern.exhaleHoldSeconds > 0) {
      _drawPhaseArc(
        canvas, 
        center, 
        radius, 
        startAngle, 
        exhaleHoldAngle, 
        BreathingPhase.exhaleHold,
        currentPhase == BreathingPhase.exhaleHold ? progress : null,
      );
    }
    
    // Draw phase indicators
    _drawPhaseIndicators(canvas, size, center, radius);
  }
  
  /// Draw an arc for a breathing phase
  void _drawPhaseArc(
    Canvas canvas, 
    Offset center, 
    double radius, 
    double startAngle, 
    double sweepAngle, 
    BreathingPhase phase,
    double? progressOverlay,
  ) {
    // Get color for this phase
    final color = phaseColors[phase] ?? _getDefaultColorForPhase(phase);
    
    // Draw background arc
    final backgroundPaint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;
    
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      backgroundPaint,
    );
    
    // Draw progress overlay if this is the current phase
    if (progressOverlay != null) {
      final progressPaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8.0;
      
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle * progressOverlay,
        false,
        progressPaint,
      );
    }
  }
  
  /// Draw indicators for each phase
  void _drawPhaseIndicators(Canvas canvas, Size size, Offset center, double radius) {
    // Calculate total cycle duration
    final totalDuration = pattern.inhaleSeconds + 
                         pattern.inhaleHoldSeconds + 
                         pattern.exhaleSeconds + 
                         pattern.exhaleHoldSeconds;
    
    if (totalDuration <= 0) return;
    
    // Starting angle (top of the circle)
    double currentAngle = -pi / 2;
    
    // Draw inhale indicator
    if (pattern.inhaleSeconds > 0) {
      final inhaleAngle = 2 * pi * (pattern.inhaleSeconds / totalDuration);
      _drawPhaseIndicator(
        canvas, 
        center, 
        radius, 
        currentAngle + inhaleAngle / 2, 
        BreathingPhase.inhale,
      );
      currentAngle += inhaleAngle;
    }
    
    // Draw inhale hold indicator
    if (pattern.inhaleHoldSeconds > 0) {
      final inhaleHoldAngle = 2 * pi * (pattern.inhaleHoldSeconds / totalDuration);
      _drawPhaseIndicator(
        canvas, 
        center, 
        radius, 
        currentAngle + inhaleHoldAngle / 2, 
        BreathingPhase.inhaleHold,
      );
      currentAngle += inhaleHoldAngle;
    }
    
    // Draw exhale indicator
    if (pattern.exhaleSeconds > 0) {
      final exhaleAngle = 2 * pi * (pattern.exhaleSeconds / totalDuration);
      _drawPhaseIndicator(
        canvas, 
        center, 
        radius, 
        currentAngle + exhaleAngle / 2, 
        BreathingPhase.exhale,
      );
      currentAngle += exhaleAngle;
    }
    
    // Draw exhale hold indicator
    if (pattern.exhaleHoldSeconds > 0) {
      final exhaleHoldAngle = 2 * pi * (pattern.exhaleHoldSeconds / totalDuration);
      _drawPhaseIndicator(
        canvas, 
        center, 
        radius, 
        currentAngle + exhaleHoldAngle / 2, 
        BreathingPhase.exhaleHold,
      );
    }
  }
  
  /// Draw an indicator for a breathing phase
  void _drawPhaseIndicator(
    Canvas canvas, 
    Offset center, 
    double radius, 
    double angle, 
    BreathingPhase phase,
  ) {
    // Get color for this phase
    final color = phaseColors[phase] ?? _getDefaultColorForPhase(phase);
    
    // Calculate position
    final x = center.dx + cos(angle) * radius;
    final y = center.dy + sin(angle) * radius;
    
    // Draw indicator
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    // Highlight current phase
    final isCurrentPhase = phase == currentPhase;
    final indicatorRadius = isCurrentPhase ? 6.0 : 4.0;
    
    canvas.drawCircle(
      Offset(x, y),
      indicatorRadius,
      paint,
    );
    
    // Draw border for current phase
    if (isCurrentPhase) {
      final borderPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      
      canvas.drawCircle(
        Offset(x, y),
        indicatorRadius,
        borderPaint,
      );
    }
  }
  
  /// Get the default color for a breathing phase
  Color _getDefaultColorForPhase(BreathingPhase phase) {
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
  
  @override
  bool shouldRepaint(PatternVisualizationPainter oldDelegate) {
    return oldDelegate.pattern != pattern ||
           oldDelegate.currentPhase != currentPhase ||
           oldDelegate.progress != progress;
  }
}

/// A widget that displays a grid of breathing pattern previews
class BreathingPatternPreviewGrid extends StatelessWidget {
  /// The list of patterns to display
  final List<BreathingPatternItem> patterns;
  
  /// The number of columns in the grid
  final int crossAxisCount;
  
  /// The spacing between items
  final double spacing;
  
  /// The size of each preview
  final double previewSize;
  
  /// Whether to auto-animate the previews
  final bool autoAnimate;
  
  /// The speed multiplier for the animations
  final double speedMultiplier;
  
  /// Callback when a pattern is selected
  final Function(BreathingPattern pattern)? onPatternSelected;

  /// Creates a new BreathingPatternPreviewGrid
  const BreathingPatternPreviewGrid({
    Key? key,
    required this.patterns,
    this.crossAxisCount = 2,
    this.spacing = 16.0,
    this.previewSize = 150,
    this.autoAnimate = true,
    this.speedMultiplier = 2.0,
    this.onPatternSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: 1.0,
      ),
      itemCount: patterns.length,
      itemBuilder: (context, index) {
        final item = patterns[index];
        return Column(
          children: [
            Expanded(
              child: BreathingPatternPreview(
                pattern: item.pattern,
                size: previewSize,
                autoAnimate: autoAnimate,
                speedMultiplier: speedMultiplier,
                onTap: () {
                  if (onPatternSelected != null) {
                    onPatternSelected!(item.pattern);
                  }
                },
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}

/// A class representing a breathing pattern item with a name
class BreathingPatternItem {
  /// The name of the pattern
  final String name;
  
  /// The breathing pattern
  final BreathingPattern pattern;

  /// Creates a new BreathingPatternItem
  const BreathingPatternItem({
    required this.name,
    required this.pattern,
  });
}