import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../data/models/nrt_model.dart';
import '../../../data/services/nrt_service.dart';
import '../../../data/services/user_service.dart';
import '../../../shared/theme/app_colors.dart';
import '../widgets/nrt_usage_chart.dart';
import '../widgets/nrt_schedule_card.dart';
import '../widgets/nrt_analytics_tab.dart';

class NRTTrackerScreen extends StatefulWidget {
  const NRTTrackerScreen({Key? key}) : super(key: key);

  @override
  State<NRTTrackerScreen> createState() => _NRTTrackerScreenState();
}

class _NRTTrackerScreenState extends State<NRTTrackerScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
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
            Tab(text: 'Usage Log'),
            Tab(text: 'Reduction Plan'),
            Tab(text: 'Analytics'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _UsageLogTab(),
          _ReductionPlanTab(),
          NRTAnalyticsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddNRTDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddNRTDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => const _AddNRTForm(),
    );
  }
}

class _UsageLogTab extends StatelessWidget {
  const _UsageLogTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  Icons.medication,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  'No NRT usage recorded yet',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tap the + button to log your NRT usage',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }
        
        // Group by date
        final Map<String, List<NRTModel>> usageByDate = {};
        for (final record in usage) {
          final dateStr = DateFormat('yyyy-MM-dd').format(record.timestamp);
          usageByDate[dateStr] = [...(usageByDate[dateStr] ?? []), record];
        }
        
        // Sort dates in descending order
        final sortedDates = usageByDate.keys.toList()..sort((a, b) => b.compareTo(a));
        
        return Column(
          children: [
            // Chart
            Padding(
              padding: const EdgeInsets.all(16),
              child: NRTUsageChart(usage: usage),
            ),
            
            // Daily summary
            Expanded(
              child: ListView.builder(
                itemCount: sortedDates.length,
                itemBuilder: (context, index) {
                  final dateStr = sortedDates[index];
                  final dateRecords = usageByDate[dateStr] ?? [];
                  final date = DateFormat('yyyy-MM-dd').parse(dateStr);
                  final formattedDate = DateFormat.yMMMd().format(date);
                  
                  // Calculate total nicotine for the day
                  final totalNicotine = dateRecords.fold(
                    0.0,
                    (sum, record) => sum + (record.nicotineStrength == null ? 0.0 : record.nicotineStrength as double),
                  );
                  
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ExpansionTile(
                      title: Text(formattedDate),
                      subtitle: Text(
                        'Total: ${totalNicotine.toStringAsFixed(1)} mg nicotine',
                        style: const TextStyle(color: AppColors.primary),
                      ),
                      children: dateRecords.map((record) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primary.withValues(alpha: 26), // 0.1 * 255 ≈ 26
                            child: const Icon(Icons.medication, color: AppColors.primary),
                          ),
                          title: Text(record.type.displayName),
                          subtitle: Text(
                            '${record.nicotineStrength} mg - ${DateFormat.jm().format(record.timestamp)}',
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _confirmDeleteRecord(context, nrtService, record);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteRecord(
    BuildContext context,
    NRTService nrtService,
    NRTModel record,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Record'),
        content: const Text('Are you sure you want to delete this NRT usage record?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              nrtService.deleteNRTUsage(record.id);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _ReductionPlanTab extends StatelessWidget {
  const _ReductionPlanTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NRTService>(
      builder: (context, nrtService, child) {
        if (nrtService.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        
        final schedule = nrtService.nrtSchedule;
        
        if (schedule == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.schedule,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  'No NRT reduction plan yet',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Create a plan to gradually reduce your nicotine intake',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    _showCreatePlanDialog(context);
                  },
                  child: const Text('Create Reduction Plan'),
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
              NRTScheduleCard(schedule: schedule),
              const SizedBox(height: 16),
              
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reduction Steps',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      
                      ...schedule.reductionSteps.asMap().entries.map((entry) {
                        final index = entry.key;
                        final step = entry.value;
                        final isCompleted = step.targetDate.isBefore(DateTime.now());
                        final isNext = !isCompleted && 
                            (index == 0 || schedule.reductionSteps[index - 1].targetDate.isBefore(DateTime.now()));
                        
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isCompleted
                                ? AppColors.success
                                : isNext
                                    ? AppColors.primary
                                    : Colors.grey[300],
                            child: Icon(
                              isCompleted ? Icons.check : Icons.schedule,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            'Step ${index + 1}: ${step.nicotineStrength} mg',
                            style: TextStyle(
                              fontWeight: isNext ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          subtitle: Text(
                            '${DateFormat.yMMMd().format(step.targetDate)} - ${step.frequencyPerDay} times/day',
                          ),
                          trailing: isNext
                              ? const Icon(Icons.arrow_forward, color: AppColors.primary)
                              : null,
                        );
                      }).toList(),
                      
                      const SizedBox(height: 16),
                      Center(
                        child: TextButton.icon(
                          onPressed: () {
                            _showEditPlanDialog(context, schedule);
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit Plan'),
                        ),
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

  void _showCreatePlanDialog(BuildContext context) {
    // Implementation for creating a new plan
    // This would be a complex form with multiple steps
    // For brevity, we'll just show a placeholder
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Reduction Plan'),
        content: const Text('This would open a multi-step form to create a personalized NRT reduction plan.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showEditPlanDialog(BuildContext context, NRTScheduleModel schedule) {
    // Implementation for editing an existing plan
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Reduction Plan'),
        content: const Text('This would open a form to edit your current NRT reduction plan.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _AddNRTForm extends StatefulWidget {
  const _AddNRTForm({Key? key}) : super(key: key);

  @override
  State<_AddNRTForm> createState() => _AddNRTFormState();
}

class _AddNRTFormState extends State<_AddNRTForm> {
  final _formKey = GlobalKey<FormState>();
  NRTType _selectedType = NRTType.patch;
  final _strengthController = TextEditingController();
  String? _notes;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _strengthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Log NRT Usage',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            // NRT Type
            DropdownButtonFormField<NRTType>(
              value: _selectedType,
              decoration: const InputDecoration(
                labelText: 'NRT Type',
                border: OutlineInputBorder(),
              ),
              items: NRTType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.displayName),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedType = value!;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select an NRT type';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Nicotine Strength
            TextFormField(
              controller: _strengthController,
              decoration: const InputDecoration(
                labelText: 'Nicotine Strength (mg)',
                border: OutlineInputBorder(),
                hintText: 'e.g., 14',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the nicotine strength';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Notes
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Notes (optional)',
                border: OutlineInputBorder(),
                hintText: 'Any additional details',
              ),
              maxLines: 2,
              onChanged: (value) {
                _notes = value;
              },
            ),
            const SizedBox(height: 24),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitForm,
                child: _isSubmitting
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Save'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isSubmitting = true;
      });
      
      try {
        final nrtService = Provider.of<NRTService>(context, listen: false);
        final userService = Provider.of<UserService>(context, listen: false);
        
        if (userService.currentUser == null) {
          throw Exception('User not logged in');
        }
        
        await nrtService.recordNRTUsage(
          userId: userService.currentUser!.id,
          type: _selectedType,
          nicotineStrength: double.parse(_strengthController.text),
          notes: _notes,
        );
        
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('NRT usage recorded successfully'),
              backgroundColor: AppColors.success,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error recording NRT usage: $e'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isSubmitting = false;
          });
        }
      }
    }
  }
}