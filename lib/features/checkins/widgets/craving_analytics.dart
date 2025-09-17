import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

import '../../../data/models/craving_model.dart';
import '../../../data/services/user_service.dart';
import '../../../data/services/subscription_service.dart';
import '../../../shared/theme/app_colors.dart';
import '../../subscription/widgets/premium_feature_overlay.dart';
import '../../subscription/screens/subscription_screen.dart';

class CravingAnalytics extends StatelessWidget {
  const CravingAnalytics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subscriptionService = Provider.of<SubscriptionService>(context);
    final isPremium = subscriptionService.isPremium;
    
    return isPremium 
        ? _buildPremiumAnalytics(context)
        : PremiumFeatureOverlay(
            featureName: 'Advanced Craving Analytics',
            description: 'Get detailed insights into your craving patterns and personalized recommendations to help you quit more effectively.',
            child: _buildPremiumAnalytics(context),
          );
  }
  
  Widget _buildPremiumAnalytics(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    // In a real app, we would get the cravings from the user service
    // For this example, we'll use mock data
    final cravings = _getMockCravings();
    
    if (cravings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.analytics,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'No craving data available',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Start logging your cravings to see analytics',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    
    // Calculate analytics data
    final triggerDistribution = _calculateTriggerDistribution(cravings);
    final intensityTrend = _calculateIntensityTrend(cravings);
    final timeOfDayDistribution = _calculateTimeOfDayDistribution(cravings);
    final resolutionRate = _calculateResolutionRate(cravings);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Craving Summary',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  
                  _buildSummaryItem(
                    context,
                    icon: Icons.check_circle,
                    title: 'Resolution Rate',
                    value: '${(resolutionRate * 100).toStringAsFixed(1)}%',
                    color: AppColors.success,
                  ),
                  
                  const SizedBox(height: 12),
                  _buildSummaryItem(
                    context,
                    icon: Icons.trending_down,
                    title: 'Intensity Trend',
                    value: '-12% this week',
                    color: AppColors.primary,
                  ),
                  
                  const SizedBox(height: 12),
                  _buildSummaryItem(
                    context,
                    icon: Icons.warning,
                    title: 'Top Trigger',
                    value: _getTopTrigger(triggerDistribution),
                    color: AppColors.accent,
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Intensity trend chart
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Craving Intensity Trend',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  
                  SizedBox(
                    height: 200,
                    child: _buildIntensityTrendChart(intensityTrend),
                  ),
                  
                  const SizedBox(height: 16),
                  const Text(
                    'Your craving intensity is decreasing over time. Keep up the good work!',
                    style: TextStyle(color: AppColors.success),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Trigger distribution
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trigger Distribution',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  
                  SizedBox(
                    height: 200,
                    child: _buildTriggerDistributionChart(triggerDistribution),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Time of day distribution
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cravings by Time of Day',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  
                  SizedBox(
                    height: 200,
                    child: _buildTimeOfDayChart(timeOfDayDistribution),
                  ),
                  
                  const SizedBox(height: 16),
                  const Text(
                    'Personalized Recommendation:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Your cravings are strongest in the evening. Try planning alternative activities during this time, such as exercise or socializing in smoke-free environments.',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Personalized insights
          Card(
            color: AppColors.primary.withValues(alpha: 26), // 0.1 * 255 ≈ 26
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.lightbulb, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text(
                        'Personalized Insights',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  const Text(
                    '• Social situations are your most common trigger. Consider practicing refusal skills and having a support person with you.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '• Deep breathing has been your most effective coping strategy. Keep using it when cravings hit!',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '• Your cravings are 35% less intense compared to when you first started quitting. This is significant progress!',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '• Consider using nicotine replacement therapy in the evenings when your cravings are strongest.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSummaryItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 26), // 0.1 * 255 ≈ 26
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildIntensityTrendChart(Map<String, double> intensityTrend) {
    final entries = intensityTrend.entries.toList();
    
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= 0 && value.toInt() < entries.length) {
                  return Text(
                    entries[value.toInt()].key,
                    style: const TextStyle(fontSize: 10),
                  );
                }
                return const Text('');
              },
              reservedSize: 30,
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: entries.asMap().entries.map((e) {
              // Safely access the value - ensure we're not using a nullable value
              final double yValue = e.value.value;
              return FlSpot(e.key.toDouble(), yValue);
            }).toList(),
            isCurved: true,
            color: AppColors.primary,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.primary.withValues(alpha: 51), // 0.2 * 255 ≈ 51
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTriggerDistributionChart(Map<String, int> triggerDistribution) {
    final colors = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.accent,
      AppColors.success,
      Colors.purple,
    ];
    
    final entries = triggerDistribution.entries.toList();
    final total = entries.isEmpty ? 0 : entries.fold<int>(0, (sum, entry) => sum + ((entry.value is int ? entry.value as int : 0)));
    
    return PieChart(
      PieChartData(
        sections: entries.asMap().entries.map((e) {
          final index = e.key;
          final entry = e.value;
          final percentage = total > 0 ? entry.value / total * 100 : 0.0;
          
          return PieChartSectionData(
            color: colors[index % colors.length],
            value: percentage,
            title: '${percentage.toStringAsFixed(1)}%',
            radius: 80,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        }).toList(),
        centerSpaceRadius: 40,
        sectionsSpace: 2,
      ),
    );
  }
  
  Widget _buildTimeOfDayChart(Map<String, int> timeOfDayDistribution) {
    final entries = timeOfDayDistribution.entries.toList();
    
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: entries.isEmpty ? 10.0 : entries.fold<double>(0.0, (max, entry) {
          final value = (entry.value is num ? (entry.value as num).toDouble() : 0.0);
          return value > max ? value : max;
        }) * 1.2,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= 0 && value.toInt() < entries.length) {
                  return Text(
                    entries[value.toInt()].key,
                    style: const TextStyle(fontSize: 10),
                  );
                }
                return const Text('');
              },
              reservedSize: 30,
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: entries.asMap().entries.map((e) {
          final index = e.key;
          final entry = e.value;
          
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: (entry.value ?? 0).toDouble(),
                color: AppColors.primary,
                width: 20,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
  
  // Mock data generation methods
  List<CravingModel> _getMockCravings() {
    return [
      CravingModel(
        id: '1',
        timestamp: DateTime.now().subtract(const Duration(days: 7)),
        intensity: 8,
        triggerCategory: 'social',
        specificTrigger: 'Friends vaping',
        resolved: true,
      ),
      CravingModel(
        id: '2',
        timestamp: DateTime.now().subtract(const Duration(days: 6)),
        intensity: 7,
        triggerCategory: 'emotional',
        specificTrigger: 'Stress',
        resolved: false,
      ),
      CravingModel(
        id: '3',
        timestamp: DateTime.now().subtract(const Duration(days: 5)),
        intensity: 6,
        triggerCategory: 'environmental',
        specificTrigger: 'Seeing vaping devices',
        resolved: true,
      ),
      CravingModel(
        id: '4',
        timestamp: DateTime.now().subtract(const Duration(days: 4)),
        intensity: 7,
        triggerCategory: 'social',
        specificTrigger: 'Party/social gathering',
        resolved: true,
      ),
      CravingModel(
        id: '5',
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        intensity: 5,
        triggerCategory: 'physical',
        specificTrigger: 'After eating',
        resolved: true,
      ),
      CravingModel(
        id: '6',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        intensity: 4,
        triggerCategory: 'emotional',
        specificTrigger: 'Boredom',
        resolved: false,
      ),
      CravingModel(
        id: '7',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        intensity: 3,
        triggerCategory: 'social',
        specificTrigger: 'Friends vaping',
        resolved: true,
      ),
    ];
  }
  
  Map<String, int> _calculateTriggerDistribution(List<CravingModel> cravings) {
    final distribution = <String, int>{};
    
    for (final craving in cravings) {
      distribution[craving.triggerCategory] = (distribution[craving.triggerCategory] ?? 0) + 1;
    }
    
    return distribution;
  }
  
  Map<String, double> _calculateIntensityTrend(List<CravingModel> cravings) {
    final trend = <String, List<int>>{};
    
    for (final craving in cravings) {
      final day = '${craving.timestamp.month}/${craving.timestamp.day}';
      trend[day] = [...(trend[day] ?? []), craving.intensity];
    }
    
    return trend.map((key, value) {
      final average = value.reduce((a, b) => a + b) / value.length;
      return MapEntry(key, average);
    });
  }
  
  Map<String, int> _calculateTimeOfDayDistribution(List<CravingModel> cravings) {
    final distribution = <String, int>{
      'Morning': 0,
      'Afternoon': 0,
      'Evening': 0,
      'Night': 0,
    };
    
    for (final craving in cravings) {
      final hour = craving.timestamp.hour;
      
      if (hour >= 5 && hour < 12) {
        distribution['Morning'] = (distribution['Morning'] ?? 0) + 1;
      } else if (hour >= 12 && hour < 17) {
        distribution['Afternoon'] = (distribution['Afternoon'] ?? 0) + 1;
      } else if (hour >= 17 && hour < 22) {
        distribution['Evening'] = (distribution['Evening'] ?? 0) + 1;
      } else {
        distribution['Night'] = (distribution['Night'] ?? 0) + 1;
      }
    }
    
    return distribution;
  }
  
  double _calculateResolutionRate(List<CravingModel> cravings) {
    if (cravings.isEmpty) return 0.0;
    
    final resolvedCount = cravings.where((craving) => craving.resolved).length;
    return resolvedCount / cravings.length;
  }
  
  String _getTopTrigger(Map<String, int> triggerDistribution) {
    if (triggerDistribution.isEmpty) return 'None';
    
    String? topTrigger;
    int maxCount = 0;
    
    triggerDistribution.forEach((trigger, count) {
      if (count > maxCount) {
        maxCount = count;
        topTrigger = trigger;
      }
    });
    
    return topTrigger?.capitalize() ?? 'None';
  }
}

// Extension to capitalize first letter of a string
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}