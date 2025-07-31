import 'package:flutter/material.dart';

class BreathingAnimation extends StatelessWidget {
  final AnimationController controller;
  final double size;
  final Color color;
  
  const BreathingAnimation({
    Key? key,
    required this.controller,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final value = controller.value;
        final scale = 0.5 + (value * 0.5); // Scale between 0.5 and 1.0
        final opacity = 0.5 + (value * 0.5); // Opacity between 0.5 and 1.0
        
        return Stack(
          alignment: Alignment.center,
          children: [
            // Outer circle (pulse effect)
            Container(
              width: size * 1.2 * scale,
              height: size * 1.2 * scale,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.1 * opacity),
              ),
            ),
            // Middle circle
            Container(
              width: size * 0.9 * scale,
              height: size * 0.9 * scale,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.3 * opacity),
              ),
            ),
            // Inner circle
            Container(
              width: size * 0.6 * scale,
              height: size * 0.6 * scale,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(opacity),
              ),
              child: Center(
                child: Icon(
                  Icons.self_improvement,
                  size: size * 0.3,
                  color: Colors.white.withOpacity(opacity),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}