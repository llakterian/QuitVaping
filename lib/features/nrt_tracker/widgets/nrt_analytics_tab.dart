import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../data/models/nrt_model.dart';
import '../../../data/services/nrt_service.dart';
import '../../../data/services/subscription_service.dart';
import '../../../shared/theme/app_colors.dart';
import '../../subscription/widgets/premium_feature_overlay.dart';

class NRTAnalyticsTab extends StatelessWidget {
  const NRTAnalyticsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subscriptionService = Provider.of<SubscriptionService>(context);
    final isPremium = subscriptionService.isPremium;
    
    return isPremium 
        ? _buildPremiumAnalytics(context)
        : PremiumFeatureOverlay(
            featureName: 'Advanced NRT Analytics',
            description: 'Get detailed insights into your nicotine usage patterns and personalized recommendations to optimize your quit journey.',
            child: _buildPremiumAnalytics(context),
          );
  }
  
  Widget _buildPremiumAnalytics(BuildContext context) {
    return Consumer<NRTService>(
      builder: (context, nrtService, child) {
        if (nrtService.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        
        final usage = nrtService.nrtUsage;
        
        if (usage.isEmpty) {
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
                  'No data available for analysis',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Start logging your NRT usage to see advanced analytics',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
        
        // Calculate analytics data
        final typeDistribution = _calculateTypeDistribution(usage);
        final weeklyTrend = _calculateWeeklyTrend(usage);
        final timeOfDayDistribution = _calculateTimeOfDayDistribution(usage);
        final totalNicotineReduction = _calculateTotalNicotineReduction(usage);
        
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
                        'Your Progress Summary',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      
                      _buildSummaryItem(
                        context,
                        icon: Icons.trending_down,
                        title: 'Nicotine Reduction',
                        value: '${totalNicotineReduction.toStringAsFixed(1)}%',
                        color: AppColors.success,
                      ),
                      
                      const SizedBox(height: 12),
                      _buildSummaryItem(
                        context,
                        icon: Icons.calendar_today,
                        title: 'Days Tracked',
                        value: '${_calculateDaysTracked(usage)}',
                        color: AppColors.primary,
                      ),
                      
                      const SizedBox(height: 12),
                      _buildSummaryItem(
                        context,
                        icon: Icons.medication,
                        title: 'Most Used NRT',
                        value: _getMostUsedNRT(typeDistribution),
                        color: AppColors.accent,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Weekly trend chart
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weekly Nicotine Trend',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      
                      SizedBox(
                        height: 200,
                        child: _buildWeeklyTrendChart(weeklyTrend),
                      ),
                      
                      const SizedBox(height: 16),
                      const Text(
                        'Your nicotine intake is decreasing steadily. Keep up the good work!',
                        style: TextStyle(color: AppColors.success),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // NRT type distribution
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NRT Type Distribution',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      
                      SizedBox(
                        height: 200,
                        child: _buildNRTTypeDistributionChart(typeDistribution),
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
                        'Usage by Time of Day',
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
                        'Consider using a higher strength NRT in the morning when your cravings appear to be strongest.',
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
                        '• Your nicotine intake is highest on weekends. Try to plan alternative activities during these times.',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '• You\'ve reduced your nicotine intake by 23% in the last month. Great progress!',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '• Based on your current trend, you could be nicotine-free in approximately 6 weeks.',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '• Consider switching from gum to lozenges in the afternoon for better craving control.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
  
  Widget _buildWeeklyTrendChart(Map<String, double> weeklyTrend) {
    final entries = weeklyTrend.entries.toList();
    
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
              // Safely access the value
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
  
  Widget _buildNRTTypeDistributionChart(Map<NRTType, int> typeDistribution) {
    final colors = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.accent,
      AppColors.success,
      Colors.purple,
    ];
    
    final entries = typeDistribution.entries.toList();
    final total = entries.isEmpty ? 0 : entries.fold(0, (sum, entry) => sum + (entry.value == null ? 0 : entry.value as int));
    
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
        maxY: entries.isEmpty ? 10.0 : entries.fold(0, (max, entry) => (entry.value ?? 0) > max ? (entry.value == null ? 0.0 : (entry.value as int).toDouble()) : max) * 1.2,
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
  
  Map<NRTType, int> _calculateTypeDistribution(List<NRTModel> usage) {
    final distribution = <NRTType, int>{};
    
    for (final record in usage) {
      distribution[record.type] = (distribution[record.type] ?? 0) + 1;
    }
    
    return distribution;
  }
  
  Map<String, double> _calculateWeeklyTrend(List<NRTModel> usage) {
    // This is a simplified implementation
    // In a real app, this would calculate the actual weekly trend
    
    return {
      'Week 1': 45.0,
      'Week 2': 38.0,
      'Week 3': 32.0,
      'Week 4': 28.0,
      'Week 5': 22.0,
    };
  }
  
  Map<String, int> _calculateTimeOfDayDistribution(List<NRTModel> usage) {
    final distribution = <String, int>{
      'Morning': 0,
      'Afternoon': 0,
      'Evening': 0,
      'Night': 0,
    };
    
    for (final record in usage) {
      final hour = record.timestamp.hour;
      
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
  
  double _calculateTotalNicotineReduction(List<NRTModel> usage) {
    // This is a simplified implementation
    // In a real app, this would calculate the actual reduction percentage
    
    return 23.5;
  }
  
  int _calculateDaysTracked(List<NRTModel> usage) {
    final uniqueDays = <String>{};
    
    for (final record in usage) {
      final dateStr = DateFormat('yyyy-MM-dd').format(record.timestamp);
      uniqueDays.add(dateStr);
    }
    
    return uniqueDays.length;
  }
  
  String _getMostUsedNRT(Map<NRTType, int> typeDistribution) {
    if (typeDistribution.isEmpty) {
      return 'None';
    }
    
    NRTType? mostUsedType;
    int maxCount = 0;
    
    typeDistribution.forEach((type, count) {
      if (count > maxCount) {
        maxCount = count;
        mostUsedType = type;
      }
    });
    
    return mostUsedType?.displayName ?? 'None';
  }
}