import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'package:quit_vaping/data/models/breathing_preset_model.dart';
import 'package:quit_vaping/data/services/breathing_preset_service.dart';

/// A dialog for saving a breathing pattern as a preset
class SavePresetDialog extends StatefulWidget {
  /// The exercise ID this preset is for
  final String exerciseId;
  
  /// The exercise name
  final String exerciseName;
  
  /// The breathing pattern to save
  final BreathingPattern pattern;
  
  /// The duration in seconds
  final int durationSeconds;
  
  /// Create a save preset dialog
  const SavePresetDialog({
    Key? key,
    required this.exerciseId,
    required this.exerciseName,
    required this.pattern,
    required this.durationSeconds,
  }) : super(key: key);

  @override
  State<SavePresetDialog> createState() => _SavePresetDialogState();
}

class _SavePresetDialogState extends State<SavePresetDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _isSaving = false;
  String? _errorMessage;
  
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
      
      // Check if name already exists
      final nameExists = await presetService.presetNameExists(_nameController.text);
      if (nameExists) {
        setState(() {
          _errorMessage = 'A preset with this name already exists';
          _isSaving = false;
        });
        return;
      }
      
      // Check if pattern already exists
      final patternExists = await presetService.presetPatternExists(widget.pattern);
      if (patternExists) {
        setState(() {
          _errorMessage = 'This pattern is already saved as a preset';
          _isSaving = false;
        });
        return;
      }
      
      // Create and save the preset
      final preset = BreathingPresetModel.create(
        name: _nameController.text,
        exerciseId: widget.exerciseId,
        exerciseName: widget.exerciseName,
        pattern: widget.pattern,
        durationSeconds: widget.durationSeconds,
      );
      
      await presetService.savePreset(preset);
      
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
    
    return AlertDialog(
      title: const Text('Save Preset'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Save this breathing pattern as a preset for quick access later.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
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
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _savePreset(),
              enabled: !_isSaving,
            ),
            const SizedBox(height: 16),
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
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.of(context).pop(false),
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
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
    );
  }
  
  Widget _buildPatternPreview(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pattern Preview',
            style: theme.textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPatternPhase(theme, 'Inhale', widget.pattern.inhaleSeconds),
              _buildPatternPhase(theme, 'Hold', widget.pattern.inhaleHoldSeconds),
              _buildPatternPhase(theme, 'Exhale', widget.pattern.exhaleSeconds),
              _buildPatternPhase(theme, 'Hold', widget.pattern.exhaleHoldSeconds),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Duration: ${widget.durationSeconds ~/ 60} minutes',
            style: theme.textTheme.bodySmall,
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
        const SizedBox(height: 4),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '$seconds',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

/// Shows the save preset dialog
Future<bool?> showSavePresetDialog(
  BuildContext context, {
  required String exerciseId,
  required String exerciseName,
  required BreathingPattern pattern,
  required int durationSeconds,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => SavePresetDialog(
      exerciseId: exerciseId,
      exerciseName: exerciseName,
      pattern: pattern,
      durationSeconds: durationSeconds,
    ),
  );
}