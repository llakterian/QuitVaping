import 'package:flutter/material.dart';
import 'dart:math';

import '../../../shared/theme/app_colors.dart';

class BreathingAnimation extends StatefulWidget {
  final String action;
  final int duration;

  const BreathingAnimation({
    Key? key,
    required this.action,
    required this.duration,
  }) : super(key: key);

  @override
  State<BreathingAnimation> createState() => _BreathingAnimationState();
}

class _BreathingAnimationState extends State<BreathingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    );

    _updateAnimation();
    _controller.forward();
  }

  @override
  void didUpdateWidget(BreathingAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.action != widget.action || oldWidget.duration != widget.duration) {
      _controller.duration = Duration(seconds: widget.duration);
      _updateAnimation();
      _controller.forward(from: 0.0);
    }
  }

  void _updateAnimation() {
    switch (widget.action) {
      case 'inhale':
        _animation = Tween<double>(begin: 0.3, end: 1.0).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );
        break;
      case 'hold':
        _animation = Tween<double>(begin: 1.0, end: 1.0).animate(
          CurvedAnimation(parent: _controller, curve: Curves.linear),
        );
        break;
      case 'exhale':
        _animation = Tween<double>(begin: 1.0, end: 0.3).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );
        break;
      default:
        _animation = Tween<double>(begin: 0.5, end: 0.5).animate(
          CurvedAnimation(parent: _controller, curve: Curves.linear),
        );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (widget.action) {
      case 'inhale':
        color = AppColors.breatheIn;
        break;
      case 'hold':
        color = AppColors.breatheHold;
        break;
      case 'exhale':
        color = AppColors.breatheOut;
        break;
      default:
        color = AppColors.primary;
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Center(
          child: Container(
            width: 200 * _animation.value,
            height: 200 * _animation.value,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: 51),
              border: Border.all(
                color: color,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 77),
                  blurRadius: 20 * _animation.value,
                  spreadRadius: 5 * _animation.value,
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 100 * _animation.value,
                height: 100 * _animation.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withValues(alpha: 128),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}