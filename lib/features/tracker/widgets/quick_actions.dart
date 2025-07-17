import 'package:flutter/material.dart';

import '../../../shared/theme/app_colors.dart';
import '../../checkins/screens/checkin_screen.dart';
import '../../ai_chat/screens/ai_chat_screen.dart';
import '../../breathing/screens/breathing_screen.dart';
import '../../panic_mode/screens/panic_mode_screen.dart';
import '../../nrt_tracker/screens/nrt_tracker_screen.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.flash_on, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  'Quick Actions',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
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
                  const SizedBox(width: 8),
                  _buildActionButton(
                    context,
                    'AI Coach',
                    Icons.chat,
                    AppColors.secondary,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AIChatScreen()),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildActionButton(
                    context,
                    'Breathe',
                    Icons.self_improvement,
                    AppColors.accent,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BreathingScreen()),
                    ),
                  ),
                  const SizedBox(width: 8),
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
                  const SizedBox(width: 8),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 26),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}