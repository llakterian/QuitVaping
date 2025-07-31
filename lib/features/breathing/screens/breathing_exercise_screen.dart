import 'package:flutter/material.dart';
import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'package:quit_vaping/features/breathing/models/breathing_phase.dart';
import 'package:quit_vaping/features/breathing/widgets/breathing_exercise_player.dart';

/// Screen for breathing exercises
class BreathingExerciseScreen extends StatefulWidget {
  /// The exercise to use
  final BreathingExerciseModel exercise;
  
  /// Custom breathing pattern
  final BreathingPattern? customPattern;
  
  /// Duration in seconds
  final int durationSeconds;
  
  /// Whether to show the timer
  final bool showTimer;
  
  /// Whether to show the phase name
  final bool showPhaseName;
  
  /// Creates a new breathing exercise screen
  const BreathingExerciseScreen({
    super.key,
    required this.exercise,
    this.customPattern,
    this.durationSeconds = 300,
    this.showTimer = true,
    this.showPhaseName = true,
  });

  @override
  State<BreathingExerciseScreen> createState() => _BreathingExerciseScreenState();
}

class _BreathingExerciseScreenState extends State<BreathingExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise.name),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BreathingExercisePlayer(
                exercise: widget.exercise,
                customPattern: widget.customPattern,
                durationSeconds: widget.durationSeconds,
                showTimer: widget.showTimer,
                showPhaseName: widget.showPhaseName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
