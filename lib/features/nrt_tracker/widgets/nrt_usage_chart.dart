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
    // Get data for the chart
    final Map<DateTime, double> dailyTotals = {};
    final now = DateTime.now();
    
    // Initialize all days with zero
    for (int i = 0; i < daysToShow; i++) {
      final date = DateTime(
        now.year,
        now.month,
        now.day - i,
      );
      dailyTotals[date] = 0;
    }
    
    // Add up nicotine usage by day
    for (final record in usage) {
      final date = DateTime(
        record.timestamp.year,
        record.timestamp.month,
        record.timestamp.day,
      );
      
      // Only include days within our range
      final difference = now.difference(date).inDays;
      if (difference >= 0 && difference < daysToShow) {
        dailyTotals[date] = (dailyTotals[date] ?? 0) + record.nicotineStrength;
      }
    }
    
    // Sort dates
    final sortedDates = dailyTotals.keys.toList()
      ..sort((a, b) => a.compareTo(b));
    
    // Create bar chart data
    final barGroups = <BarChartGroupData>[];
    
    for (int i = 0; i < sortedDates.length; i++) {
      final date = sortedDates[i];
      final value = dailyTotals[date] ?? 0;
      
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: value,
              color: AppColors.primary,
              width: 16,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
          ],
        ),
      );
    }
    
    return Column(
      children: [
        Expanded(
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: _getMaxY(dailyTotals.values.toList()),
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.blueGrey.shade800,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final date = sortedDates[group.x.toInt()];
                    return BarTooltipItem(
                      '${DateFormat('MMM d').format(date)}\n',
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: '${rod.toY.toStringAsFixed(1)} mg',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      if (value >= 0 && value < sortedDates.length) {
                        final date = sortedDates[value.toInt()];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            DateFormat('E').format(date),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      if (value == 0) {
                        return const SizedBox();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: FlGridData(
                show: true,
                horizontalInterval: 10,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.grey.shade200,
                    strokeWidth: 1,
                  );
                },
                drawVerticalLine: false,
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: barGroups,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              'Nicotine Intake',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  double _getMaxY(List<double> values) {
    if (values.isEmpty) return 10;
    
    final max = values.reduce((a, b) => a > b ? a : b);
    return max < 10 ? 10 : (max * 1.2).ceilToDouble();
  }
}