import 'package:flutter/material.dart';
import '../../../shared/theme/app_colors.dart';

/// A card widget that displays the health impact of breathing exercises
class BreathingHealthImpactCard extends StatelessWidget {
  /// The title of the impact
  final String title;
  
  /// The description of the impact
  final String description;
  
  /// The percentage impact (0-100)
  final int impactPercentage;
  
  /// The icon to display
  final IconData icon;
  
  /// Creates a new BreathingHealthImpactCard
  const BreathingHealthImpactCard({
    Key? key,
    required this.title,
    required this.description,
    required this.impactPercentage,
    required this.icon,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: AppColors.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getImpactColor(impactPercentage).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '$impactPercentage%',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _getImpactColor(impactPercentage),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: impactPercentage / 100,
                backgroundColor: Colors.grey[200],
                color: _getImpactColor(impactPercentage),
                minHeight: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  /// Returns a color based on the impact percentage
  Color _getImpactColor(int percentage) {
    if (percentage >= 75) {
      return AppColors.success;
    } else if (percentage >= 50) {
      return AppColors.primary;
    } else if (percentage >= 25) {
      return Colors.amber;
    } else {
      return Colors.orange;
    }
  }
}