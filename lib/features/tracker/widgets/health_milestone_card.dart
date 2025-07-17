import 'package:flutter/material.dart';

import '../../../data/models/user_model.dart';
import '../../../data/models/progress_model.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/constants/app_constants.dart';

class HealthMilestoneCard extends StatelessWidget {
  final UserModel user;
  final ProgressModel? progress;

  const HealthMilestoneCard({
    Key? key,
    required this.user,
    this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (user.quitDate == null) {
      return const SizedBox.shrink();
    }

    final nextMilestone = progress?.getNextMilestone(AppConstants.healthMilestones) ?? 
        _calculateNextMilestone();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.favorite, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  'Health Recovery',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            if (nextMilestone['completed'] == true) ...[
              _buildCompletedMilestones(context),
            ] else ...[
              _buildNextMilestone(context, nextMilestone),
            ],
            
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            
            Text(
              'Your body is healing! Keep going!',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextMilestone(BuildContext context, Map<String, dynamic> milestone) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Next Milestone:',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          milestone['description'] as String,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        
        LinearProgressIndicator(
          value: 1 - (milestone['hours_remaining'] as int) / (milestone['total_hours'] as int),
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
        const SizedBox(height: 8),
        
        Text(
          _formatTimeRemaining(
            milestone['days_remaining'] as int,
            milestone['remaining_hours'] as int,
          ),
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildCompletedMilestones(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Congratulations!',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'You\'ve reached all tracked health milestones! Your body continues to heal and get stronger every day.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 26),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: AppColors.success),
              const SizedBox(width: 8),
              Text(
                'All milestones achieved',
                style: TextStyle(
                  color: AppColors.success,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatTimeRemaining(int days, int hours) {
    if (days > 0) {
      return '$days ${days == 1 ? 'day' : 'days'} and $hours ${hours == 1 ? 'hour' : 'hours'} remaining';
    } else {
      return '$hours ${hours == 1 ? 'hour' : 'hours'} remaining';
    }
  }

  Map<String, dynamic> _calculateNextMilestone() {
    if (user.quitDate == null) {
      return {
        'completed': false,
        'hours_remaining': 0,
        'days_remaining': 0,
        'remaining_hours': 0,
        'description': 'Set a quit date to see your next milestone',
        'total_hours': 0,
      };
    }

    final hoursQuit = user.hoursSinceQuitting;
    
    // Find the next milestone
    int? nextMilestoneHours;
    String? nextMilestoneDescription;
    
    for (final entry in AppConstants.healthMilestones.entries) {
      if (entry.key > hoursQuit) {
        nextMilestoneHours = entry.key;
        nextMilestoneDescription = entry.value;
        break;
      }
    }
    
    if (nextMilestoneHours == null) {
      return {
        'completed': true,
        'message': 'You\'ve reached all tracked health milestones! Your body continues to heal.'
      };
    }
    
    final hoursRemaining = nextMilestoneHours - hoursQuit;
    final daysRemaining = hoursRemaining ~/ 24;
    final remainingHours = hoursRemaining % 24;
    
    return {
      'completed': false,
      'hours_remaining': hoursRemaining,
      'days_remaining': daysRemaining,
      'remaining_hours': remainingHours,
      'description': nextMilestoneDescription,
      'total_hours': nextMilestoneHours,
    };
  }
}