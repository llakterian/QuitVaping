import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/breathing_exercise_model.dart';
import '../../../data/models/breathing_preset_model.dart';
import '../../../data/models/breathing_session_model.dart';
import '../../../data/services/breathing_exercise_service.dart';
import '../../../data/services/breathing_preset_service.dart';
import '../../../shared/theme/app_colors.dart';
import '../screens/breathing_accessibility_screen.dart';
import '../screens/breathing_presets_screen.dart';
import '../services/breathing_audio_service.dart';
import '../utils/breathing_accessibility_utils.dart';
import '../widgets/breathing_exercise_player.dart';
import '../widgets/breathing_preset_list.dart';
import '../widgets/save_preset_dialog.dart';

/// Screen for executing a breathing exercise with controls, feedback, and preset support
class BreathingExerciseScreenWithPresets extends StatefulWidget {
  /// The breathing exercise to perform
  final BreathingExerciseModel exercise;
  
  /// Optional custom pattern (overrides the exercise default pattern)
  final BreathingPattern? customPattern;
  
  /// Duration of the exercise in seconds
  final int durationSeconds;
  
  /// Optional preset ID if this exercise was started from a preset
  final String? presetId;

  const BreathingExerciseScreenWithPresets({
    Key? key,
    required this.exercise,
    this.customPattern,
    required this.durationSeconds,
    this.presetId,
  }) : super(key: key);

  @override
  State<BreathingExerciseScreenWithPresets> createState() => _BreathingExerciseScreenWithPresetsState();
}

class _BreathingExerciseScreenWithPresetsState extends State<BreathingExerciseScreenWithPresets> {
  // Timer for tracking session duration
  Timer? _sessionTimer;
  int _elapsedSeconds = 0;
  bool _isCompleted = false;
  
  // Mood improvement tracking
  int _moodImprovement = 0;
  
  // Track completed cycles
  int _completedCycles = 0;
  
  @override
  void initState() {
    super.initState();
    _startSessionTimer();
    
    // If started from a preset, record that it was used
    if (widget.presetId != null) {
      _recordPresetUsed();
    }
  }
  
  @override
  void dispose() {
    _sessionTimer?.cancel();
    super.dispose();
  }
  
  /// Records that a preset was used
  Future<void> _recordPresetUsed() async {
    if (widget.presetId == null) return;
    
    final presetService = Provider.of<BreathingPresetService>(context, listen: false);
    await presetService.recordPresetUsed(widget.presetId!);
  }
  
