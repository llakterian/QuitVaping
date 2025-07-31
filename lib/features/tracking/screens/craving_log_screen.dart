import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/common_widgets.dart';
import '../../../shared/constants/app_constants.dart';
import '../../../data/models/breathing_session_model.dart';
import '../../../data/services/breathing_exercise_service.dart';
import '../../../features/breathing/services/breathing_craving_integration_service.dart';
import '../../../features/breathing/widgets/breathing_exercise_suggestion.dart';
import '../models/craving_model.dart';
import '../widgets/craving_intensity_slider.dart';

class CravingLogScreen extends StatefulWidget {
  final Function(CravingModel)? onCravingLogged;
  
  const CravingLogScreen({Key? key, this.onCravingLogged}) : super(key: key);

  @override
  State<CravingLogScreen> createState() => _CravingLogScreenState();
}

class _CravingLogScreenState extends State<CravingLogScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Form values
  int _intensity = 5;
  String _triggerCategory = '';
  String _trigger = '';
  String _location = '';
  String _activity = '';
  String _notes = '';
  bool _resisted = true;
  
  // Selected trigger category for UI
  String? _selectedTriggerCategory;
  
  // Store the craving for later use with breathing exercise feedback
  CravingModel? _lastLoggedCraving;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log a Craving'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Intensity slider
            const Text(
              'How intense is your craving?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            CravingIntensitySlider(
              value: _intensity,
              onChanged: (value) {
                setState(() {
                  _intensity = value;
                });
              },
            ),
            const SizedBox(height: 24),
            
            // Trigger category
            const Text(
              'What triggered this craving?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildTriggerCategorySelector(),
            const SizedBox(height: 16),
            
            // Specific trigger
            if (_selectedTriggerCategory != null) ...[
              _buildTriggerSelector(_selectedTriggerCategory!),
              const SizedBox(height: 24),
            ],
            
            // Location
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Where are you?',
                hintText: 'e.g., Home, Work, Car',
                prefixIcon: Icon(Icons.location_on),
              ),
              onChanged: (value) {
                setState(() {
                  _location = value;
                });
              },
            ),
            const SizedBox(height: 16),
            
            // Activity
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'What are you doing?',
                hintText: 'e.g., Working, Relaxing, Socializing',
                prefixIcon: Icon(Icons.event),
              ),
              onChanged: (value) {
                setState(() {
                  _activity = value;
                });
              },
            ),
            const SizedBox(height: 16),
            
            // Notes
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Notes',
                hintText: 'Any additional details',
                prefixIcon: Icon(Icons.note),
              ),
              maxLines: 3,
              onChanged: (value) {
                setState(() {
                  _notes = value;
                });
              },
            ),
            const SizedBox(height: 24),
            
            // Did you resist?
            Row(
              children: [
                const Text(
                  'Did you resist this craving?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Switch(
                  value: _resisted,
                  activeColor: AppColors.success,
                  onChanged: (value) {
                    setState(() {
                      _resisted = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Submit button
            RoundedButton(
              text: 'Log Craving',
              icon: Icons.check,
              useGradient: true,
              onPressed: _submitForm,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTriggerCategorySelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: AppConstants.commonTriggers.keys.map((category) {
        final isSelected = _selectedTriggerCategory == category;
        return FilterChip(
          label: Text(category),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              _selectedTriggerCategory = selected ? category : null;
              _trigger = ''; // Reset trigger when category changes
              if (selected) {
                _triggerCategory = category;
              } else {
                _triggerCategory = '';
              }
            });
          },
          backgroundColor: Colors.grey[200],
          selectedColor: AppColors.primary.withOpacity(0.2),
          checkmarkColor: AppColors.primary,
          labelStyle: TextStyle(
            color: isSelected ? AppColors.primary : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        );
      }).toList(),
    );
  }
  
  Widget _buildTriggerSelector(String category) {
    final triggers = AppConstants.commonTriggers[category] ?? [];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select a specific $category trigger:',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: triggers.map((specificTrigger) {
            final isSelected = _trigger == specificTrigger;
            return FilterChip(
              label: Text(specificTrigger),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _trigger = selected ? specificTrigger : '';
                });
              },
              backgroundColor: Colors.grey[200],
              selectedColor: AppColors.secondary.withOpacity(0.2),
              checkmarkColor: AppColors.secondary,
              labelStyle: TextStyle(
                color: isSelected ? AppColors.secondary : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
  
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final craving = CravingModel.create(id: DateTime.now().millisecondsSinceEpoch.toString(), gaveIn: false, 
        timestamp: DateTime.now(),
        intensity: _intensity,
        triggerCategory: _triggerCategory,
        trigger: _trigger,
        location: _location,
        activity: _activity,
        notes: _notes,
        resisted: _resisted,
      );
      
      // Store the craving for later use
      _lastLoggedCraving = craving;
      
      if (widget.onCravingLogged != null) {
        widget.onCravingLogged!(craving);
      }
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_resisted 
            ? 'Great job resisting that craving!' 
            : 'Craving logged. Keep trying, you\'ll get there!'),
          backgroundColor: _resisted ? AppColors.success : AppColors.primary,
        ),
      );
      
      // Show breathing exercise suggestion
      await _showBreathingExerciseSuggestion(craving);
      
      // Navigate back
      Navigator.pop(context);
    }
  }
  
  /// Shows a breathing exercise suggestion based on the craving
  Future<void> _showBreathingExerciseSuggestion(CravingModel craving) async {
    try {
      final breathingService = Provider.of<BreathingExerciseService>(context, listen: false);
      final integrationService = Provider.of<BreathingCravingIntegrationService>(
        context, 
        listen: false
      );
      
      // Get a recommended exercise based on the craving
      final recommendedExercise = await integrationService.getRecommendedExerciseForCraving(craving);
      
      if (recommendedExercise == null) {
        return;
      }
      
      // Save as the last suggested exercise
      await integrationService.setLastSuggestedExercise(recommendedExercise.id);
      
      // Show the suggestion dialog
      if (!mounted) return;
      
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: BreathingExerciseSuggestion(
              craving: craving,
              exercise: recommendedExercise,
              onStartExercise: () {
                Navigator.pop(context); // Close the bottom sheet
                _navigateToBreathingExercise(recommendedExercise);
              },
              onDismiss: () {
                Navigator.pop(context); // Close the bottom sheet
              },
            ),
          );
        },
      );
    } catch (e) {
      // Handle any errors silently
      debugPrint('Error showing breathing suggestion: $e');
    }
  }
  
  /// Navigates to the breathing exercise screen
  void _navigateToBreathingExercise(BreathingExerciseModel exercise) {
    Navigator.of(context).pushNamed(
      '/breathing/exercise',
      arguments: {
        'exercise': exercise,
        'craving': _lastLoggedCraving,
      },
    ).then((result) {
      // Handle the result when returning from the breathing exercise
      if (result != null && result is Map<String, dynamic> && 
          result.containsKey('sessionCompleted') && result['sessionCompleted'] == true) {
        
        _showBreathingFeedbackDialog(
          exercise, 
          result['sessionDuration'] as int? ?? 0,
          result['sessionId'] as String? ?? const Uuid().v4(),
        );
      }
    });
  }
  
  /// Shows a dialog to get feedback about the breathing exercise's effectiveness
  Future<void> _showBreathingFeedbackDialog(
    BreathingExerciseModel exercise,
    int sessionDuration,
    String sessionId,
  ) async {
    if (_lastLoggedCraving == null || !mounted) return;
    
    int? intensityAfter;
    bool? wasEffective;
    
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('How do you feel now?'),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Rate your craving intensity now:'),
                const SizedBox(height: 16),
                CravingIntensitySlider(
                  value: intensityAfter ?? _lastLoggedCraving!.intensity,
                  onChanged: (value) {
                    setState(() {
                      intensityAfter = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                const Text('Did the breathing exercise help?'),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        wasEffective = true;
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Yes, it helped'),
                    ),
                    TextButton(
                      onPressed: () {
                        wasEffective = false;
                        Navigator.pop(context);
                      },
                      child: const Text('Not really'),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
    
    // Record the feedback if provided
    if (wasEffective != null && _lastLoggedCraving != null) {
      final integrationService = Provider.of<BreathingCravingIntegrationService>(
        context, 
        listen: false
      );
      
      // Create a session model for the completed breathing session
      final session = BreathingSessionModel(
        id: sessionId,
        exerciseId: exercise.id,
        exerciseName: exercise.name,
        timestamp: DateTime.now(),
        durationSeconds: sessionDuration,
        pattern: exercise.defaultPattern,
        completed: true,
      );
      
      // Record the correlation between the craving and breathing exercise
      await integrationService.recordBreathingSessionAfterCraving(
        _lastLoggedCraving!,
        session,
        wasEffective!,
        intensityAfter,
      );
      
      // Show a thank you message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              wasEffective! 
                ? 'Great! We\'ll recommend similar exercises in the future.' 
                : 'Thanks for the feedback. We\'ll try different exercises next time.'
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }
}