import 'package:flutter/material.dart';
import '../../../shared/theme/app_colors.dart';
import '../models/breathing_achievement_model.dart';

/// A widget that displays a notification for an unlocked achievement
class BreathingAchievementNotification extends StatefulWidget {
  /// The achievement that was unlocked
  final BreathingAchievementModel achievement;
  
  /// Callback when the notification is dismissed
  final VoidCallback? onDismiss;
  
  /// Creates a new BreathingAchievementNotification
  const BreathingAchievementNotification({
    Key? key,
    required this.achievement,
    this.onDismiss,
  }) : super(key: key);

  @override
  State<BreathingAchievementNotification> createState() => _BreathingAchievementNotificationState();
}

class _BreathingAchievementNotificationState extends State<BreathingAchievementNotification> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  
  @override
  void initState() {
    super.initState();
    
    // Initialize animations
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.1),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.1, end: 1.0),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.0),
        weight: 50,
      ),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));
    
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
    ]).animate(_controller);
    
    // Start animation
    _controller.forward().then((_) {
      // Auto-dismiss after animation completes
      if (widget.onDismiss != null) {
        widget.onDismiss!();
      }
    });
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          ),
        );
      },
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Achievement unlocked text
            const Text(
              'Achievement Unlocked!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Achievement icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.achievement.icon,
                size: 40,
                color: AppColors.primary,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Achievement name
            Text(
              widget.achievement.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 8),
            
            // Achievement description
            Text(
              widget.achievement.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 16),
            
            // Dismiss button
            TextButton(
              onPressed: widget.onDismiss,
              child: const Text('Awesome!'),
            ),
          ],
        ),
      ),
    );
  }
}

/// A service for showing achievement notifications
class AchievementNotificationService {
  /// Shows an achievement notification
  static void showAchievementNotification(
    BuildContext context,
    BreathingAchievementModel achievement,
  ) {
    // Create overlay entry
    final overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;
    
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.15,
        left: 0,
        right: 0,
        child: Center(
          child: BreathingAchievementNotification(
            achievement: achievement,
            onDismiss: () {
              overlayEntry.remove();
            },
          ),
        ),
      ),
    );
    
    // Insert overlay
    overlayState.insert(overlayEntry);
  }
}