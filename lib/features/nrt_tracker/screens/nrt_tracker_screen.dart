import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../data/models/nrt_model.dart';
import '../../../data/services/nrt_service.dart';
import '../../../shared/theme/app_colors.dart';
import '../widgets/nrt_usage_chart.dart';
import '../widgets/nrt_schedule_card.dart';

class NRTTrackerScreen extends StatefulWidget {
  const NRTTrackerScreen({Key? key}) : super(key: key);

  @override
  State<NRTTrackerScreen> createState() => _NRTTrackerScreenState();
}

class _NRTTrackerScreenState extends State<NRTTrackerScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedNRTType = 'patch';
  double _nicotineStrength = 14.0;
  String? _notes;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        title: const Text('NRT Tracker'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Dashboard'),
            Tab(text: 'Log Usage'),
            Tab(text: 'Schedule'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDashboardTab(),
          _buildLogUsageTab(),
          _buildScheduleTab(),
        ],
      ),
    );
  }
  
  Widget _buildDashboardTab() {
    final nrtService = Provider.of<NRTService>(context);
    final nrtUsage = nrtService.nrtUsage;
    
    if (nrtService.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (nrtUsage.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.medication_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'No NRT usage recorded yet',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Log your nicotine replacement therapy usage to track your progress',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                _tabController.animateTo(1);
              },
              child: const Text('Log NRT Usage'),
            ),
          ],
        ),
      );
    }
    
    // Get usage trend
    final trend = nrtService.getUsageTrend(7);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Usage summary card
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
                    'NRT Usage Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSummaryItem(
                        'Today',
                        '${nrtService.getTotalNicotineForDay(DateTime.now()).toStringAsFixed(1)} mg',
                        Icons.today,
                      ),
                      _buildSummaryItem(
                        'Trend',
                        _getTrendText(trend),
                        _getTrendIcon(trend),
                      ),
                      _buildSummaryItem(
                        'Type',
                        _getMostUsedType(nrtUsage),
                        Icons.category,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Usage chart
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
                    '7-Day Usage Trend',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: NRTUsageChart(
                      usage: nrtUsage,
                      daysToShow: 7,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Recent usage
          const Text(
            'Recent Usage',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          
          ...nrtUsage
              .take(5)
              .map((usage) => _buildUsageItem(context, usage))
              .toList(),
          
          const SizedBox(height: 16),
          
          // Health insights
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
                    'Health Insights',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildHealthInsight(
                    'Gradually reducing your NRT usage helps your body adjust to lower nicotine levels.',
                    Icons.trending_down,
                  ),
                  const SizedBox(height: 12),
                  _buildHealthInsight(
                    'Using NRT correctly can double your chances of quitting successfully.',
                    Icons.verified,
                  ),
                  const SizedBox(height: 12),
                  _buildHealthInsight(
                    'Most people use NRT for 8-12 weeks before tapering off completely.',
                    Icons.calendar_month,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildLogUsageTab() {
    final nrtService = Provider.of<NRTService>(context);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Log NRT Usage',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          
          // NRT Type selection
          const Text(
            'NRT Type',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              _buildTypeChip('patch', 'Patch'),
              _buildTypeChip('gum', 'Gum'),
              _buildTypeChip('lozenge', 'Lozenge'),
              _buildTypeChip('inhaler', 'Inhaler'),
              _buildTypeChip('spray', 'Spray'),
              _buildTypeChip('other', 'Other'),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Nicotine strength
          const Text(
            'Nicotine Strength (mg)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: _nicotineStrength,
                  min: 0,
                  max: 30,
                  divisions: 60,
                  label: _nicotineStrength.toStringAsFixed(1),
                  onChanged: (value) {
                    setState(() {
                      _nicotineStrength = value;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 60,
                child: Text(
                  '${_nicotineStrength.toStringAsFixed(1)} mg',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Notes
          const Text(
            'Notes (Optional)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Add any notes about this usage...',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            onChanged: (value) {
              _notes = value;
            },
          ),
          
          const SizedBox(height: 32),
          
          // Submit button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: nrtService.isLoading
                  ? null
                  : () async {
                      await nrtService.recordNRTUsage(
                        userId: 'current_user',
                        type: _selectedNRTType,
                        nicotineStrength: _nicotineStrength,
                        notes: _notes,
                      );
                      
                      if (!mounted) return;
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('NRT usage recorded successfully'),
                        ),
                      );
                      
                      // Reset form
                      setState(() {
                        _notes = null;
                      });
                      
                      // Switch to dashboard tab
                      _tabController.animateTo(0);
                    },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: nrtService.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text(
                      'Log Usage',
                      style: TextStyle(fontSize: 16),
                    ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildScheduleTab() {
    final nrtService = Provider.of<NRTService>(context);
    final schedule = nrtService.nrtSchedule;
    
    if (nrtService.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (schedule == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.schedule, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'No NRT Schedule Set',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Create a schedule to help you gradually reduce your nicotine intake',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                _showCreateScheduleDialog(context);
              },
              child: const Text('Create Schedule'),
            ),
          ],
        ),
      );
    }
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Schedule overview
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Your NRT Schedule',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showCreateScheduleDialog(context);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Started on ${DateFormat('MMM d, yyyy').format(schedule.startDate)}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: 0.6, // Replace with actual progress
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '60% complete', // Replace with actual progress
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Schedule steps
          const Text(
            'Reduction Steps',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Example reduction steps
          _buildReductionStep(
            1,
            'Full strength',
            '21mg patch daily',
            14,
            true,
          ),
          _buildReductionStep(
            2,
            'Medium strength',
            '14mg patch daily',
            14,
            true,
          ),
          _buildReductionStep(
            3,
            'Low strength',
            '7mg patch daily',
            14,
            false,
          ),
          _buildReductionStep(
            4,
            'Intermittent use',
            '7mg patch every other day',
            7,
            false,
          ),
          _buildReductionStep(
            5,
            'Nicotine free',
            'No NRT needed',
            0,
            false,
          ),
          
          const SizedBox(height: 24),
          
          // Tips
          Card(
            elevation: 2,
            color: AppColors.info.withOpacity(0.1),
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
                      Icon(Icons.lightbulb, color: AppColors.info),
                      const SizedBox(width: 8),
                      const Text(
                        'Tips for Success',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '• Use NRT consistently according to your schedule',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '• Don\'t rush the process - follow each step for the recommended time',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '• If you experience strong cravings, consult your healthcare provider before adjusting your schedule',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTypeChip(String type, String label) {
    final isSelected = _selectedNRTType == type;
    
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedNRTType = type;
          });
        }
      },
      backgroundColor: Colors.grey[200],
      selectedColor: AppColors.primary.withOpacity(0.2),
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primary : Colors.black,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
  
  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
  
  Widget _buildUsageItem(BuildContext context, NRTModel usage) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: _getNRTTypeIcon(usage.type.toStorageString()),
        title: Text(
          '${usage.type.displayName} - ${usage.nicotineStrength.toStringAsFixed(1)} mg',
        ),
        subtitle: Text(
          DateFormat('MMM d, yyyy - h:mm a').format(usage.timestamp),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () {
            final nrtService = Provider.of<NRTService>(context, listen: false);
            nrtService.deleteNRTUsage(usage.id);
          },
        ),
      ),
    );
  }
  
  Widget _buildHealthInsight(String text, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.info, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(text),
        ),
      ],
    );
  }
  
  Widget _buildReductionStep(
    int step,
    String title,
    String description,
    int days,
    bool isCompleted,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isCompleted ? AppColors.success.withOpacity(0.5) : Colors.transparent,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? AppColors.success : Colors.grey[300],
              ),
              child: Center(
                child: isCompleted
                    ? const Icon(Icons.check, color: Colors.white, size: 18)
                    : Text(
                        '$step',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
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
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '$days days',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void _showCreateScheduleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create NRT Schedule'),
        content: const Text(
          'This feature will help you create a personalized NRT reduction schedule. Coming soon!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  
  Widget _getNRTTypeIcon(String type) {
    IconData iconData;
    Color color;
    
    switch (type) {
      case 'patch':
        iconData = Icons.healing;
        color = Colors.blue;
        break;
      case 'gum':
        iconData = Icons.bubble_chart;
        color = Colors.pink;
        break;
      case 'lozenge':
        iconData = Icons.crop_square;
        color = Colors.orange;
        break;
      case 'inhaler':
        iconData = Icons.air;
        color = Colors.green;
        break;
      case 'spray':
        iconData = Icons.sanitizer;
        color = Colors.purple;
        break;
      default:
        iconData = Icons.medication;
        color = Colors.grey;
    }
    
    return CircleAvatar(
      backgroundColor: color.withOpacity(0.2),
      child: Icon(iconData, color: color),
    );
  }
  
  String _getTrendText(String trend) {
    switch (trend) {
      case 'decreasing':
        return 'Decreasing';
      case 'increasing':
        return 'Increasing';
      case 'stable':
        return 'Stable';
      default:
        return 'New User';
    }
  }
  
  IconData _getTrendIcon(String trend) {
    switch (trend) {
      case 'decreasing':
        return Icons.trending_down;
      case 'increasing':
        return Icons.trending_up;
      case 'stable':
        return Icons.trending_flat;
      default:
        return Icons.help_outline;
    }
  }
  
  String _getMostUsedType(List<NRTModel> usage) {
    if (usage.isEmpty) return 'None';
    
    final Map<String, int> typeCounts = {};
    
    for (final record in usage) {
      final type = record.type;
      typeCounts[type.toStorageString()] = (typeCounts[type.toStorageString()] ?? 0) + 1;
    }
    
    String mostUsedType = '';
    int maxCount = 0;
    
    typeCounts.forEach((type, count) {
      if (count > maxCount) {
        maxCount = count;
        mostUsedType = type;
      }
    });
    
    return mostUsedType.substring(0, 1).toUpperCase() + mostUsedType.substring(1);
  }
}