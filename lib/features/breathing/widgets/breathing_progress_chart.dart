import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../data/models/breathing_session_model.dart';
import '../../../shared/theme/app_colors.dart';

/// Chart types available for breathing progress visualization
enum BreathingChartType {
  /// Daily frequency of sessions
  frequency,
  
  /// Duration of sessions over time
  duration,
  
  /// Mood improvement from sessions
  mood,
}

/// A widget that displays charts for breathing exercise progress
class BreathingProgressChart extends StatefulWidget {
  /// The sessions to display in the chart
  final List<BreathingSessionModel> sessions;
  
  /// The type of chart to display
  final BreathingChartType chartType;
  
  /// The number of days to display (7 for week, 30 for month)
  final int days;
  
  /// Creates a new BreathingProgressChart
  const BreathingProgressChart({
    Key? key,
    required this.sessions,
    required this.chartType,
    this.days = 7,
  }) : super(key: key);

  @override
  State<BreathingProgressChart> createState() => _BreathingProgressChartState();
}

class _BreathingProgressChartState extends State<BreathingProgressChart> {
  // Selected data point
  int? _selectedSpot;
  
  @override
  Widget build(BuildContext context) {
    if (widget.sessions.isEmpty) {
      return _buildEmptyState();
    }
    
    switch (widget.chartType) {
      case BreathingChartType.frequency:
        return _buildFrequencyChart();
      case BreathingChartType.duration:
        return _buildDurationChart();
      case BreathingChartType.mood:
        return _buildMoodChart();
    }
  }
  
