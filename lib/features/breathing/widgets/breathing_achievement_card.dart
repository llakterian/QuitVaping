import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/common_widgets.dart';
import '../models/breathing_achievement_model.dart';

/// A widget that displays a breathing achievement
class BreathingAchievementCard extends StatelessWidget {
  /// The achievement to display
  final BreathingAchievementModel achievement;
  
  /// Creates a new BreathingAchievementCard
  const BreathingAchievementCard({
    Key? key,
    required this.achievement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // Achievement icon
          _buildAchievementIcon(),
          
          const SizedBox(width: 12),
          
          // Achievement details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Achievement name
                Text(
                  achievement.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 4),
                
                // Achievement description
                Text(
                  achievement.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Progress indicator
                _buildProgressIndicator(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  /// Builds the achievement icon
  Widget _buildAchievementIcon() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: achievement.unlocked
            ? AppColors.primary.withOpacity(0.1)
            : Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: Icon(
        achievement.icon,
        size: 30,
        color: achievement.unlocked ? AppColors.primary : Colors.grey[400],
      ),
    );
  }
  
  /// Builds the progress indicator
  Widget _buildProgressIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Progress text
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              achievement.unlocked
                  ? 'Completed'
                  : '${achievement.formattedProgress} / ${achievement.formattedMilestone}',
              style: TextStyle(
                fontSize: 12,
                color: achievement.unlocked ? AppColors.success : AppColors.textSecondary,
                fontWeight: achievement.unlocked ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            
            // Unlocked date
            if (achievement.unlocked && achievement.unlockedAt != null)
              Text(
                DateFormat('MMM d, yyyy').format(achievement.unlockedAt!),
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textTertiary,
                ),
              ),
          ],
        ),
        
        const SizedBox(height: 4),
        
        // Progress bar
        LinearProgressIndicator(
          value: achievement.progressPercentage / 100,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(
            achievement.unlocked ? AppColors.success : AppColors.primary,
          ),
          minHeight: 6,
          borderRadius: BorderRadius.circular(3),
        ),
      ],
    );
  }
}

/// A widget that displays a grid of achievements
class BreathingAchievementsGrid extends StatelessWidget {
  /// The achievements to display
  final List<BreathingAchievementModel> achievements;
  
  /// The title to display above the grid
  final String title;
  
  /// Creates a new BreathingAchievementsGrid
  const BreathingAchievementsGrid({
    Key? key,
    required this.achievements,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (achievements.isEmpty) {
      return const SizedBox();
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
        // Achievements grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: achievements.length,
          itemBuilder: (context, index) {
            return _buildAchievementTile(achievements[index]);
          },
        ),
      ],
    );
  }
  
  /// Builds a single achievement tile
  Widget _buildAchievementTile(BreathingAchievementModel achievement) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Achievement icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: achievement.unlocked
                  ? AppColors.primary.withOpacity(0.1)
                  : Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(
              achievement.icon,
              size: 30,
              color: achievement.unlocked ? AppColors.primary : Colors.grey[400],
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Achievement name
          Text(
            achievement.name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 4),
          
          // Progress text
          Text(
            achievement.unlocked
                ? 'Completed'
                : '${achievement.progressPercentage}%',
            style: TextStyle(
              fontSize: 12,
              color: achievement.unlocked ? AppColors.success : AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 4),
          
          // Progress indicator
          SizedBox(
            width: 60,
            child: LinearProgressIndicator(
              value: achievement.progressPercentage / 100,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                achievement.unlocked ? AppColors.success : AppColors.primary,
              ),
              minHeight: 4,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}