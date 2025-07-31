import 'package:quit_vaping/features/breathing/models/breathing_phase.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/breathing_phase.dart';
import '../widgets/breathing_animation_widget.dart';

/// A custom painter for rendering breathing animations efficiently
class OptimizedBreathingAnimationPainter extends CustomPainter {
  /// The current size of the animation
  final double size;
  
  /// The color to use for the animation
  final Color color;
  
  /// The current breathing phase
  final BreathingPhase phase;
  
  /// The progress within the current phase (0.0 to 1.0)
  final double phaseProgress;
  
  /// Whether to show particle effects (for higher-end devices)
  final bool showParticles;
  
  /// Random number generator for particles
  final Random _random = Random();
  
  /// List of particles for advanced animations
  final List<_AnimationParticle> _particles = [];
  
  /// Creates a new OptimizedBreathingAnimationPainter
  OptimizedBreathingAnimationPainter({
    required this.size,
    required this.color,
    required this.phase,
    required this.phaseProgress,
    this.showParticles = false,
  }) {
    // Initialize particles if needed
    if (showParticles && _particles.isEmpty) {
      _initializeParticles();
    }
  }
  
  /// Initialize particles for advanced animations
  void _initializeParticles() {
    const particleCount = 20;
    _particles.clear();
    
    for (int i = 0; i < particleCount; i++) {
      _particles.add(_AnimationParticle(
        angle: _random.nextDouble() * 2 * pi,
        distance: _random.nextDouble() * (size / 2),
        size: _random.nextDouble() * 4 + 2,
        opacity: _random.nextDouble() * 0.6 + 0.2,
        speed: _random.nextDouble() * 0.02 + 0.01,
      ));
    }
  }
  
  @override
  void paint(Canvas canvas, Size canvasSize) {
    final center = Offset(canvasSize.width / 2, canvasSize.height / 2);
    
    // Draw the main circle
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    
    canvas.drawCircle(center, size / 2, paint);
    
    // Draw phase-specific effects based on complexity
    switch (phase) {
      case BreathingPhase.inhale:
        _drawInhaleEffects(canvas, center, paint);
        break;
      case BreathingPhase.inhaleHold:
        _drawInhaleHoldEffects(canvas, center, paint);
        break;
      case BreathingPhase.exhale:
        _drawExhaleEffects(canvas, center, paint);
        break;
      case BreathingPhase.exhaleHold:
        _drawExhaleHoldEffects(canvas, center, paint);
        break;
    }
    
    // Draw particles for advanced animations
    if (showParticles) {
      _drawParticles(canvas, center, paint);
    }
  }
  
  /// Draw effects with appropriate complexity
  void _drawEffectsWithComplexity(Canvas canvas, Offset center, Paint paint, Function(Canvas, Offset, Paint) drawFunction) {
    // Simple complexity: Skip additional effects
    if (!showParticles) {
      return;
    }
    
    // Standard and advanced complexity: Draw effects
    drawFunction(canvas, center, paint);
  }
  
  /// Draw effects specific to the inhale phase
  void _drawInhaleEffects(Canvas canvas, Offset center, Paint paint) {
    // Always draw basic expanding ring (all complexity levels)
    final ringPaint = Paint()
      ..color = color.withOpacity(0.3 - (phaseProgress * 0.3))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    
    final ringRadius = (size / 2) * (1.0 + phaseProgress * 0.2);
    canvas.drawCircle(center, ringRadius, ringPaint);
    
    // Draw directional arrows only for standard and advanced complexity
    _drawEffectsWithComplexity(canvas, center, paint, (c, ctr, p) {
      _drawDirectionalArrows(c, ctr, true);
    });
  }
  
