import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../data/services/breathing_exercise_service.dart';
import '../../../features/breathing/services/breathing_craving_integration_service.dart';
import '../../../features/breathing/screens/breathing_craving_analytics_screen.dart';
import '../models/craving_model.dart';
import '../widgets/craving_chart.dart';

class CravingAnalyticsScreen extends StatefulWidget {
  final List<CravingModel> cravings;
  
  const CravingAnalyticsScreen({
    Key? key,
    required this.cravings,
  }) : super(key: key);

  @override
  State<CravingAnalyticsScreen> createState() => _CravingAnalyticsScreenState();
}

class _CravingAnalyticsScreenState extends State<CravingAnalyticsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Craving Analytics'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Triggers'),
            Tab(text: 'Patterns'),
            Tab(text: 'Breathing'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildTriggersTab(),
          _buildPatternsTab(),
          _buildBreathingTab(),
        ],
      ),
    );
  }
  
  Widget _buildOverviewTab() {
    final totalCravings = widget.cravings.length;
    final resistedCravings = widget.cravings.where((c) => c.resisted).length;
    final resistanceRate = totalCravings > 0 
        ? (resistedCravings / totalCravings * 100).toStringAsFixed(1) 
        : '0';
    
    final averageIntensity = totalCravings > 0
        ? widget.cravings.map((c) => c.intensity).reduce((a, b) => a + b) / totalCravings
        : 0;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary cards
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Total Cravings',
                  totalCravings.toString(),
                  Icons.analytics,
                  AppColors.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildSummaryCard(
                  'Resisted',
                  '$resistedCravings ($resistanceRate%)',
                  Icons.check_circle,
                  AppColors.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Avg. Intensity',
                  averageIntensity.toStringAsFixed(1),
                  Icons.whatshot,
                  AppColors.warning,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildSummaryCard(
                  'Last 7 Days',
                  _getRecentCravingsCount().toString(),
                  Icons.calendar_today,
                  AppColors.info,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Intensity over time chart
          const Text(
            'Intensity Over Time',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: CravingChart(cravings: widget.cravings),
          ),
          const SizedBox(height: 24),
          
          // Recent cravings list
          const Text(
            'Recent Cravings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _buildRecentCravingsList(),
        ],
      ),
    );
  }
  
  Widget _buildTriggersTab() {
    // Group cravings by trigger category
    final Map<String, int> triggerCounts = {};
    for (final craving in widget.cravings) {
      if (craving.triggerCategory.isNotEmpty) {
        triggerCounts[craving.triggerCategory] = 
            (triggerCounts[craving.triggerCategory] ?? 0) + 1;
      }
    }
    
    // Sort by count
    final sortedTriggers = triggerCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Trigger Categories',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...sortedTriggers.map((entry) => _buildTriggerCategoryItem(
            entry.key,
            entry.value,
            triggerCounts.values.reduce((a, b) => a > b ? a : b),
          )),
          
          if (sortedTriggers.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text(
                  'No trigger data available yet. Start logging your cravings to see patterns.',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          
          const SizedBox(height: 24),
          const Text(
            'Specific Triggers',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildSpecificTriggersList(),
        ],
      ),
    );
  }
  
  Widget _buildPatternsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Time of Day Patterns',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildTimeOfDayChart(),
          const SizedBox(height: 24),
          
          const Text(
            'Location Patterns',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildLocationList(),
          const SizedBox(height: 24),
          
          const Text(
            'Activity Patterns',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildActivityList(),
        ],
      ),
    );
  }
  
  Widget _buildBreathingTab() {
    final breathingService = Provider.of<BreathingExerciseService>(context);
    final integrationService = Provider.of<BreathingCravingIntegrationService>(context);
    
    return FutureBuilder<double>(
      future: integrationService.getBreathingEffectivenessRate(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        final effectivenessRate = snapshot.data ?? 0.0;
        
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
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
                        'Breathing Exercises & Cravings',
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
                                const Text('Effectiveness Rate'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const BreathingCravingAnalyticsScreen(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.analytics),
                              label: const Text('Detailed Analysis'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'How Breathing Helps',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBreathingBenefitItem(
                        'Reduces Stress',
                        'Breathing exercises activate your parasympathetic nervous system, reducing stress hormones that can trigger cravings.',
                        Icons.spa,
                      ),
                      const Divider(),
                      _buildBreathingBenefitItem(
                        'Creates Distance',
                        'Taking time to breathe creates mental space between you and your craving, making it easier to resist.',
                        Icons.psychology,
                      ),
                      const Divider(),
                      _buildBreathingBenefitItem(
                        'Improves Focus',
                        'Focused breathing improves concentration, helping you stay committed to your quit journey.',
                        Icons.center_focus_strong,
                      ),
                      const Divider(),
                      _buildBreathingBenefitItem(
                        'Physical Relief',
                        'Deep breathing increases oxygen flow, reducing physical symptoms associated with nicotine withdrawal.',
                        Icons.favorite,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed('/breathing/exercises');
                },
                icon: const Icon(Icons.air),
                label: const Text('Try a Breathing Exercise Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildBreathingBenefitItem(String title, String description, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 24,
          ),
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
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildRecentCravingsList() {
    final recentCravings = widget.cravings
        .where((c) => c.timestamp.isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    
    if (recentCravings.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text(
            'No recent cravings logged. Great job!',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recentCravings.length,
      itemBuilder: (context, index) {
        final craving = recentCravings[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getColorForIntensity(craving.intensity),
              child: Text(
                craving.intensity.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              craving.trigger.isNotEmpty 
                  ? craving.trigger 
                  : craving.triggerCategory.isNotEmpty 
                      ? craving.triggerCategory 
                      : 'Unknown trigger',
            ),
            subtitle: Text(
              DateFormat('MMM d, h:mm a').format(craving.timestamp),
            ),
            trailing: Icon(
              craving.resisted ? Icons.check_circle : Icons.cancel,
              color: craving.resisted ? AppColors.success : Colors.red,
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildTriggerCategoryItem(String category, int count, int maxCount) {
    final percentage = count / maxCount;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(category),
              Text('$count cravings'),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSpecificTriggersList() {
    // Group cravings by specific trigger
    final Map<String, int> triggerCounts = {};
    for (final craving in widget.cravings) {
      if (craving.trigger.isNotEmpty) {
        triggerCounts[craving.trigger] = 
            (triggerCounts[craving.trigger] ?? 0) + 1;
      }
    }
    
    // Sort by count
    final sortedTriggers = triggerCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    if (sortedTriggers.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text(
            'No specific trigger data available yet.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sortedTriggers.length,
      itemBuilder: (context, index) {
        final entry = sortedTriggers[index];
        return ListTile(
          title: Text(entry.key),
          trailing: Text(
            '${entry.value} ${entry.value == 1 ? 'time' : 'times'}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildTimeOfDayChart() {
    // Group cravings by time of day
    final Map<String, int> timeDistribution = {
      'Morning': 0,
      'Afternoon': 0,
      'Evening': 0,
      'Night': 0,
    };
    
    for (final craving in widget.cravings) {
      final hour = craving.timestamp.hour;
      
      if (hour >= 5 && hour < 12) {
        timeDistribution['Morning'] = (timeDistribution['Morning'] ?? 0) + 1;
      } else if (hour >= 12 && hour < 17) {
        timeDistribution['Afternoon'] = (timeDistribution['Afternoon'] ?? 0) + 1;
      } else if (hour >= 17 && hour < 22) {
        timeDistribution['Evening'] = (timeDistribution['Evening'] ?? 0) + 1;
      } else {
        timeDistribution['Night'] = (timeDistribution['Night'] ?? 0) + 1;
      }
    }
    
    if (widget.cravings.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text(
            'No time data available yet.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    
    return Column(
      children: timeDistribution.entries.map((entry) {
        final count = entry.value;
        final total = widget.cravings.length;
        final percentage = total > 0 ? count / total : 0;
        
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key),
                  Text('${(percentage * 100).toStringAsFixed(1)}%'),
                ],
              ),
              const SizedBox(height: 4),
              LinearProgressIndicator(
                value: percentage,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(_getColorForTimeOfDay(entry.key)),
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
  
  Widget _buildLocationList() {
    // Group cravings by location
    final Map<String, int> locationCounts = {};
    for (final craving in widget.cravings) {
      if (craving.location.isNotEmpty) {
        locationCounts[craving.location] = 
            (locationCounts[craving.location] ?? 0) + 1;
      }
    }
    
    // Sort by count
    final sortedLocations = locationCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    if (sortedLocations.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text(
            'No location data available yet.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sortedLocations.length,
      itemBuilder: (context, index) {
        final entry = sortedLocations[index];
        return ListTile(
          leading: const Icon(Icons.location_on),
          title: Text(entry.key),
          trailing: Text(
            '${entry.value} ${entry.value == 1 ? 'time' : 'times'}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildActivityList() {
    // Group cravings by activity
    final Map<String, int> activityCounts = {};
    for (final craving in widget.cravings) {
      if (craving.activity.isNotEmpty) {
        activityCounts[craving.activity] = 
            (activityCounts[craving.activity] ?? 0) + 1;
      }
    }
    
    // Sort by count
    final sortedActivities = activityCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    if (sortedActivities.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text(
            'No activity data available yet.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sortedActivities.length,
      itemBuilder: (context, index) {
        final entry = sortedActivities[index];
        return ListTile(
          leading: const Icon(Icons.event),
          title: Text(entry.key),
          trailing: Text(
            '${entry.value} ${entry.value == 1 ? 'time' : 'times'}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
  
  int _getRecentCravingsCount() {
    return widget.cravings
        .where((c) => c.timestamp.isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .length;
  }
  
  Color _getColorForIntensity(int intensity) {
    if (intensity <= 3) {
      return Colors.green;
    } else if (intensity <= 6) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
  
  Color _getColorForTimeOfDay(String timeOfDay) {
    switch (timeOfDay) {
      case 'Morning':
        return Colors.orange;
      case 'Afternoon':
        return Colors.amber;
      case 'Evening':
        return Colors.indigo;
      case 'Night':
        return Colors.purple;
      default:
        return AppColors.primary;
    }
  }
}