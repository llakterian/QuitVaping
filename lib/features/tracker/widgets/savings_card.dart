import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/models/user_model.dart';
import '../../../data/models/progress_model.dart';
import '../../../shared/theme/app_colors.dart';

class SavingsCard extends StatelessWidget {
  final UserModel user;
  final ProgressModel? progress;

  const SavingsCard({
    Key? key,
    required this.user,
    this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (user.quitDate == null) {
      return const SizedBox.shrink();
    }

    final currencyFormatter = NumberFormat.currency(symbol: '\$');
    final dailySavings = progress?.dailySavings ?? _calculateDailySavings();
    final totalSavings = progress?.totalMoneySaved ?? _calculateTotalSavings(dailySavings);
    
    // Calculate projections
    final monthlySavings = dailySavings * 30;
    final yearlySavings = dailySavings * 365;
    final fiveYearSavings = dailySavings * 365 * 5;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.savings, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  'Money Saved',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            Center(
              child: Column(
                children: [
                  Text(
                    currencyFormatter.format(totalSavings),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    'saved so far',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            
            Text(
              'Projections',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
            
            _buildProjectionRow(
              context,
              'Monthly',
              currencyFormatter.format(monthlySavings),
            ),
            const SizedBox(height: 8),
            _buildProjectionRow(
              context,
              'Yearly',
              currencyFormatter.format(yearlySavings),
            ),
            const SizedBox(height: 8),
            _buildProjectionRow(
              context,
              '5 Years',
              currencyFormatter.format(fiveYearSavings),
            ),
            
            const SizedBox(height: 16),
            
            if (yearlySavings >= 500) ...[
              _buildRewardSuggestion(context, yearlySavings),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProjectionRow(BuildContext context, String label, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildRewardSuggestion(BuildContext context, double yearlySavings) {
    String rewardSuggestion;
    
    if (yearlySavings >= 2000) {
      rewardSuggestion = 'a vacation';
    } else if (yearlySavings >= 1000) {
      rewardSuggestion = 'a new smartphone';
    } else {
      rewardSuggestion = 'a nice weekend getaway';
    }
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 26),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb, color: AppColors.accent),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'With your yearly savings, you could afford $rewardSuggestion!',
              style: TextStyle(
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _calculateDailySavings() {
    // Simple calculation based on device type and frequency
    double costPerDay = 0.0;
    
    switch (user.vapingHistory.deviceType) {
      case 'Disposable':
        // Assuming disposables cost around $10 and last 1-3 days depending on usage
        costPerDay = 10.0 * (user.vapingHistory.dailyFrequency / 20);
        break;
      case 'Pod System':
        // Assuming pods cost around $5 and e-liquid costs around $20 per week
        costPerDay = 5.0 / 3.0 + 20.0 / 7.0;
        break;
      case 'Mod':
        // Assuming coils cost around $3 each and last 1 week, and e-liquid costs around $20 per week
        costPerDay = 3.0 / 7.0 + 20.0 / 7.0;
        break;
      default:
        // Default calculation
        costPerDay = 5.0;
    }
    
    // Adjust based on frequency (higher usage = higher cost)
    costPerDay *= (user.vapingHistory.dailyFrequency / 10);
    
    // Ensure minimum daily cost
    return costPerDay < 1.0 ? 1.0 : costPerDay;
  }

  double _calculateTotalSavings(double dailySavings) {
    if (user.quitDate == null) return 0;
    final daysSinceQuitting = user.daysSinceQuitting;
    return dailySavings * daysSinceQuitting;
  }
}