  /// Draw effects specific to the inhale hold phase
  void _drawInhaleHoldEffects(Canvas canvas, Offset center, Paint paint) {
    // Always draw basic pulsing effect (all complexity levels)
    final pulseValue = sin(phaseProgress * pi * 4) * 0.05 + 1.0;
    final pulsePaint = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    
    canvas.drawCircle(center, (size / 2) * pulseValue, pulsePaint);
    
    // Draw hold indicator only for standard and advanced complexity
    _drawEffectsWithComplexity(canvas, center, paint, (c, ctr, p) {
      final holdPaint = Paint()
        ..color = Colors.white.withOpacity(0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      
      c.drawCircle(ctr, (size / 2) - 5, holdPaint);
    });
  }
  
  /// Draw effects specific to the exhale phase
  void _drawExhaleEffects(Canvas canvas, Offset center, Paint paint) {
    // Always draw basic contracting ring (all complexity levels)
    final ringPaint = Paint()
      ..color = color.withOpacity(0.1 + (phaseProgress * 0.2))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    
    final ringRadius = (size / 2) * (1.0 - phaseProgress * 0.1);
    canvas.drawCircle(center, ringRadius, ringPaint);
    
    // Draw directional arrows only for standard and advanced complexity
    _drawEffectsWithComplexity(canvas, center, paint, (c, ctr, p) {
      _drawDirectionalArrows(c, ctr, false);
    });
  }
  
  /// Draw effects specific to the exhale hold phase
  void _drawExhaleHoldEffects(Canvas canvas, Offset center, Paint paint) {
    // Always draw basic pulsing effect (all complexity levels)
    final pulseValue = sin(phaseProgress * pi * 3) * 0.03 + 1.0;
    final pulsePaint = Paint()
      ..color = color.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    
    canvas.drawCircle(center, (size / 2) * pulseValue, pulsePaint);
    
    // Draw dashed circle only for standard and advanced complexity
    _drawEffectsWithComplexity(canvas, center, paint, (c, ctr, p) {
      _drawDashedCircle(
        c, 
        ctr, 
        (size / 2) - 4, 
        Colors.white.withOpacity(0.25), 
        2.0, 
        12
      );
    });
  }
  
  /// Draw directional arrows to indicate inhale/exhale
  void _drawDirectionalArrows(Canvas canvas, Offset center, bool inward) {
    final arrowPaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;
    
    const arrowCount = 8;
    final radius = size / 2;
    final arrowLength = radius * 0.15;
    final arrowDistance = inward 
        ? radius * (1.2 - phaseProgress * 0.3)
        : radius * (0.9 + phaseProgress * 0.3);
    
    for (int i = 0; i < arrowCount; i++) {
      final angle = (i / arrowCount) * 2 * pi;
      final x = center.dx + cos(angle) * arrowDistance;
      final y = center.dy + sin(angle) * arrowDistance;
      final arrowCenter = Offset(x, y);
      
      // Draw arrow line
      final lineStart = Offset(
        arrowCenter.dx - cos(angle) * arrowLength * (inward ? -1 : 1),
        arrowCenter.dy - sin(angle) * arrowLength * (inward ? -1 : 1),
      );
      
      canvas.drawLine(lineStart, arrowCenter, arrowPaint);
      
      // Draw arrow head
      final headAngle1 = angle + (inward ? -pi/4 : 3*pi/4);
      final headAngle2 = angle + (inward ? pi/4 : -3*pi/4);
      
      final headLength = arrowLength * 0.6;
      
      final head1 = Offset(
        arrowCenter.dx + cos(headAngle1) * headLength,
        arrowCenter.dy + sin(headAngle1) * headLength,
      );
      
      final head2 = Offset(
        arrowCenter.dx + cos(headAngle2) * headLength,
        arrowCenter.dy + sin(headAngle2) * headLength,
      );
      
      canvas.drawLine(arrowCenter, head1, arrowPaint);
      canvas.drawLine(arrowCenter, head2, arrowPaint);
    }
  }
  
  /// Draw a dashed circle
  void _drawDashedCircle(
    Canvas canvas, 
    Offset center, 
    double radius, 
    Color color, 
    double strokeWidth, 
    int dashCount
  ) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    
    final dashLength = (2 * pi * radius) / (dashCount * 2);
    
    for (int i = 0; i < dashCount; i++) {
      final startAngle = (i * 2 * pi / dashCount);
      final endAngle = startAngle + (pi / dashCount);
      
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        endAngle - startAngle,
        false,
        paint,
      );
    }
  }
  
  /// Draw particles for advanced animations
  void _drawParticles(Canvas canvas, Offset center, Paint basePaint) {
    final particlePaint = Paint()
      ..style = PaintingStyle.fill;
    
    for (final particle in _particles) {
      // Update particle position based on phase
      particle.update(phase, phaseProgress);
      
      // Calculate position
      final x = center.dx + cos(particle.angle) * particle.distance;
      final y = center.dy + sin(particle.angle) * particle.distance;
      
      // Draw particle
      particlePaint.color = color.withOpacity(particle.opacity);
      canvas.drawCircle(Offset(x, y), particle.size, particlePaint);
    }
  }
  
  @override
  bool shouldRepaint(OptimizedBreathingAnimationPainter oldDelegate) {
    return oldDelegate.size != size ||
           oldDelegate.color != color ||
           oldDelegate.phase != phase ||
           oldDelegate.phaseProgress != phaseProgress ||
           oldDelegate.showParticles != showParticles;
  }
}

/// A particle used in advanced breathing animations
class _AnimationParticle {
  /// The angle of the particle (in radians)
  double angle;
  
  /// The distance from the center
  double distance;
  
  /// The size of the particle
  double size;
  
  /// The opacity of the particle
  double opacity;
  
  /// The movement speed of the particle
  double speed;
  
  /// Creates a new animation particle
  _AnimationParticle({
    required this.angle,
    required this.distance,
    required this.size,
    required this.opacity,
    required this.speed,
  });
  
  /// Update the particle based on the current phase and progress
  void update(BreathingPhase phase, double progress) {
    // Update angle for subtle movement
    angle += speed;
    
    // Update distance based on phase
    switch (phase) {
      case BreathingPhase.inhale:
        // Move particles outward during inhale
        distance += speed * 2;
        if (distance > 100) {
          distance = 0; // Reset to center
          opacity = Random().nextDouble() * 0.6 + 0.2;
        }
        break;
      case BreathingPhase.inhaleHold:
        // Subtle circular movement during hold
        angle += speed * 0.5;
        break;
      case BreathingPhase.exhale:
        // Move particles inward during exhale
        distance -= speed * 2;
        if (distance < 0) {
          distance = 100; // Reset to outer edge
          opacity = Random().nextDouble() * 0.6 + 0.2;
        }
        break;
      case BreathingPhase.exhaleHold:
        // Subtle circular movement during hold
        angle += speed * 0.5;
        break;
    }
  }
}