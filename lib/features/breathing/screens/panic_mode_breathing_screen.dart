import 'package:flutter/material.dart';
import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'package:quit_vaping/features/breathing/models/breathing_phase.dart';
import 'package:quit_vaping/features/breathing/widgets/breathing_exercise_player.dart';

/// Screen for panic mode breathing exercises
class PanicModeBreathingScreen extends StatefulWidget {
  /// The exercise to use
  final BreathingExerciseModel exercise;
  
  /// Duration in seconds
  final int durationSeconds;
  
  /// Whether to show the timer
  final bool showTimer;
  
  /// Whether to show the phase name
  final bool showPhaseName;
  
  /// Creates a new panic mode breathing screen
  const PanicModeBreathingScreen({
    super.key,
    required this.exercise,
    required this.durationSeconds,
    this.showTimer = true,
    this.showPhaseName = true,
  });

  @override
  State<PanicModeBreathingScreen> createState() => _PanicModeBreathingScreenState();
}

class _PanicModeBreathingScreenState extends State<PanicModeBreathingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panic Mode'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BreathingExercisePlayer(
                exercise: widget.exercise,
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
