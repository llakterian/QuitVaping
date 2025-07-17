import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../../../data/models/nrt_model.dart';
import '../../../shared/theme/app_colors.dart';

class NRTUsageChart extends StatelessWidget {
  final List<NRTModel> usage;
  final int daysToShow;

  const NRTUsageChart({
    Key? key,
    required this.usage,
    this.daysToShow = 7,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Group by date and calculate daily totals
    final Map<DateTime, double> dailyTotals = {};
    
    for (final record in usage) {
      final date = DateTime(
        record.timestamp.year,
        record.timestamp.month,
        record.timestamp.day,
      );
      
      dailyTotals[date] = (dailyTotals[date] ?? 0) + record.nicotineStrength;
    }
    
    // Get the last 'daysToShow' days
    final now = DateTime.now();
    final dates = List.generate(
      daysToShow,
      (index) => DateTime(
        now.year,
        now.month,
        now.day - index,
      ),
    ).reversed.toList();
    
    // Create data points
    final spots = dates.map((date) {
      final x = dates.indexOf(date).toDouble();
      final y = dailyTotals[date] ?? 0.0;
      return FlSpot(x, y);
    }).toList();
    
    // Calculate trend
    String trend = 'stable';
    if (spots.length > 2) {
      final firstHalf = spots.sublist(0, spots.length ~/ 2);
      final secondHalf = spots.sublist(spots.length ~/ 2);
      
      final firstAvg = firstHalf.fold(0.0, (sum, spot) => sum + spot.y) / firstHalf.length;
      final secondAvg = secondHalf.fold(0.0, (sum, spot) => sum + spot.y) / secondHalf.length;
      
      if (secondAvg < firstAvg * 0.9) {
        trend = 'decreasing';
      } else if (secondAvg > firstAvg * 1.1) {
        trend = 'increasing';
      }
    }
    
    // Get trend color
    Color trendColor;
    IconData trendIcon;
    String trendText;
    
    switch (trend) {
      case 'decreasing':
        trendColor = AppColors.success;
        trendIcon = Icons.trending_down;
        trendText = 'Decreasing';
        break;
      case 'increasing':
        trendColor = AppColors.error;
        trendIcon = Icons.trending_up;
        trendText = 'Increasing';
        break;
      default:
        trendColor = AppColors.warning;
        trendIcon = Icons.trending_flat;
        trendText = 'Stable';
    }
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nicotine Intake',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Row(
                  children: [
                    Icon(trendIcon, color: trendColor, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      trendText,
                      style: TextStyle(color: trendColor),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Last $daysToShow days',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 16),
            
            SizedBox(
              height: 200,
              child: spots.isEmpty || spots.every((spot) => spot.y == 0)
                  ? const Center(
                      child: Text('Not enough data to display chart'),
                    )
                  : LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          horizontalInterval: 5,
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                if (value.toInt() >= 0 && value.toInt() < dates.length) {
                                  final date = dates[value.toInt()];
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      DateFormat('E').format(date),
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  );
                                }
                                return const SizedBox();
                              },
                              reservedSize: 30,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toInt().toString(),
                                  style: const TextStyle(fontSize: 10),
                                );
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        minX: 0,
                        maxX: dates.length - 1.0,
                        minY: 0,
                        lineBarsData: [
                          LineChartBarData(
                            spots: spots,
                            isCurved: true,
                            color: AppColors.primary,
                            barWidth: 3,
                            isStrokeCapRound: true,
                            dotData: FlDotData(show: true),
                            belowBarData: BarAreaData(
                              show: true,
                              color: AppColors.primary.withOpacity(0.2),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStat(
                  context,
                  'Today',
                  '${dailyTotals[dates.last] ?? 0} mg',
                  Icons.today,
                ),
                const SizedBox(width: 24),
                _buildStat(
                  context,
                  'Average',
                  '${_calculateAverage(dailyTotals, dates)} mg',
                  Icons.analytics,
                ),
                const SizedBox(width: 24),
                _buildStat(
                  context,
                  'Total',
                  '${_calculateTotal(dailyTotals, dates)} mg',
                  Icons.sum,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _calculateAverage(Map<DateTime, double> dailyTotals, List<DateTime> dates) {
    if (dates.isEmpty) return '0';
    
    double sum = 0;
    int count = 0;
    
    for (final date in dates) {
      if (dailyTotals.containsKey(date)) {
        sum += dailyTotals[date]!;
        count++;
      }
    }
    
    if (count == 0) return '0';
    return (sum / count).toStringAsFixed(1);
  }

  String _calculateTotal(Map<DateTime, double> dailyTotals, List<DateTime> dates) {
    if (dates.isEmpty) return '0';
    
    double sum = 0;
    
    for (final date in dates) {
      if (dailyTotals.containsKey(date)) {
        sum += dailyTotals[date]!;
      }
    }
    
    return sum.toStringAsFixed(1);
  }
}