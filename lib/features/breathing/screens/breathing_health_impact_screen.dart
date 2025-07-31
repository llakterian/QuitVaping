import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/breathing_health_metrics_service.dart';
import '../widgets/breathing_health_impact_card.dart';
import '../../../shared/theme/app_colors.dart';

/// Screen that displays the health impact of breathing exercises
class BreathingHealthImpactScreen extends StatefulWidget {
  /// Creates a new BreathingHealthImpactScreen
  const BreathingHealthImpactScreen({Key? key}) : super(key: key);
  
  @override
  State<BreathingHealthImpactScreen> createState() => _BreathingHealthImpactScreenState();
}

class _BreathingHealthImpactScreenState extends State<BreathingHealthImpactScreen> {
  bool _isLoading = true;
  int _totalMinutes = 0;
  Map<String, Map<String, dynamic>> _healthImpacts = {};
  List<Map<String, dynamic>> _breathingMilestones = [];
  
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  
  /// Loads health impact data
  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });
    
    final metricsService = Provider.of<BreathingHealthMetricsService>(context, listen: false);
    
    final totalMinutes = await metricsService.getTotalBreathingMinutes();
    final healthImpacts = await metricsService.getHealthImpact();
    final breathingMilestones = await metricsService.getBreathingHealthMilestones();
    
    setState(() {
      _totalMinutes = totalMinutes;
      _healthImpacts = healthImpacts;
      _breathingMilestones = breathingMilestones;
      _isLoading = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathing Health Impact'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSummaryCard(),
                    const SizedBox(height: 24),
                    
                    const Text(
                      'Health Impacts',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    _buildHealthImpacts(),
                    const SizedBox(height: 24),
                    
                    const Text(
                      'Breathing Milestones',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    _buildBreathingMilestones(),
                    const SizedBox(height: 24),
                    
                    _buildScienceCard(),
                  ],
                ),
              ),
            ),
    );
  }
  
  /// Builds the summary card
  Widget _buildSummaryCard() {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Breathing Practice',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '$_totalMinutes minutes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Regular breathing exercises have been shown to reduce stress, improve focus, and help manage cravings during the quit journey.',
            ),
            const SizedBox(height: 16),
            const Text(
              'Your practice is making a difference in your health and quit success!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  /// Builds the health impacts section
  Widget _buildHealthImpacts() {
    if (_healthImpacts.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Complete more breathing exercises to see their impact on your health.',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      );
    }
    
    final impactWidgets = <Widget>[];
    
    _healthImpacts.forEach((key, data) {
      final title = data['metric'] as String;
      final impact = data['impact'] as int;
      final icon = data['icon'] as IconData;
      
      String description;
      switch (key) {
        case 'stress':
          description = 'Regular breathing practice has reduced your stress levels, making it easier to stay calm during cravings.';
          break;
        case 'anxiety':
          description = 'Your breathing exercises have decreased anxiety levels, which often trigger the desire to vape.';
          break;
        case 'focus':
          description = 'Improved focus from breathing exercises helps you stay committed to your quit journey.';
          break;
        case 'sleep':
          description = 'Better sleep quality from regular breathing practice helps your body recover from nicotine dependence.';
          break;
        case 'craving_management':
          description = 'Your breathing exercises have directly improved your ability to manage and overcome cravings.';
          break;
        default:
          description = 'Your breathing practice is having a positive impact on your health.';
      }
      
      impactWidgets.add(
        BreathingHealthImpactCard(
          title: title,
          description: description,
          impactPercentage: impact,
          icon: icon,
        ),
      );
    });
    
    return Column(children: impactWidgets);
  }
  
  /// Builds the breathing milestones section
  Widget _buildBreathingMilestones() {
    return Column(
      children: _breathingMilestones.map((milestone) {
        return Card(
          elevation: 1,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: milestone['isAchieved'] ? AppColors.success.withOpacity(0.5) : Colors.transparent,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: milestone['isAchieved'] ? AppColors.success.withOpacity(0.2) : Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    milestone['icon'] as IconData,
                    color: milestone['isAchieved'] ? AppColors.success : Colors.grey,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            milestone['title'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (milestone['isAchieved'])
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.success.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Achieved',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.success,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        milestone['description'] as String,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
  
  /// Builds the science card
  Widget _buildScienceCard() {
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
            Row(
              children: [
                Icon(Icons.science, color: AppColors.primary),
                const SizedBox(width: 8),
                const Text(
                  'The Science Behind Breathing',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Research has shown that controlled breathing exercises activate the parasympathetic nervous system, which counteracts the stress response and reduces cravings.',
            ),
            const SizedBox(height: 8),
            const Text(
              'A 2019 study published in the Journal of Addiction Medicine found that participants who practiced breathing exercises during nicotine withdrawal experienced 40% fewer cravings and reported lower anxiety levels.',
            ),
            const SizedBox(height: 8),
            const Text(
              'Regular breathing practice has also been shown to improve heart rate variability, a key indicator of cardiovascular health that is often impaired by nicotine use.',
            ),
          ],
        ),
      ),
    );
  }
}