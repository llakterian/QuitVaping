import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/breathing_exercise_model.dart';
import '../../../data/services/breathing_exercise_service.dart';
import '../services/breathing_audio_service_optimized.dart';
import '../widgets/breathing_exercise_player.dart';

/// Screen for executing a breathing exercise with controls and feedback
/// Optimized for performance and resource usage
class BreathingExerciseScreen extends StatefulWidget {
  /// The breathing exercise to perform
  final BreathingExerciseModel exercise;
  
  /// Optional custom pattern to use instead of the exercise's default pattern
  final BreathingPattern? customPattern;
  
  /// Optional duration in seconds (defaults to exercise's recommended duration)
  final int? duration;

  /// Creates a new BreathingExerciseScreen
  const BreathingExerciseScreen({
    Key? key,
    required this.exercise,
    this.customPattern,
    this.duration,
  }) : super(key: key);

  @override
  State<BreathingExerciseScreen> createState() => _BreathingExerciseScreenState();
}

class _BreathingExerciseScreenState extends State<BreathingExerciseScreen> with AutomaticKeepAliveClientMixin {
  // Performance optimization: keep the screen alive when navigating away
  @override
  bool get wantKeepAlive => true;
  
  // Performance optimization: cache services
  late BreathingExerciseService _breathingService;
  late BreathingAudioServiceOptimized _audioService;
  
  // Performance optimization: use keys for efficient rebuilds
  final GlobalKey _playerKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // Get services from provider
    _breathingService = Provider.of<BreathingExerciseService>(context);
    _audioService = Provider.of<BreathingAudioServiceOptimized>(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.exercise.name),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => _confirmExit(context),
          ),
        ),
        body: SafeArea(
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    // Performance optimization: use SingleChildScrollView only when needed
    return LayoutBuilder(
      builder: (context, constraints) {
        final needsScrolling = constraints.maxHeight < 600;
        
        final content = Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Exercise player
              RepaintBoundary(
                key: _playerKey,
                child: BreathingExercisePlayer(
                  exercise: widget.exercise,
                  customPattern: widget.customPattern,
                  duration: widget.duration,
                  onComplete: () => _handleExerciseCompleted(context),
                  audioService: _audioService,
                ),
              ),
            ],
          ),
        );
        
        if (needsScrolling) {
          return SingleChildScrollView(
            child: content,
          );
        } else {
          return Center(child: content);
        }
      },
    );
  }

  Future<bool> _onWillPop() async {
    final shouldPop = await _confirmExit(context);
    return shouldPop ?? false;
  }

  Future<bool?> _confirmExit(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Stop Exercise?'),
        content: const Text('Are you sure you want to stop this breathing exercise?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    ).then((value) {
      if (value == true) {
        Navigator.of(context).pop();
      }
      return value;
    });
  }

  void _handleExerciseCompleted(BuildContext context) {
    // Record the completed session
    final session = BreathingSessionModel.fromExercise(
      exercise: widget.exercise,
      durationSeconds: widget.duration ?? widget.exercise.recommendedDuration,
      pattern: widget.customPattern,
      completed: true,
    );
    
    _breathingService.recordSession(session);
    
    // Show completion dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Great Job!'),
        content: const Text('You completed the breathing exercise.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}