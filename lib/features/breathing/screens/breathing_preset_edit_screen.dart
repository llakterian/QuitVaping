import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'package:quit_vaping/data/models/breathing_preset_model.dart';
import 'package:quit_vaping/data/services/breathing_preset_service.dart';
import 'package:quit_vaping/shared/theme/app_colors.dart';

/// Screen for editing a breathing preset
class BreathingPresetEditScreen extends StatefulWidget {
  /// The preset to edit
  final BreathingPresetModel preset;
  
  /// Create a breathing preset edit screen
  const BreathingPresetEditScreen({
    Key? key,
    required this.preset,
  }) : super(key: key);

  @override
  State<BreathingPresetEditScreen> createState() => _BreathingPresetEditScreenState();
}

class _BreathingPresetEditScreenState extends State<BreathingPresetEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late int _inhaleSeconds;
  late int _inhaleHoldSeconds;
  late int _exhaleSeconds;
  late int _exhaleHoldSeconds;
  late int _durationMinutes;
  bool _isSaving = false;
  String? _errorMessage;
  
  @override
  void initState() {
    super.initState();
    
    // Initialize controllers with preset values
    _nameController = TextEditingController(text: widget.preset.name);
    _inhaleSeconds = widget.preset.pattern.inhaleSeconds;
    _inhaleHoldSeconds = widget.preset.pattern.inhaleHoldSeconds;
    _exhaleSeconds = widget.preset.pattern.exhaleSeconds;
    _exhaleHoldSeconds = widget.preset.pattern.exhaleHoldSeconds;
    _durationMinutes = widget.preset.durationSeconds ~/ 60;
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
  
  Future<void> _savePreset() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _isSaving = true;
      _errorMessage = null;
    });
    
    try {
      final presetService = Provider.of<BreathingPresetService>(context, listen: false);
      
      // Check if name already exists (but not for this preset)
      if (_nameController.text != widget.preset.name) {
        final nameExists = await presetService.presetNameExists(_nameController.text);
        if (nameExists) {
          setState(() {
            _errorMessage = 'A preset with this name already exists';
            _isSaving = false;
          });
          return;
        }
      }
      
      // Create the updated pattern
      final pattern = BreathingPattern(
        inhaleSeconds: _inhaleSeconds,
        inhaleHoldSeconds: _inhaleHoldSeconds,
        exhaleSeconds: _exhaleSeconds,
        exhaleHoldSeconds: _exhaleHoldSeconds,
      );
      
      // Check if pattern already exists (but not for this preset)
      if (pattern != widget.preset.pattern) {
        final patternExists = await presetService.presetPatternExists(pattern);
        if (patternExists) {
          setState(() {
            _errorMessage = 'This pattern is already saved as a preset';
            _isSaving = false;
          });
          return;
        }
      }
      
      // Create the updated preset
      final updatedPreset = widget.preset.copyWith(
        name: _nameController.text,
        pattern: pattern,
        durationSeconds: _durationMinutes * 60,
      );
      
      // Save the preset
      await presetService.updatePreset(updatedPreset);
      
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to save preset: ${e.toString()}';
        _isSaving = false;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Preset'),
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _savePreset,
            child: _isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('SAVE'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Preset name
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Preset Name',
                hintText: 'Enter a name for this preset',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                if (value.length < 3) {
                  return 'Name must be at least 3 characters';
                }
                if (value.length > 30) {
                  return 'Name must be less than 30 characters';
                }
                return null;
              },
              enabled: !_isSaving,
            ),
            const SizedBox(height: 24),
            
            // Pattern settings
            Text(
              'Breathing Pattern',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            
            // Inhale duration
            _buildDurationSlider(
              label: 'Inhale Duration',
              value: _inhaleSeconds,
              min: BreathingPattern.minDuration,
              max: BreathingPattern.maxDuration,
              onChanged: (value) {
                setState(() {
                  _inhaleSeconds = value;
                });
              },
            ),
            
            // Inhale hold duration
            _buildDurationSlider(
              label: 'Inhale Hold Duration',
              value: _inhaleHoldSeconds,
              min: 0,
              max: BreathingPattern.maxDuration,
              onChanged: (value) {
                setState(() {
                  _inhaleHoldSeconds = value;
                });
              },
            ),
            
            // Exhale duration
            _buildDurationSlider(
              label: 'Exhale Duration',
              value: _exhaleSeconds,
              min: BreathingPattern.minDuration,
              max: BreathingPattern.maxDuration,
              onChanged: (value) {
                setState(() {
                  _exhaleSeconds = value;
                });
              },
            ),
            
            // Exhale hold duration
            _buildDurationSlider(
              label: 'Exhale Hold Duration',
              value: _exhaleHoldSeconds,
              min: 0,
              max: BreathingPattern.maxDuration,
              onChanged: (value) {
                setState(() {
                  _exhaleHoldSeconds = value;
                });
              },
            ),
            
            const SizedBox(height: 24),
            
            // Exercise duration
            Text(
              'Exercise Duration',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            
            _buildDurationSlider(
              label: 'Duration (minutes)',
              value: _durationMinutes,
              min: 1,
              max: 30,
              onChanged: (value) {
                setState(() {
                  _durationMinutes = value;
                });
              },
            ),
            
            const SizedBox(height: 24),
            
            // Pattern preview
            _buildPatternPreview(theme),
            
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
  
  Widget _buildDurationSlider({
    required String label,
    required int value,
    required int min,
    required int max,
    required Function(int) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text('$value seconds'),
          ],
        ),
        Slider(
          value: value.toDouble(),
          min: min.toDouble(),
          max: max.toDouble(),
          divisions: max - min,
          onChanged: _isSaving ? null : (newValue) {
            onChanged(newValue.round());
          },
        ),
      ],
    );
  }
  
  Widget _buildPatternPreview(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pattern Preview',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPatternPhase(theme, 'Inhale', _inhaleSeconds),
              _buildPatternPhase(theme, 'Hold', _inhaleHoldSeconds),
              _buildPatternPhase(theme, 'Exhale', _exhaleSeconds),
              _buildPatternPhase(theme, 'Hold', _exhaleHoldSeconds),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Total cycle time: ${_inhaleSeconds + _inhaleHoldSeconds + _exhaleSeconds + _exhaleHoldSeconds} seconds',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Exercise duration: $_durationMinutes minutes',
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
  
  Widget _buildPatternPhase(ThemeData theme, String label, int seconds) {
    return Column(
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '$seconds',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}