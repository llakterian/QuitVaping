import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../data/services/subscription_service.dart';
import '../../checkins/screens/checkin_screen.dart';
import '../../ai_chat/screens/ai_chat_screen.dart';
import '../../breathing/screens/breathing_screen.dart';
import '../../panic_mode/screens/panic_mode_screen.dart';
import '../../nrt_tracker/screens/nrt_tracker_screen.dart';
import '../../subscription/screens/subscription_screen.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({Key? key}) : super(key: key);

  // Cache static widgets to improve performance
  static const Widget _titleIcon = Icon(Icons.flash_on, color: AppColors.primary);
  static const Widget _spacing = SizedBox(width: 8);
  static const Widget _verticalSpacing = SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    // Get subscription status
    final subscriptionService = Provider.of<SubscriptionService>(context);
    final isPremium = subscriptionService.isPremium;
    
    // Create action buttons with context
    final actionButtons = [
      _buildActionButton(
        context,
        'Log Craving',
        Icons.add_circle,
        AppColors.primary,
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CheckinScreen()),
        ),
      ),
      _spacing,
      _buildActionButton(
        context,
        'AI Coach',
        Icons.chat,
        AppColors.secondary,
        () {
          if (isPremium) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AIChatScreen()),
            );
          } else {
            // Show subscription screen for non-premium users
            _showPremiumFeatureDialog(context, 'AI Coach');
          }
        },
        isPremium: isPremium,
      ),
      _spacing,
      _buildActionButton(
        context,
        'Breathe',
        Icons.self_improvement,
        AppColors.accent,
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Scaffold(body: Center(child: Text("Breathing exercises coming soon")))), // Temporarily replaced
        ),
      ),
      _spacing,
      _buildActionButton(
        context,
        'Panic',
        Icons.emergency,
        AppColors.error,
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PanicModeScreen()),
        ),
      ),
      _spacing,
      _buildActionButton(
        context,
        'NRT',
        Icons.medication,
        AppColors.secondary,
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NRTTrackerScreen()),
        ),
      ),
      _spacing,
      _buildActionButton(
        context,
        'Premium',
        Icons.star,
        Colors.amber,
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SubscriptionScreen()),
        ),
        showBadge: !isPremium,
      ),
    ];
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _titleIcon,
                _spacing,
                Text(
                  'Quick Actions',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            _verticalSpacing,
            
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: actionButtons),
            ),
          ],
        ),
      ),
    );
  }
  
  // Helper method to build action buttons
  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap, {
    bool isPremium = true,
    bool showBadge = false,
  }) {
    return _QuickActionButton(
      label: label,
      icon: icon,
      color: color,
      onTap: onTap,
      isPremium: isPremium,
      showBadge: showBadge,
    );
  }
  
  // Show dialog for premium features
  void _showPremiumFeatureDialog(BuildContext context, String featureName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$featureName is a Premium Feature'),
        content: const Text(
          'Upgrade to Premium to unlock this feature and remove ads.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('LATER'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SubscriptionScreen()),
              );
            },
            child: const Text('UPGRADE NOW'),
          ),
        ],
      ),
    );
  }

}

// Optimized action button widget with const constructor
class _QuickActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool isPremium;
  final bool showBadge;

  const _QuickActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
    this.isPremium = true,
    this.showBadge = false,
  });

  static const EdgeInsets _buttonPadding = EdgeInsets.all(8.0);
  static const EdgeInsets _iconPadding = EdgeInsets.all(12);
  static const SizedBox _iconTextSpacing = SizedBox(height: 8);
  static const BorderRadius _borderRadius = BorderRadius.all(Radius.circular(8));

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: _borderRadius,
      child: Padding(
        padding: _buttonPadding,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: _iconPadding,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color),
                ),
                if (!isPremium)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Icon(
                      Icons.lock,
                      size: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                if (showBadge)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 8,
                        minHeight: 8,
                      ),
                    ),
                  ),
              ],
            ),
            _iconTextSpacing,
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isPremium ? const Color(0xFF424242) : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}