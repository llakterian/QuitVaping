import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A widget that displays an animation when a breathing cycle is completed.
/// Provides visual feedback and optional haptic feedback.
class BreathingCycleCompletionFeedback extends StatefulWidget {
  /// Whether to show the animation
  final bool show;
  
  /// The size of the animation
  final double size;
  
  /// The color of the animation
  final Color color;
  
  /// Whether to use haptic feedback
  final bool useHapticFeedback;
  
  /// The duration of the animation
  final Duration animationDuration;
  
  /// Callback when the animation completes
  final VoidCallback? onAnimationComplete;

  /// Creates a new BreathingCycleCompletionFeedback
  const BreathingCycleCompletionFeedback({
    Key? key,
    required this.show,
    this.size = 200,
    this.color = Colors.green,
    this.useHapticFeedback = true,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.onAnimationComplete,
  }) : super(key: key);

  @override
  State<BreathingCycleCompletionFeedback> createState() => _BreathingCycleCompletionFeedbackState();
}

class _BreathingCycleCompletionFeedbackState extends State<BreathingCycleCompletionFeedback> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  bool _isAnimating = false;
  
  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    
    // Scale animation (grow and shrink)
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.2),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1.0),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.0),
        weight: 30,
      ),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    
    // Opacity animation (fade in and out)
    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.0),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0),
        weight: 20,
      ),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    
    // Add listener for animation completion
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isAnimating = false;
        });
        
        if (widget.onAnimationComplete != null) {
          widget.onAnimationComplete!();
        }
        
        _controller.reset();
      }
    });
  }
  
  @override
  void didUpdateWidget(BreathingCycleCompletionFeedback oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Start animation when show changes from false to true
    if (widget.show && !oldWidget.show && !_isAnimating) {
      _startAnimation();
    }
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  /// Start the animation
  void _startAnimation() {
    // Provide haptic feedback if enabled
    if (widget.useHapticFeedback) {
      HapticFeedback.heavyImpact();
    }
    
    setState(() {
      _isAnimating = true;
    });
    
    _controller.forward(from: 0.0);
  }
  
  @override
  Widget build(BuildContext context) {
    if (!_isAnimating && !widget.show) {
      return const SizedBox.shrink();
    }
    
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: SizedBox(
              width: widget.size,
              height: widget.size,
              child: CustomPaint(
                painter: CycleCompletionPainter(
                  progress: _controller.value,
                  color: widget.color,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Custom painter for the cycle completion animation
class CycleCompletionPainter extends CustomPainter {
  final double progress;
  final Color color;
  
  CycleCompletionPainter({
    required this.progress,
    required this.color,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    
    // Draw outer circle
    final outerCirclePaint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;
    
    canvas.drawCircle(center, radius * 0.9, outerCirclePaint);
    
    // Draw animated arc
    final arcPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;
    
    // Calculate arc angle based on progress
    final arcProgress = min(progress * 1.5, 1.0); // Complete at 2/3 of the animation
    final arcAngle = 2 * pi * arcProgress;
    
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius * 0.9),
      -pi / 2, // Start from the top
      arcAngle,
      false,
      arcPaint,
    );
    
    // Draw checkmark if progress is past 2/3
    if (progress > 0.6) {
      final checkmarkProgress = (progress - 0.6) / 0.4; // Scale to 0-1 for the last 40% of animation
      
      final checkmarkPaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10.0
        ..strokeCap = StrokeCap.round;
      
      // Calculate checkmark points
      final leftPoint = Offset(
        center.dx - radius * 0.3,
        center.dy + radius * 0.1,
      );
      
      final middlePoint = Offset(
        center.dx - radius * 0.1,
        center.dy + radius * 0.3,
      );
      
      final rightPoint = Offset(
        center.dx + radius * 0.4,
        center.dy - radius * 0.3,
      );
      
      // Draw first part of checkmark (left to middle)
      if (checkmarkProgress <= 0.5) {
        final firstSegmentProgress = checkmarkProgress * 2; // Scale to 0-1 for first half
        
        final currentMiddleX = leftPoint.dx + (middlePoint.dx - leftPoint.dx) * firstSegmentProgress;
        final currentMiddleY = leftPoint.dy + (middlePoint.dy - leftPoint.dy) * firstSegmentProgress;
        
        canvas.drawLine(
          leftPoint,
          Offset(currentMiddleX, currentMiddleY),
          checkmarkPaint,
        );
      } else {
        // Draw complete first segment
        canvas.drawLine(leftPoint, middlePoint, checkmarkPaint);
        
        // Draw second part of checkmark (middle to right)
        final secondSegmentProgress = (checkmarkProgress - 0.5) * 2; // Scale to 0-1 for second half
        
        final currentRightX = middlePoint.dx + (rightPoint.dx - middlePoint.dx) * secondSegmentProgress;
        final currentRightY = middlePoint.dy + (rightPoint.dy - middlePoint.dy) * secondSegmentProgress;
        
        canvas.drawLine(
          middlePoint,
          Offset(currentRightX, currentRightY),
          checkmarkPaint,
        );
      }
    }
    
    // Draw particles if progress is past 80%
    if (progress > 0.8) {
      final particleProgress = (progress - 0.8) / 0.2; // Scale to 0-1 for the last 20% of animation
      
      final particlePaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      
      // Draw 8 particles radiating outward
      for (int i = 0; i < 8; i++) {
        final angle = i * pi / 4;
        final particleRadius = 5.0;
        final distance = radius * 1.2 * particleProgress;
        
        final particleX = center.dx + cos(angle) * distance;
        final particleY = center.dy + sin(angle) * distance;
        
        // Create a new paint with adjusted opacity
        final fadedPaint = Paint()
          ..color = particlePaint.color.withOpacity(1 - particleProgress)
          ..style = particlePaint.style;
          
        canvas.drawCircle(
          Offset(particleX, particleY),
          particleRadius * (1 - particleProgress), // Shrink as they move outward
          fadedPaint, // Fade as they move outward
        );
      }
    }
  }
  
  @override
  bool shouldRepaint(CycleCompletionPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}