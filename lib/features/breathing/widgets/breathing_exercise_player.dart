import 'package:flutter/material.dart';
import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'package:quit_vaping/features/breathing/models/breathing_phase.dart';

/// Widget for playing breathing exercises
class BreathingExercisePlayer extends StatefulWidget {
  /// The exercise to play
  final BreathingExerciseModel exercise;
  
  /// Custom breathing pattern
  final BreathingPattern? customPattern;
  
  /// Duration in seconds
  final int durationSeconds;
  
  /// Whether to show the timer
  final bool showTimer;
  
  /// Whether to show the phase name
  final bool showPhaseName;
  
  /// Creates a new breathing exercise player
  const BreathingExercisePlayer({
    super.key,
    required this.exercise,
    this.customPattern,
    required this.durationSeconds,
    this.showTimer = true,
    this.showPhaseName = true,
  });

  @override
  State<BreathingExercisePlayer> createState() => _BreathingExercisePlayerState();
}

class _BreathingExercisePlayerState extends State<BreathingExercisePlayer> {
  late BreathingPhase _currentPhase;
  late int _secondsRemaining;
  late int _phaseSecondsRemaining;
  late bool _isPlaying;
  
  @override
  void initState() {
    super.initState();
    _currentPhase = BreathingPhase.inhale;
    _secondsRemaining = widget.durationSeconds;
    _phaseSecondsRemaining = _getPhaseSeconds(_currentPhase);
    _isPlaying = false;
  }
  
  int _getPhaseSeconds(BreathingPhase phase) {
    final pattern = widget.customPattern ?? widget.exercise.defaultPattern;
    switch (phase) {
      case BreathingPhase.inhale:
        return pattern.inhaleSeconds;
      case BreathingPhase.inhaleHold:
        return pattern.inhaleHoldSeconds;
      case BreathingPhase.exhale:
        return pattern.exhaleSeconds;
      case BreathingPhase.exhaleHold:
        return pattern.exhaleHoldSeconds;
    }
  }
  
  void _handlePhaseChanged(BreathingPhase phase, int secondsRemaining) {
    setState(() {
      _currentPhase = phase;
      _phaseSecondsRemaining = secondsRemaining;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.exercise.name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 20),
          if (widget.showPhaseName)
            Text(
              _currentPhase.displayName,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          const SizedBox(height: 40),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor.withOpacity(0.2),
            ),
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: _currentPhase == BreathingPhase.inhale ? 150 : 100,
                height: _currentPhase == BreathingPhase.inhale ? 150 : 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          if (widget.showTimer)
            Text(
              '${_secondsRemaining ~/ 60}:${(_secondsRemaining % 60).toString().padLeft(2, '0')}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                iconSize: 48,
                onPressed: () {
                  setState(() {
                    _isPlaying = !_isPlaying;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.replay),
                iconSize: 48,
                onPressed: () {
                  setState(() {
                    _secondsRemaining = widget.durationSeconds;
                    _currentPhase = BreathingPhase.inhale;
                    _phaseSecondsRemaining = _getPhaseSeconds(_currentPhase);
                    _isPlaying = false;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