  /// Builds an empty state widget when no data is available
  Widget _buildEmptyState() {
    return Container(
      height: 200,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bar_chart,
            size: 48,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 16),
          Text(
            'Not enough data to display chart',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Complete more breathing exercises to see your progress',
            style: TextStyle(
              color: AppColors.textTertiary,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  /// Builds a chart showing session frequency by day
  Widget _buildFrequencyChart() {
    // Get date range
    final now = DateTime.now();
    final startDate = DateTime(
      now.year,
      now.month,
      now.day - widget.days + 1,
    );
    
    // Group sessions by date
    final sessionsByDate = <DateTime, int>{};
    for (int i = 0; i < widget.days; i++) {
      final date = DateTime(
        startDate.year,
        startDate.month,
        startDate.day + i,
      );
      sessionsByDate[date] = 0;
    }
    
    // Count sessions for each date
    for (final session in widget.sessions) {
      final sessionDate = DateTime(
        session.timestamp.year,
        session.timestamp.month,
        session.timestamp.day,
      );
      
      if (sessionDate.compareTo(startDate) >= 0 && 
          sessionDate.compareTo(now) <= 0) {
        sessionsByDate[sessionDate] = (sessionsByDate[sessionDate] ?? 0) + 1;
      }
    }
    
    // Convert to list of spots for the chart
    final spots = <FlSpot>[];
    final dates = sessionsByDate.keys.toList()..sort();
    
    for (int i = 0; i < dates.length; i++) {
      final date = dates[i];
      final count = sessionsByDate[date] ?? 0;
      spots.add(FlSpot(i.toDouble(), count.toDouble()));
    }
    
    return _buildChart(
      spots: spots,
      title: 'Sessions per Day',
      yAxisTitle: 'Sessions',
      xAxisLabels: dates.map((date) => DateFormat('MM/dd').format(date)).toList(),
      gradientColors: AppColors.progressGradient,
      showArea: true,
    );
  }
  
  /// Builds a chart showing session duration over time
  Widget _buildDurationChart() {
    // Get date range
    final now = DateTime.now();
    final startDate = DateTime(
      now.year,
      now.month,
      now.day - widget.days + 1,
    );
    
    // Group sessions by date
    final sessionDurationByDate = <DateTime, int>{};
    for (int i = 0; i < widget.days; i++) {
      final date = DateTime(
        startDate.year,
        startDate.month,
        startDate.day + i,
      );
      sessionDurationByDate[date] = 0;
    }
    
    // Sum durations for each date
    for (final session in widget.sessions) {
      final sessionDate = DateTime(
        session.timestamp.year,
        session.timestamp.month,
        session.timestamp.day,
      );
      
      if (sessionDate.compareTo(startDate) >= 0 && 
          sessionDate.compareTo(now) <= 0) {
        sessionDurationByDate[sessionDate] = 
            (sessionDurationByDate[sessionDate] ?? 0) + session.durationSeconds;
      }
    }
    
    // Convert to list of spots for the chart
    final spots = <FlSpot>[];
    final dates = sessionDurationByDate.keys.toList()..sort();
    
    for (int i = 0; i < dates.length; i++) {
      final date = dates[i];
      // Convert seconds to minutes
      final minutes = (sessionDurationByDate[date] ?? 0) / 60;
      spots.add(FlSpot(i.toDouble(), minutes));
    }
    
    return _buildChart(
      spots: spots,
      title: 'Minutes Practiced per Day',
      yAxisTitle: 'Minutes',
      xAxisLabels: dates.map((date) => DateFormat('MM/dd').format(date)).toList(),
      gradientColors: [
        AppColors.secondary,
        AppColors.secondary.withOpacity(0.5),
      ],
      showArea: true,
    );
  }
  
  /// Builds a chart showing mood improvement from sessions
  Widget _buildMoodChart() {
    // Filter sessions with mood data
    final sessionsWithMood = widget.sessions.where(
      (s) => s.moodBefore != null && s.moodAfter != null
    ).toList();
    
    if (sessionsWithMood.isEmpty) {
      return _buildEmptyState();
    }
    
    // Sort by timestamp (oldest first)
    sessionsWithMood.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    
    // Limit to most recent sessions if there are too many
    final limitedSessions = sessionsWithMood.length > widget.days
        ? sessionsWithMood.sublist(sessionsWithMood.length - widget.days)
        : sessionsWithMood;
    
    // Create spots for before and after mood
    final beforeSpots = <FlSpot>[];
    final afterSpots = <FlSpot>[];
    final dates = <DateTime>[];
    
    for (int i = 0; i < limitedSessions.length; i++) {
      final session = limitedSessions[i];
      beforeSpots.add(FlSpot(i.toDouble(), session.moodBefore!.toDouble()));
      afterSpots.add(FlSpot(i.toDouble(), session.moodAfter!.toDouble()));
      dates.add(session.timestamp);
    }
    
    return _buildMultiLineChart(
      spots1: beforeSpots,
      spots2: afterSpots,
      title: 'Mood Before & After Sessions',
      yAxisTitle: 'Mood (1-5)',
      xAxisLabels: dates.map((date) => DateFormat('MM/dd').format(date)).toList(),
      legend1: 'Before',
      legend2: 'After',
      color1: AppColors.warning,
      color2: AppColors.success,
    );
  }
  
  /// Builds a line chart with the given data
  Widget _buildChart({
    required List<FlSpot> spots,
    required String title,
    required String yAxisTitle,
    required List<String> xAxisLabels,
    required List<Color> gradientColors,
    bool showArea = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.only(right: 16, bottom: 16),
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 1,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey[300],
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.grey[300],
                      strokeWidth: 1,
                    );
                  },
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
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= 0 && value.toInt() < xAxisLabels.length) {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              xAxisLabels[value.toInt()],
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 10,
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    axisNameWidget: Text(
                      yAxisTitle,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    axisNameSize: 25,
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(
                            value.toInt().toString(),
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 10,
                            ),
                          ),
                        );
                      },
                      reservedSize: 30,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.grey[300]!),
                ),
                minX: 0,
                maxX: spots.length - 1.0,
                minY: 0,
                maxY: spots.isEmpty ? 5 : spots.map((s) => s.y).reduce((a, b) => a > b ? a : b) + 1,
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: Colors.grey[800],
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((touchedSpot) {
                        final index = touchedSpot.x.toInt();
                        final value = touchedSpot.y;
                        return LineTooltipItem(
                          '${xAxisLabels[index]}: ${value.toStringAsFixed(1)}',
                          const TextStyle(color: Colors.white),
                        );
                      }).toList();
                    },
                  ),
                  touchCallback: (event, response) {
                    if (response == null || response.lineBarSpots == null) {
                      setState(() {
                        _selectedSpot = null;
                      });
                      return;
                    }
                    if (event is FlTapUpEvent) {
                      setState(() {
                        _selectedSpot = response.lineBarSpots!.first.x.toInt();
                      });
                    }
                  },
                  handleBuiltInTouches: true,
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: gradientColors[0],
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: _selectedSpot == index ? 5 : 3,
                          color: gradientColors[0],
                          strokeWidth: 1,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                    belowBarData: showArea
                        ? BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: gradientColors
                                  .map((color) => color.withOpacity(0.3))
                                  .toList(),
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  /// Builds a multi-line chart with the given data
  Widget _buildMultiLineChart({
    required List<FlSpot> spots1,
    required List<FlSpot> spots2,
    required String title,
    required String yAxisTitle,
    required List<String> xAxisLabels,
    required String legend1,
    required String legend2,
    required Color color1,
    required Color color2,
  }) {
    // Find max Y value for chart scaling
    final allYValues = [...spots1.map((s) => s.y), ...spots2.map((s) => s.y)];
    final maxY = allYValues.isEmpty ? 5.0 : allYValues.reduce((a, b) => a > b ? a : b) + 1;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
        // Legend
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color1,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                legend1,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color2,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                legend2,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.only(right: 16, bottom: 16),
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 1,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey[300],
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.grey[300],
                      strokeWidth: 1,
                    );
                  },
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
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= 0 && value.toInt() < xAxisLabels.length) {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              xAxisLabels[value.toInt()],
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 10,
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    axisNameWidget: Text(
                      yAxisTitle,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    axisNameSize: 25,
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(
                            value.toInt().toString(),
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 10,
                            ),
                          ),
                        );
                      },
                      reservedSize: 30,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.grey[300]!),
                ),
                minX: 0,
                maxX: spots1.length - 1.0,
                minY: 0,
                maxY: maxY,
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: Colors.grey[800],
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((touchedSpot) {
                        final index = touchedSpot.x.toInt();
                        final value = touchedSpot.y;
                        final isBeforeLine = touchedSpot.barIndex == 0;
                        
                        return LineTooltipItem(
                          '${xAxisLabels[index]}: ${isBeforeLine ? legend1 : legend2} ${value.toInt()}',
                          TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList();
                    },
                  ),
                  touchCallback: (event, response) {
                    if (response == null || response.lineBarSpots == null) {
                      setState(() {
                        _selectedSpot = null;
                      });
                      return;
                    }
                    if (event is FlTapUpEvent) {
                      setState(() {
                        _selectedSpot = response.lineBarSpots!.first.x.toInt();
                      });
                    }
                  },
                  handleBuiltInTouches: true,
                ),
                lineBarsData: [
                  // Before line
                  LineChartBarData(
                    spots: spots1,
                    isCurved: true,
                    color: color1,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: _selectedSpot == index ? 5 : 3,
                          color: color1,
                          strokeWidth: 1,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                  ),
                  // After line
                  LineChartBarData(
                    spots: spots2,
                    isCurved: true,
                    color: color2,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: _selectedSpot == index ? 5 : 3,
                          color: color2,
                          strokeWidth: 1,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// A widget that displays a comprehensive progress dashboard for breathing exercises
class BreathingProgressDashboard extends StatelessWidget {
  /// The sessions to display in the charts
  final List<BreathingSessionModel> sessions;
  
  /// Creates a new BreathingProgressDashboard
  const BreathingProgressDashboard({
    Key? key,
    required this.sessions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Weekly frequency chart
        BreathingProgressChart(
          sessions: sessions,
          chartType: BreathingChartType.frequency,
          days: 7,
        ),
        
        const Divider(),
        
        // Weekly duration chart
        BreathingProgressChart(
          sessions: sessions,
          chartType: BreathingChartType.duration,
          days: 7,
        ),
        
        const Divider(),
        
        // Mood improvement chart
        BreathingProgressChart(
          sessions: sessions,
          chartType: BreathingChartType.mood,
          days: 10,
        ),
        
        // Trend analysis
        if (sessions.isNotEmpty) _buildTrendAnalysis(),
      ],
    );
  }
  
  /// Builds a trend analysis section
  Widget _buildTrendAnalysis() {
    // Calculate trends
    final trends = _calculateTrends();
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Trend Analysis',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          
          // Frequency trend
          _buildTrendItem(
            label: 'Practice Frequency',
            trend: trends['frequency']!,
            positiveMessage: 'Increasing! Keep up the good work.',
            negativeMessage: 'Decreasing. Try to practice more regularly.',
            neutralMessage: 'Stable. Maintaining a consistent practice.',
          ),
          
          const SizedBox(height: 8),
          
          // Duration trend
          _buildTrendItem(
            label: 'Session Duration',
            trend: trends['duration']!,
            positiveMessage: 'Increasing! You\'re building endurance.',
            negativeMessage: 'Decreasing. Try to extend your sessions gradually.',
            neutralMessage: 'Stable. Maintaining consistent session length.',
          ),
          
          const SizedBox(height: 8),
          
          // Mood trend
          _buildTrendItem(
            label: 'Mood Improvement',
            trend: trends['mood']!,
            positiveMessage: 'Improving! Breathing is helping your mood.',
            negativeMessage: 'Declining. Try different exercises for better results.',
            neutralMessage: 'Stable. Consistent mood benefits from practice.',
          ),
        ],
      ),
    );
  }
  
  /// Builds a single trend item
  Widget _buildTrendItem({
    required String label,
    required double trend,
    required String positiveMessage,
    required String negativeMessage,
    required String neutralMessage,
  }) {
    final isPositive = trend > 0.1;
    final isNegative = trend < -0.1;
    final message = isPositive
        ? positiveMessage
        : (isNegative ? negativeMessage : neutralMessage);
    
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Icon(
          isPositive
              ? Icons.trending_up
              : (isNegative ? Icons.trending_down : Icons.trending_flat),
          color: isPositive
              ? AppColors.success
              : (isNegative ? AppColors.error : AppColors.info),
          size: 20,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
  
  /// Calculates trends from session data
  Map<String, double> _calculateTrends() {
    if (sessions.length < 4) {
      return {
        'frequency': 0.0,
        'duration': 0.0,
        'mood': 0.0,
      };
    }
    
    // Sort sessions by date (oldest first)
    final sortedSessions = List<BreathingSessionModel>.from(sessions)
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    
    // Split into two halves to compare
    final midpoint = sortedSessions.length ~/ 2;
    final firstHalf = sortedSessions.sublist(0, midpoint);
    final secondHalf = sortedSessions.sublist(midpoint);
    
    // Calculate frequency trend (sessions per day)
    final firstHalfDays = _uniqueDays(firstHalf).length;
    final secondHalfDays = _uniqueDays(secondHalf).length;
    
    final firstHalfFreq = firstHalfDays == 0 ? 0 : firstHalf.length / firstHalfDays;
    final secondHalfFreq = secondHalfDays == 0 ? 0 : secondHalf.length / secondHalfDays;
    final frequencyTrend = firstHalfFreq == 0 ? 1.0 : (secondHalfFreq - firstHalfFreq) / firstHalfFreq;
    
    // Calculate duration trend
    final firstHalfAvgDuration = firstHalf.isEmpty
        ? 0
        : firstHalf.fold<int>(0, (sum, s) => sum + s.durationSeconds) / firstHalf.length;
    final secondHalfAvgDuration = secondHalf.isEmpty
        ? 0
        : secondHalf.fold<int>(0, (sum, s) => sum + s.durationSeconds) / secondHalf.length;
    final durationTrend = firstHalfAvgDuration == 0
        ? 1.0
        : (secondHalfAvgDuration - firstHalfAvgDuration) / firstHalfAvgDuration;
    
    // Calculate mood trend
    final firstHalfWithMood = firstHalf.where(
      (s) => s.moodBefore != null && s.moodAfter != null
    ).toList();
    final secondHalfWithMood = secondHalf.where(
      (s) => s.moodBefore != null && s.moodAfter != null
    ).toList();
    
    double moodTrend = 0.0;
    if (firstHalfWithMood.isNotEmpty && secondHalfWithMood.isNotEmpty) {
      final firstHalfAvgImprovement = firstHalfWithMood.fold<int>(
        0, (sum, s) => sum + (s.moodAfter! - s.moodBefore!)
      ) / firstHalfWithMood.length;
      
      final secondHalfAvgImprovement = secondHalfWithMood.fold<int>(
        0, (sum, s) => sum + (s.moodAfter! - s.moodBefore!)
      ) / secondHalfWithMood.length;
      
      moodTrend = firstHalfAvgImprovement == 0
          ? 0.0
          : (secondHalfAvgImprovement - firstHalfAvgImprovement) / firstHalfAvgImprovement.abs();
    }
    
    return {
      'frequency': frequencyTrend,
      'duration': durationTrend,
      'mood': moodTrend,
    };
  }
  
  /// Gets unique days from a list of sessions
  Set<DateTime> _uniqueDays(List<BreathingSessionModel> sessions) {
    return sessions.map((s) => DateTime(
      s.timestamp.year,
      s.timestamp.month,
      s.timestamp.day,
    )).toSet();
  }
}