  /// Starts the session timer
  void _startSessionTimer() {
    _sessionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds++;
        
        // Check if we've reached the target duration
        if (_elapsedSeconds >= widget.durationSeconds) {
          _completeSession();
        }
      });
    });
  }
  
  /// Completes the session and records it
  void _completeSession() {
    if (_isCompleted) return;
    
    _sessionTimer?.cancel();
    setState(() {
      _isCompleted = true;
    });
    
    // Show completion dialog after a short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _showCompletionDialog();
    });
  }
  
  /// Shows the session completion dialog
  Future<void> _showCompletionDialog() async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => _buildCompletionDialog(),
    );
    
    if (result == true) {
      _recordSession();
      Navigator.of(context).pop(); // Return to previous screen
    }
  }
  
  /// Records the completed session
  Future<void> _recordSession() async {
    final breathingService = Provider.of<BreathingExerciseService>(context, listen: false);
    
    // Create a session model
    final session = BreathingSessionModel.fromExercise(
      exercise: widget.exercise,
      durationSeconds: _elapsedSeconds,
      pattern: widget.customPattern,
      completedCycles: _completedCycles,
      moodAfter: _moodImprovement > 0 ? _moodImprovement + 3 : null, // Convert to 1-5 scale
    );
    
    // Record the session
    await breathingService.recordSession(session);
  }
  
  /// Handles when the user stops the exercise early
  Future<void> _handleEarlyStop() async {
    _sessionTimer?.cancel();
    
    final shouldRecord = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('End Session?'),
        content: const Text('Would you like to save this session?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Discard'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    
    if (shouldRecord == true) {
      await _recordSession();
    }
    
    if (mounted) {
      Navigator.of(context).pop(); // Return to previous screen
    }
  }
  
  /// Shows the save preset dialog
  Future<void> _showSavePresetDialog() async {
    final pattern = widget.customPattern ?? widget.exercise.defaultPattern;
    
    final result = await showSavePresetDialog(
      context,
      exerciseId: widget.exercise.id,
      exerciseName: widget.exercise.name,
      pattern: pattern,
      durationSeconds: widget.durationSeconds,
    );
    
    if (result == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preset saved successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
  
  /// Navigates to the presets management screen
  void _navigateToPresetsScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const BreathingPresetsScreen(),
      ),
    );
  }
  
  /// Handles when a preset is selected
  void _handlePresetSelected(BreathingPresetModel preset) {
    // Navigate to a new exercise screen with the preset
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => BreathingExerciseScreenWithPresets(
          exercise: widget.exercise,
          customPattern: preset.pattern,
          durationSeconds: preset.durationSeconds,
          presetId: preset.id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise.name),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            if (!_isCompleted) {
              _handleEarlyStop();
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        actions: [
          // Save preset button
          IconButton(
            icon: const Icon(Icons.bookmark_add),
            tooltip: 'Save as Preset',
            onPressed: _showSavePresetDialog,
          ),
          
          // Manage presets button
          IconButton(
            icon: const Icon(Icons.bookmarks),
            tooltip: 'Manage Presets',
            onPressed: _navigateToPresetsScreen,
          ),
          
          // Accessibility settings button
          IconButton(
            icon: const Icon(Icons.accessibility_new),
            tooltip: 'Accessibility Settings',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const BreathingAccessibilityScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            _buildProgressIndicator(),
            
            // Presets list
            _buildPresetsList(),
            
            // Exercise player
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BreathingExercisePlayer(
                      exercise: widget.exercise,
                      customPattern: widget.customPattern,
                      duration: widget.durationSeconds,
                      onComplete: _completeSession,
                      audioService: Provider.of<BreathingAudioService>(context),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  /// Builds the presets list at the top of the screen
  Widget _buildPresetsList() {
    return Container(
      height: 120,
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Saved Presets',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: BreathingPresetList(
              onPresetSelected: _handlePresetSelected,
              exerciseId: widget.exercise.id,
              maxPresets: 5,
            ),
          ),
        ],
      ),
    );
  }
  
  /// Builds the progress indicator at the top of the screen
  Widget _buildProgressIndicator() {
    final progress = _elapsedSeconds / widget.durationSeconds;
    final remainingSeconds = widget.durationSeconds - _elapsedSeconds;
    
    // Generate semantic label for screen readers
    final semanticLabel = BreathingAccessibilityUtils.getProgressSemanticLabel(
      _elapsedSeconds, 
      widget.durationSeconds
    );
    
    return Semantics(
      label: semanticLabel,
      value: semanticLabel,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Progress bar
          LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: AppColors.primary.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            minHeight: 8,
          ),
          
          // Time remaining
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Elapsed: ${_formatDuration(_elapsedSeconds)}',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Remaining: ${_formatDuration(remainingSeconds)}',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  /// Builds the completion dialog
  Widget _buildCompletionDialog() {
    return AlertDialog(
      title: const Text('Session Complete'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            'Great job! You completed ${_formatDuration(_elapsedSeconds)} of ${widget.exercise.name}.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          const Text(
            'How do you feel now?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildMoodSelector(),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          child: const Text('Done'),
        ),
      ],
    );
  }
  
  /// Builds the mood selector for the completion dialog
  Widget _buildMoodSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildMoodOption(-1, Icons.sentiment_very_dissatisfied, 'Worse'),
        _buildMoodOption(0, Icons.sentiment_neutral, 'Same'),
        _buildMoodOption(1, Icons.sentiment_satisfied, 'Better'),
        _buildMoodOption(2, Icons.sentiment_very_satisfied, 'Much Better'),
      ],
    );
  }
  
  /// Builds a single mood option button
  Widget _buildMoodOption(int value, IconData icon, String label) {
    final isSelected = _moodImprovement == value;
    
    return Semantics(
      label: label,
      button: true,
      selected: isSelected,
      hint: isSelected ? 'Selected' : 'Double tap to select',
      child: InkWell(
        onTap: () {
          setState(() {
            _moodImprovement = value;
          });
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary.withOpacity(0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                size: 32,
                semanticLabel: label,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  /// Formats a duration in seconds to a readable string
  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}