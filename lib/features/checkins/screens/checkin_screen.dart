import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../data/models/craving_model.dart';
import '../../../data/services/user_service.dart';
import '../../../data/services/subscription_service.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/constants/app_constants.dart';
import '../../subscription/screens/subscription_screen.dart';
import '../../subscription/widgets/premium_feature_overlay.dart';
import '../widgets/craving_analytics.dart';

class CheckinScreen extends StatefulWidget {
  const CheckinScreen({Key? key}) : super(key: key);

  @override
  State<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late TabController _tabController;
  
  // Form values
  int _intensity = 5;
  String _triggerCategory = 'emotional';
  String? _specificTrigger;
  String? _location;
  String? _activity;
  String? _emotion;
  String? _copingStrategy;
  bool _resolved = false;
  String? _notes;
  
  bool _isSubmitting = false;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        title: const Text('Daily Check-in'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Log Craving'),
            Tab(text: 'Analytics'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCravingForm(),
          const CravingAnalytics(),
        ],
      ),
    );
  }
  
  Widget _buildCravingForm() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Log a Craving',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  
                  // Intensity slider
                  Text(
                    'How intense was your craving?',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text('Mild'),
                      Expanded(
                        child: Slider(
                          value: _intensity.toDouble(),
                          min: 1,
                          max: 10,
                          divisions: 9,
                          label: _intensity.toString(),
                          activeColor: AppColors.getCravingColor(_intensity),
                          onChanged: (value) {
                            setState(() {
                              _intensity = value.round();
                            });
                          },
                        ),
                      ),
                      const Text('Severe'),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Trigger category
                  Text(
                    'What triggered this craving?',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _triggerCategory,
                    decoration: const InputDecoration(
                      labelText: 'Trigger Category',
                      border: OutlineInputBorder(),
                    ),
                    items: AppConstants.triggerCategories
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category.capitalize()),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _triggerCategory = value!;
                        _specificTrigger = null; // Reset specific trigger
                      });
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Specific trigger
                  DropdownButtonFormField<String>(
                    value: _specificTrigger,
                    decoration: const InputDecoration(
                      labelText: 'Specific Trigger',
                      border: OutlineInputBorder(),
                    ),
                    items: AppConstants.commonTriggers[_triggerCategory]
                            ?.map((trigger) => DropdownMenuItem(
                                  value: trigger,
                                  child: Text(trigger),
                                ))
                            .toList() ??
                        [],
                    onChanged: (value) {
                      setState(() {
                        _specificTrigger = value;
                      });
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Location
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Location (optional)',
                      border: OutlineInputBorder(),
                      hintText: 'Where were you?',
                    ),
                    onChanged: (value) {
                      _location = value;
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Activity
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Activity (optional)',
                      border: OutlineInputBorder(),
                      hintText: 'What were you doing?',
                    ),
                    onChanged: (value) {
                      _activity = value;
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Emotion
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Emotion (optional)',
                      border: OutlineInputBorder(),
                      hintText: 'How were you feeling?',
                    ),
                    onChanged: (value) {
                      _emotion = value;
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Coping strategy
                  DropdownButtonFormField<String>(
                    value: _copingStrategy,
                    decoration: const InputDecoration(
                      labelText: 'Coping Strategy Used (optional)',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('None'),
                      ),
                      ...AppConstants.copingStrategies
                          .map((strategy) => DropdownMenuItem(
                                value: strategy,
                                child: Text(strategy),
                              ))
                          .toList(),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _copingStrategy = value;
                      });
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Resolved
                  CheckboxListTile(
                    title: const Text('Did you overcome this craving?'),
                    value: _resolved,
                    activeColor: AppColors.primary,
                    onChanged: (value) {
                      setState(() {
                        _resolved = value ?? false;
                      });
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Notes
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Notes (optional)',
                      border: OutlineInputBorder(),
                      hintText: 'Any additional details?',
                    ),
                    maxLines: 3,
                    onChanged: (value) {
                      _notes = value;
                    },
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          ElevatedButton(
            onPressed: _isSubmitting ? null : _submitCraving,
            child: _isSubmitting
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Future<void> _submitCraving() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isSubmitting = true;
      });
      
      try {
        // Create craving model
        final craving = CravingModel(
          id: const Uuid().v4(),
          timestamp: DateTime.now(),
          intensity: _intensity,
          triggerCategory: _triggerCategory,
          specificTrigger: _specificTrigger,
          location: _location,
          activity: _activity,
          emotion: _emotion,
          copingStrategy: _copingStrategy,
          resolved: _resolved,
          notes: _notes,
        );
        
        // TODO: Save craving to storage
        
        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Craving logged successfully'),
              backgroundColor: AppColors.success,
            ),
          );
          
          // Navigate back
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error logging craving: $e'),
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

// Using StringExtension from craving_analytics.dart