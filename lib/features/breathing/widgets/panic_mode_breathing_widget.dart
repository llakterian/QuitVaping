import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'package:quit_vaping/features/breathing/models/breathing_phase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/breathing_exercise_model.dart';
import '../../../data/services/breathing_exercise_service.dart';
import '../../../shared/theme/app_colors.dart';
import '../controllers/breathing_controller.dart';
import '../models/breathing_phase.dart';
import '../services/breathing_audio_service.dart';
import '../widgets/breathing_animation_widget.dart';

/// A simplified breathing exercise widget for panic mode
class PanicModeBreathingWidget extends StatefulWidget {
  /// The breathing exercise to perform
  final BreathingExerciseModel exercise;
  
  /// Duration of the exercise in seconds
  final int durationSeconds;

  /// Callback when the exercise is completed
  final VoidCallback? onCompleted;

  /// Callback when the exercise is stopped
  final VoidCallback? onStopped;

  const PanicModeBreathingWidget({
    Key? key,
    required this.exercise,
    required this.durationSeconds,
    this.onCompleted,
    this.onStopped,
  }) : super(key: key);

  @override
  State<PanicModeBreathingWidget> createState() => _PanicModeBreathingWidgetState();
}

class _PanicModeBreathingWidgetState extends State<PanicModeBreathingWidget> {
  late BreathingController _controller;
  late BreathingAudioService _audioService;
  int _elapsedSeconds = 0;
  bool _isPlaying = false;
  
  @override
  void initState() {
    super.initState();
    _initializeController();
    _startExercise();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    _audioService.dispose();
    super.dispose();
  }
  
  /// Initializes the breathing controller and audio service
  void _initializeController() {
    // Create audio service
    _audioService = BreathingAudioService();
    
    // Create controller with the exercise pattern
    _controller = BreathingController(
      audioService: _audioService,
      onPhaseChanged: _handlePhaseChanged,
    );
    
    // Initialize controller with the exercise
    _controller.initialize(widget.exercise, widget.exercise.defaultPattern);
    
    // Check if audio is enabled
    final breathingService = Provider.of<BreathingExerciseService>(context, listen: false);
    final audioEnabled = breathingService.isAudioEnabled();
    
    if (audioEnabled) {
      _audioService.initialize();
    }
  }
  
  /// Handles phase changes in the breathing cycle
  void _handlePhaseChanged(BreathingPhase phase, int secondsRemaining) {
    if (!mounted) return;
    
    // Play audio cue based on the phase
    switch (phase) {
      case BreathingPhase.inhale:
        _audioService.playInhale();
        break;
      case BreathingPhase.inhaleHold:
        _audioService.playHold();
        break;
      case BreathingPhase.exhale:
        _audioService.playExhale();
        break;
      case BreathingPhase.exhaleHold:
        _audioService.playHold();
        break;
    }
    
    // Update elapsed time
    setState(() {
      _elapsedSeconds++;
      
      // Check if we've reached the target duration
      if (_elapsedSeconds >= widget.durationSeconds) {
        _completeExercise();
      }
    });
  }
  
  /// Starts the breathing exercise
  void _startExercise() {
    setState(() {
      _isPlaying = true;
    });
    _controller.start();
  }
  
  /// Pauses the breathing exercise
  void _pauseExercise() {
    setState(() {
      _isPlaying = false;
    });
    _controller.pause();
  }
  
  /// Resumes the breathing exercise
  void _resumeExercise() {
    setState(() {
      _isPlaying = true;
    });
    _controller.resume();
  }
  
  /// Stops the breathing exercise
  void _stopExercise() {
    _controller.stop();
    if (widget.onStopped != null) {
      widget.onStopped!();
    }
  }
  
  /// Completes the breathing exercise
  void _completeExercise() {
    _controller.stop();
    if (widget.onCompleted != null) {
      widget.onCompleted!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = _elapsedSeconds / widget.durationSeconds;
    final remainingSeconds = widget.durationSeconds - _elapsedSeconds;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Progress indicator
        LinearProgressIndicator(
          value: progress.clamp(0.0, 1.0),
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          minHeight: 6,
        ),
        
        const SizedBox(height: 16),
        
        // Exercise name
        Text(
          widget.exercise.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 8),
        
        // Brief description
        Text(
          widget.exercise.description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 24),
        
        // Breathing animation
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return BreathingAnimationWidget(
              pattern: widget.exercise.defaultPattern,
              isPlaying: _isPlaying,
              size: 200,
              onPhaseChanged: _handlePhaseChanged,
            );
          },
        ),
        
        const SizedBox(height: 24),
        
        // Current phase instruction
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            String instruction;
            switch (_controller.currentPhase) {
              case BreathingPhase.inhale:
                instruction = 'Breathe In';
                break;
              case BreathingPhase.inhaleHold:
                instruction = 'Hold';
                break;
              case BreathingPhase.exhale:
                instruction = 'Breathe Out';
                break;
              case BreathingPhase.exhaleHold:
                instruction = 'Hold';
                break;
            }
            
            return Text(
              instruction,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        
        const SizedBox(height: 8),
        
        // Seconds remaining in phase
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Text(
              '${_controller.phaseSecondsRemaining} seconds',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            );
          },
        ),
        
        const SizedBox(height: 24),
        
        // Time remaining
        Text(
          'Time remaining: ${_formatDuration(remainingSeconds)}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Control buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Play/Pause button
            ElevatedButton(
              onPressed: _isPlaying ? _pauseExercise : _resumeExercise,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
                backgroundColor: AppColors.primary,
              ),
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 32,
              ),
            ),
            
            const SizedBox(width: 24),
            
            // Stop button
            ElevatedButton(
              onPressed: _stopExercise,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.grey[300],
              ),
              child: const Icon(
                Icons.stop,
                color: Colors.black54,
                size: 32,
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  /// Formats a duration in seconds to a readable string
  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}