import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/user_model.dart';
import '../../../data/models/progress_model.dart';
import '../../../data/services/subscription_service.dart';
import '../../../shared/theme/app_colors.dart';
import '../../subscription/screens/subscription_screen.dart';

class PremiumInsightsCard extends StatelessWidget {
  final UserModel user;
  final ProgressModel progress;

  const PremiumInsightsCard({
    Key? key,
    required this.user,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subscriptionService = Provider.of<SubscriptionService>(context);
    final isPremium = subscriptionService.isPremium;
    
    if (!isPremium) {
      return _buildPremiumPrompt(context);
    }
    
    return _buildInsightsCard(context);
  }
  
  Widget _buildPremiumPrompt(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SubscriptionScreen()),
          );
        },
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
                      color: AppColors.primary.withValues(alpha: 26), // 0.1 * 255 ≈ 26
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.insights,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Premium Insights',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'PREMIUM',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Unlock personalized insights and recommendations based on your quit journey data.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildFeatureItem(Icons.trending_up, 'Progress Predictions'),
                  const SizedBox(width: 16),
                  _buildFeatureItem(Icons.psychology, 'Behavioral Analysis'),
                  const SizedBox(width: 16),
                  _buildFeatureItem(Icons.recommend, 'Custom Recommendations'),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SubscriptionScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 40),
                ),
                child: const Text('Upgrade to Premium'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildFeatureItem(IconData icon, String text) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(height: 4),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
  
  Widget _buildInsightsCard(BuildContext context) {
    // Calculate days since quit date
    final daysSinceQuit = user.quitDate != null ? DateTime.now().difference(user.quitDate!).inDays : 0;
    
    // Calculate projected savings for the year
    final dailySavings = daysSinceQuit > 0 ? progress.totalMoneySaved / daysSinceQuit : 0;
    final projectedYearlySavings = dailySavings * 365;
    
    // Calculate projected health improvement
    final healthImprovementPercentage = _calculateHealthImprovement();
    
    // Calculate next milestone
    final nextMilestone = _getNextMilestone();
    
    // Calculate craving reduction
    final cravingReductionPercentage = _calculateCravingReduction();
    
    return Card(
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
                    color: AppColors.primary.withValues(alpha: 26), // 0.1 * 255 ≈ 26
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.insights,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Your Personalized Insights',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Financial projection
            _buildInsightItem(
              context,
              icon: Icons.savings,
              title: 'Financial Projection',
              content: 'At your current rate, you\'ll save approximately \$${projectedYearlySavings.toStringAsFixed(2)} this year by not vaping.',
            ),
            const Divider(),
            
            // Health improvement
            _buildInsightItem(
              context,
              icon: Icons.favorite,
              title: 'Health Improvement',
              content: 'Your lung function has improved by approximately $healthImprovementPercentage% since you quit.',
            ),
            const Divider(),
            
            // Next milestone
            _buildInsightItem(
              context,
              icon: Icons.emoji_events,
              title: 'Next Health Milestone',
              content: nextMilestone,
            ),
            const Divider(),
            
            // Craving analysis
            _buildInsightItem(
              context,
              icon: Icons.trending_down,
              title: 'Craving Analysis',
              content: 'Your cravings have decreased by approximately $cravingReductionPercentage% since you started your quit journey.',
            ),
            const Divider(),
            
            // Personalized recommendation
            _buildInsightItem(
              context,
              icon: Icons.psychology,
              title: 'Personalized Recommendation',
              content: _getPersonalizedRecommendation(),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildInsightItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(content),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Helper methods to calculate insights
  
  int _calculateHealthImprovement() {
    final daysSinceQuit = user.quitDate != null ? DateTime.now().difference(user.quitDate!).inDays : 0;
    
    // Simple algorithm for health improvement percentage
    // In a real app, this would be more sophisticated
    if (daysSinceQuit <= 7) {
      return 5 + daysSinceQuit * 2; // 5-19% in first week
    } else if (daysSinceQuit <= 30) {
      return 20 + ((daysSinceQuit - 7) * 20 / 23).round(); // 20-40% in first month
    } else if (daysSinceQuit <= 90) {
      return 40 + ((daysSinceQuit - 30) * 20 / 60).round(); // 40-60% in first 3 months
    } else if (daysSinceQuit <= 365) {
      return 60 + ((daysSinceQuit - 90) * 30 / 275).round(); // 60-90% in first year
    } else {
      return 90 + ((daysSinceQuit - 365) * 10 / 365).round().clamp(0, 10); // Up to 100% after a year
    }
  }
  
  String _getNextMilestone() {
    final hoursSinceQuit = user.quitDate != null ? DateTime.now().difference(user.quitDate!).inHours : 0;
    
    // Find the next milestone
    int? nextMilestoneHours;
    String? nextMilestoneDescription;
    
    // Create a map of health milestones if it doesn't exist in the progress model
    final Map<String, String> healthMilestones = {
      "8": "Carbon monoxide levels drop to normal",
      "24": "Nicotine is eliminated from the body",
      "48": "Nerve endings start to regrow",
      "72": "Bronchial tubes relax, making breathing easier",
      "336": "Circulation improves, lung function increases",
      "720": "Coughing and shortness of breath decrease",
      "2160": "Risk of heart attack begins to drop",
      "8760": "Risk of coronary heart disease is half that of a vaper"
    };
    
    // Loop through the health milestones to find the next one
    for (final entry in healthMilestones.entries) {
      final milestoneHours = int.parse(entry.key);
      if (milestoneHours > hoursSinceQuit) {
        nextMilestoneHours = milestoneHours;
        nextMilestoneDescription = entry.value;
        break;
      }
    }
    
    if (nextMilestoneHours == null) {
      return 'You\'ve reached all tracked health milestones! Your body continues to heal every day.';
    }
    
    final hoursRemaining = nextMilestoneHours - hoursSinceQuit;
    final daysRemaining = (hoursRemaining / 24).ceil();
    
    return 'In $daysRemaining days: $nextMilestoneDescription';
  }
  
  int _calculateCravingReduction() {
    final daysSinceQuit = user.quitDate != null ? DateTime.now().difference(user.quitDate!).inDays : 0;
    
    // Simple algorithm for craving reduction
    // In a real app, this would be based on actual craving data
    if (daysSinceQuit <= 3) {
      return 0; // Cravings might be worse in first few days
    } else if (daysSinceQuit <= 7) {
      return (daysSinceQuit - 3) * 5; // 0-20% in first week
    } else if (daysSinceQuit <= 30) {
      return 20 + ((daysSinceQuit - 7) * 30 / 23).round(); // 20-50% in first month
    } else if (daysSinceQuit <= 90) {
      return 50 + ((daysSinceQuit - 30) * 20 / 60).round(); // 50-70% in first 3 months
    } else {
      return 70 + ((daysSinceQuit - 90) * 20 / 275).round().clamp(0, 30); // Up to 90% after a year
    }
  }
  
  String _getPersonalizedRecommendation() {
    final daysSinceQuit = user.quitDate != null ? DateTime.now().difference(user.quitDate!).inDays : 0;
    
    // Provide different recommendations based on quit journey stage
    if (daysSinceQuit < 7) {
      return 'Focus on getting through each day. Use the Panic Mode feature whenever cravings hit, and try the breathing exercises to manage stress.';
    } else if (daysSinceQuit < 30) {
      return 'You\'re doing great! This is a good time to identify your triggers and develop coping strategies. Use the Check-in feature to track patterns in your cravings.';
    } else if (daysSinceQuit < 90) {
      return 'Consider reducing your NRT usage if you\'re using it. Your body is adapting to being nicotine-free, and you can start tapering down.';
    } else {
      return 'You\'ve made incredible progress! Focus on maintaining your new habits and consider helping others who are just starting their quit journey.';
    }
  }
}