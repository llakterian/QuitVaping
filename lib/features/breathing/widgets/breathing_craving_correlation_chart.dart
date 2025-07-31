import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../shared/theme/app_colors.dart';
import '../services/breathing_craving_integration_service.dart';
import '../../../data/services/breathing_exercise_service.dart';

/// A widget that displays correlation data between breathing exercises and craving reduction
class BreathingCravingCorrelationChart extends StatefulWidget {
  final BreathingCravingIntegrationService integrationService;
  final BreathingExerciseService breathingService;

  const BreathingCravingCorrelationChart({
    Key? key,
    required this.integrationService,
    required this.breathingService,
  }) : super(key: key);

  @override
  State<BreathingCravingCorrelationChart> createState() => _BreathingCravingCorrelationChartState();
}

class _BreathingCravingCorrelationChartState extends State<BreathingCravingCorrelationChart> {
  bool _isLoading = true;
  Map<String, dynamic> _correlationData = {};
  Map<String, String> _exerciseNames = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Load correlation data
      final correlationData = await widget.integrationService.getCorrelationAnalytics();
      
      // Load exercise names for display
      final exercises = await widget.breathingService.getExercises();
      final exerciseNames = {
        for (var exercise in exercises) exercise.id: exercise.name
      };

      if (mounted) {
        setState(() {
          _correlationData = correlationData;
          _exerciseNames = exerciseNames;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final totalCorrelations = _correlationData['totalCorrelations'] as int? ?? 0;
    
    if (totalCorrelations == 0) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'No correlation data available yet. Try using breathing exercises after logging cravings to see how they help.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEffectivenessCard(),
          const SizedBox(height: 24),
          _buildExerciseEffectivenessChart(),
          const SizedBox(height: 24),
          _buildCravingReductionChart(),
          const SizedBox(height: 24),
          _buildTriggerCorrelationSection(),
        ],
      ),
    );
  }

  Widget _buildEffectivenessCard() {
    final effectivenessRate = _correlationData['effectivenessRate'] as double? ?? 0.0;
    final mostEffectiveExerciseId = _correlationData['mostEffectiveExercise'] as String?;
    final mostEffectiveExerciseName = mostEffectiveExerciseId != null 
        ? (_exerciseNames[mostEffectiveExerciseId] ?? 'Unknown')
        : 'None';

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Breathing Exercise Effectiveness',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '${(effectivenessRate * 100).toStringAsFixed(1)}%',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const Text('Overall Effectiveness'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        mostEffectiveExerciseName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Text('Most Effective Exercise'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseEffectivenessChart() {
    final stats = _correlationData['stats'] as Map<String, dynamic>? ?? {};
    final byExercise = stats['byExercise'] as Map<String, dynamic>? ?? {};
    
    if (byExercise.isEmpty) {
      return const SizedBox.shrink();
    }

    final exerciseData = <String, double>{};
    
    byExercise.forEach((exerciseId, data) {
      final total = data['total'] as int? ?? 0;
      final effective = data['effective'] as int? ?? 0;
      
      if (total > 0) {
        exerciseData[exerciseId] = effective / total;
      }
    });

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Exercise Effectiveness Rate',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 1.0,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.blueGrey.shade800,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final exerciseId = exerciseData.keys.elementAt(groupIndex);
                        final exerciseName = _exerciseNames[exerciseId] ?? 'Unknown';
                        final effectiveness = (rod.toY * 100).toStringAsFixed(1);
                        return BarTooltipItem(
                          '$exerciseName\n$effectiveness%',
                          const TextStyle(color: Colors.white),
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
                          if (value >= 0 && value < exerciseData.length) {
                            final exerciseId = exerciseData.keys.elementAt(value.toInt());
                            final exerciseName = _exerciseNames[exerciseId] ?? 'Unknown';
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                _abbreviateExerciseName(exerciseName),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                        reservedSize: 30,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${(value * 100).toInt()}%',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                        reservedSize: 30,
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: exerciseData.entries.map((entry) {
                    final index = exerciseData.keys.toList().indexOf(entry.key);
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: entry.value,
                          color: _getColorForIndex(index),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCravingReductionChart() {
    final averageReduction = _correlationData['averageReduction'] as Map<String, dynamic>? ?? {};
    
    if (averageReduction.isEmpty) {
      return const SizedBox.shrink();
    }

    final reductionData = <String, double>{};
    
    averageReduction.forEach((exerciseId, reduction) {
      reductionData[exerciseId] = reduction as double;
    });

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Average Craving Intensity Reduction',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: reductionData.values.isEmpty ? 1.0 : reductionData.values.reduce((a, b) => a > b ? a : b) + 1,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.blueGrey.shade800,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final exerciseId = reductionData.keys.elementAt(groupIndex);
                        final exerciseName = _exerciseNames[exerciseId] ?? 'Unknown';
                        final reduction = rod.toY.toStringAsFixed(1);
                        return BarTooltipItem(
                          '$exerciseName\nReduction: $reduction points',
                          const TextStyle(color: Colors.white),
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
                          if (value >= 0 && value < reductionData.length) {
                            final exerciseId = reductionData.keys.elementAt(value.toInt());
                            final exerciseName = _exerciseNames[exerciseId] ?? 'Unknown';
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                _abbreviateExerciseName(exerciseName),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                        reservedSize: 30,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                        reservedSize: 30,
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: reductionData.entries.map((entry) {
                    final index = reductionData.keys.toList().indexOf(entry.key);
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: entry.value,
                          color: AppColors.success,
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTriggerCorrelationSection() {
    final effectivenessByTrigger = _correlationData['effectivenessByTrigger'] as Map<String, dynamic>? ?? {};
    
    if (effectivenessByTrigger.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Effectiveness by Trigger Category',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...effectivenessByTrigger.entries.map((entry) {
              final triggerCategory = entry.key;
              final exercises = entry.value as Map<String, dynamic>;
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    triggerCategory,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...exercises.entries.map((exerciseEntry) {
                    final exerciseId = exerciseEntry.key;
                    final effectiveness = exerciseEntry.value as double;
                    final exerciseName = _exerciseNames[exerciseId] ?? 'Unknown';
                    
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  exerciseName,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                '${(effectiveness * 100).toStringAsFixed(1)}%',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          LinearProgressIndicator(
                            value: effectiveness,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getColorForEffectiveness(effectiveness),
                            ),
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const Divider(),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  String _abbreviateExerciseName(String name) {
    if (name.length <= 5) return name;
    
    final words = name.split(' ');
    if (words.length == 1) return name.substring(0, 5);
    
    return words.map((word) => word[0]).join('');
  }

  Color _getColorForIndex(int index) {
    final colors = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.success,
      AppColors.warning,
      AppColors.info,
    ];
    
    return colors[index % colors.length];
  }

  Color _getColorForEffectiveness(double effectiveness) {
    if (effectiveness >= 0.7) {
      return AppColors.success;
    } else if (effectiveness >= 0.4) {
      return AppColors.warning;
    } else {
      return AppColors.error;
    }
  }
}