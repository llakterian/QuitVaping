import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'package:quit_vaping/features/breathing/models/breathing_phase.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import '../../../data/models/breathing_exercise_model.dart';
import '../controllers/breathing_controller_optimized.dart';
import '../services/breathing_audio_service_optimized.dart';
import '../services/breathing_memory_service.dart';
import '../services/breathing_state_sync_service.dart';
import '../utils/breathing_accessibility_utils.dart';
import '../utils/breathing_memory_optimizer.dart';
import '../utils/breathing_resource_manager.dart';
import '../utils/image_cache_optimizer.dart';
import 'breathing_animation_widget.dart';
import 'breathing_cycle_completion_feedback.dart';
import 'memory_optimized_container.dart';
import 'breathing_pattern_preview.dart';
import 'enhanced_breathing_progress_indicator.dart';

/// An optimized widget that combines visual animation with audio guidance for breathing exercises.
/// Handles synchronization between visual cues and audio feedback with background mode support.
class BreathingExercisePlayerOptimized extends StatefulWidget {
  /// The breathing exercise to play
  final BreathingExerciseModel exercise;
  
  /// Optional custom pattern to use instead of the exercise's default pattern
  final BreathingPattern? customPattern;
  
  /// Optional duration in seconds (defaults to exercise's recommended duration)
  final int? duration;
  
  /// Optional number of cycles to complete (if specified, duration is ignored)
  final int? cyclesToComplete;
  
  /// Callback when the exercise is completed
  final VoidCallback? onComplete;
  
  /// Audio service for playing breathing cues
  final BreathingAudioServiceOptimized audioService;

  /// Creates a new BreathingExercisePlayerOptimized
  const BreathingExercisePlayerOptimized({
    Key? key,
    required this.exercise,
    this.customPattern,
    this.duration,
    this.cyclesToComplete,
    this.onComplete,
    required this.audioService,
  }) : super(key: key);

  @override
  State<BreathingExercisePlayerOptimized> createState() => _BreathingExercisePlayerOptimizedState();
}

class _BreathingExercisePlayerOptimizedState extends State<BreathingExercisePlayerOptimized> with SingleTickerProviderStateMixin {
  late BreathingControllerOptimized _controller;
  bool _isPlaying = false;
  int _elapsedSeconds = 0;
  int _totalSeconds = 0;
  int _completedCycles = 0;
  Timer? _timer;
  
  // Current phase tracking
  BreathingPhase _currentPhase = BreathingPhase.inhale;
  int _secondsRemaining = 0;
  int _totalPhaseSeconds = 0;
  
  // Cycle completion feedback
  bool _showCycleCompletionFeedback = false;
  
  // Performance optimization: use a single animation controller for progress
  late AnimationController _progressController;
  
  // Performance optimization: use keys for efficient rebuilds
  final GlobalKey _animationKey = GlobalKey();
  final GlobalKey _controlsKey = GlobalKey();
  final GlobalKey _progressKey = GlobalKey();
  final GlobalKey _enhancedProgressKey = GlobalKey();
  final GlobalKey _cycleCompletionKey = GlobalKey();
  
  // Performance optimization: cache values
  bool _cachedAudioEnabled = true;
  double _cachedVolume = 1.0;
  bool _cachedBackgroundModeEnabled = false;
  
  // Pattern preview
  bool _showPatternPreview = false;

  @override
  void initState() {
    super.initState();
    
    // Initialize memory optimization services
    _initializeMemoryOptimization();
    
    // Initialize the controller
    _controller = BreathingControllerOptimized(
      audioService: widget.audioService,
      onPhaseChanged: _handlePhaseChanged,
      onCycleCompleted: _handleCycleCompleted,
      onPaused: _handlePaused,
      onResumed: _handleResumed,
      onStopped: _handleStopped,
      onBackgroundStateRestored: _handleBackgroundStateRestored,
    );
    
    // Initialize the progress controller
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    // Set up the exercise
    _setupExercise();
  }
  
  /// Initialize memory optimization components
  Future<void> _initializeMemoryOptimization() async {
    // Initialize the memory service
    await BreathingMemoryService.instance.initialize();
    
    // Register resources with the resource manager
    BreathingResourceManager.instance.registerResource(
      'breathing_exercise_${widget.exercise.id}',
      priority: 10, // High priority for current exercise
    );
    
    // Listen for memory warnings
    BreathingMemoryService.instance.addMemoryWarningListener(_handleMemoryWarning);
  }
  
  /// Handle memory warnings
  void _handleMemoryWarning() {
    // Clean up non-essential resources when memory is low
    if (!_isPlaying) {
      // Only clean up if not actively playing
      BreathingResourceManager.instance.releaseUnusedResources();
    }
  }

  @override
  void didUpdateWidget(BreathingExercisePlayerOptimized oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Handle exercise or pattern changes
    if (oldWidget.exercise != widget.exercise || 
        oldWidget.customPattern != widget.customPattern ||
        oldWidget.duration != widget.duration ||
        oldWidget.cyclesToComplete != widget.cyclesToComplete) {
      _setupExercise();
    }
  }

  @override
  void dispose() {
    _stopTimer();
    _controller.dispose();
    _progressController.dispose();
    
    // Clean up memory optimization resources
    BreathingMemoryService.instance.removeMemoryWarningListener(_handleMemoryWarning);
    BreathingResourceManager.instance.unregisterResource('breathing_exercise_${widget.exercise.id}');
    
    // Trigger cleanup of unused resources
    BreathingResourceManager.instance.releaseUnusedResources();
    
    super.dispose();
  }

  Future<void> _setupExercise() async {
    // Initialize the controller with the exercise and pattern
    await _controller.initialize(
      widget.exercise,
      widget.customPattern,
    );
    
    // Set up duration
    _totalSeconds = widget.duration ?? widget.exercise.recommendedDuration;
    _elapsedSeconds = 0;
    _completedCycles = 0;
    
    // Cache audio state
    _cachedAudioEnabled = _controller.isAudioEnabled();
    _cachedVolume = _controller.getVolume();
    _cachedBackgroundModeEnabled = _controller.isBackgroundModeEnabled();
    
    // Update the UI
    if (mounted) {
      setState(() {});
    }
  }
  
  /// Handle background state restoration
  void _handleBackgroundStateRestored(BreathingSessionState state) {
    if (!mounted) return;
    
    setState(() {
      _isPlaying = state.isActive;
      _elapsedSeconds = state.elapsedSeconds;
      _completedCycles = state.completedCycles;
      
      // Start timer if playing
      if (_isPlaying) {
        _startTimer();
      }
    });
    
    // Show a snackbar to inform the user
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Breathing exercise restored from background'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _startExercise() {
    _controller.start();
    _startTimer();
    
    setState(() {
      _isPlaying = true;
    });
  }

  void _pauseExercise() {
    _controller.pause();
    _stopTimer();
    
    setState(() {
      _isPlaying = false;
    });
  }

  void _resumeExercise() {
    _controller.resume();
    _startTimer();
    
    setState(() {
      _isPlaying = true;
    });
  }

  void _stopExercise() {
    _controller.stop();
    _stopTimer();
    
    setState(() {
      _isPlaying = false;
      _elapsedSeconds = 0;
    });
  }

  void _startTimer() {
    _stopTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), _onTimerTick);
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _onTimerTick(Timer timer) {
    if (!mounted) return;
    
    setState(() {
      _elapsedSeconds++;
      
      // Update controller with elapsed time
      _controller.updateElapsedTime(_elapsedSeconds);
      
      // Check if the exercise is complete based on duration
      if (widget.cyclesToComplete == null && _elapsedSeconds >= _totalSeconds) {
        _completeExercise();
      }
    });
  }

  void _completeExercise() {
    _stopExercise();
    
    if (widget.onComplete != null) {
      widget.onComplete!();
    }
  }

  void _handlePhaseChanged(BreathingPhase phase, int secondsRemaining) {
    if (!mounted) return;
    
    // Update the current phase and seconds remaining
    setState(() {
      _currentPhase = phase;
      _secondsRemaining = secondsRemaining;
      
      // Set the total phase seconds based on the current pattern
      final pattern = widget.customPattern ?? widget.exercise.defaultPattern;
      switch (phase) {
        case BreathingPhase.inhale:
          _totalPhaseSeconds = pattern.inhaleSeconds;
          break;
        case BreathingPhase.inhaleHold:
          _totalPhaseSeconds = pattern.inhaleHoldSeconds;
          break;
        case BreathingPhase.exhale:
          _totalPhaseSeconds = pattern.exhaleSeconds;
          break;
        case BreathingPhase.exhaleHold:
          _totalPhaseSeconds = pattern.exhaleHoldSeconds;
          break;
      }
    });
  }

  void _handleCycleCompleted() {
    if (!mounted) return;
    
    setState(() {
      _completedCycles++;
      _showCycleCompletionFeedback = true;
      
      // Check if the exercise is complete based on cycles
      if (widget.cyclesToComplete != null && _completedCycles >= widget.cyclesToComplete!) {
        _completeExercise();
      }
    });
    
    // Hide the feedback after animation completes
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _showCycleCompletionFeedback = false;
        });
      }
    });
  }

  void _handlePaused() {
    if (!mounted) return;
    
    setState(() {
      _isPlaying = false;
    });
  }

  void _handleResumed() {
    if (!mounted) return;
    
    setState(() {
      _isPlaying = true;
    });
  }

  void _handleStopped() {
    if (!mounted) return;
    
    setState(() {
      _isPlaying = false;
      _elapsedSeconds = 0;
    });
  }

  Future<void> _toggleAudio() async {
    final newState = !_cachedAudioEnabled;
    await _controller.toggleAudio(newState);
    
    setState(() {
      _cachedAudioEnabled = newState;
    });
  }
  
  Future<void> _toggleBackgroundMode() async {
    final newState = !_cachedBackgroundModeEnabled;
    await _controller.toggleBackgroundMode(newState);
    
    setState(() {
      _cachedBackgroundModeEnabled = newState;
    });
    
    // Show a snackbar to inform the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          newState 
            ? 'Background mode enabled. Exercise will continue when app is in background.' 
            : 'Background mode disabled'
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Toggle pattern preview visibility
  void _togglePatternPreview() {
    setState(() {
      _showPatternPreview = !_showPatternPreview;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pattern = widget.customPattern ?? widget.exercise.defaultPattern;
    
    return MemoryOptimizedContainer(
      autoCleanup: true,
      showDebugInfo: false, // Set to true for debugging memory issues
      onLeakDetected: (leakInfo) {
        // Log memory leak information
        debugPrint('Memory leak detected: $leakInfo');
      },
      child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Exercise name
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.exercise.name,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(width: 8),
              // Pattern preview toggle button
              IconButton(
                onPressed: _togglePatternPreview,
                icon: Icon(
                  _showPatternPreview ? Icons.visibility_off : Icons.visibility,
                  size: 24,
                ),
                tooltip: _showPatternPreview ? 'Hide pattern preview' : 'Show pattern preview',
              ),
            ],
          ),
        ),
        
        // Pattern preview (if enabled)
        if (_showPatternPreview)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: BreathingPatternPreview(
              pattern: pattern,
              size: 150,
              autoAnimate: true,
              speedMultiplier: 2.0,
              useHapticFeedback: false,
            ),
          ),
        
        // Animation with enhanced progress indicators
        Stack(
          alignment: Alignment.center,
          children: [
            // Main breathing animation
            RepaintBoundary(
              key: _animationKey,
              child: BreathingAnimationWidget(
                pattern: pattern,
                isPlaying: _isPlaying,
                size: 200,
                onPhaseChanged: _controller.handlePhaseChange,
                onCycleCompleted: _controller.handleCycleCompleted,
              ),
            ),
            
            // Cycle completion feedback overlay
            RepaintBoundary(
              key: _cycleCompletionKey,
              child: BreathingCycleCompletionFeedback(
                show: _showCycleCompletionFeedback,
                size: 220,
                color: Theme.of(context).primaryColor,
                useHapticFeedback: true,
                onAnimationComplete: () {
                  if (mounted) {
                    setState(() {
                      _showCycleCompletionFeedback = false;
                    });
                  }
                },
              ),
            ),
            
            // Enhanced progress indicators positioned around the main animation
            Positioned(
              top: 0,
              child: RepaintBoundary(
                key: _enhancedProgressKey,
                child: EnhancedBreathingProgressIndicator(
                  currentPhase: _currentPhase,
                  secondsRemaining: _secondsRemaining,
                  totalPhaseSeconds: _totalPhaseSeconds,
                  size: 60,
                  useHapticFeedback: true,
                ),
              ),
            ),
            
            // Left side indicator
            Positioned(
              left: 0,
              child: RepaintBoundary(
                child: EnhancedBreathingProgressIndicator(
                  currentPhase: _currentPhase,
                  secondsRemaining: _secondsRemaining,
                  totalPhaseSeconds: _totalPhaseSeconds,
                  size: 40,
                  showCountdown: false,
                  useHapticFeedback: false,
                ),
              ),
            ),
            
            // Right side indicator
            Positioned(
              right: 0,
              child: RepaintBoundary(
                child: EnhancedBreathingProgressIndicator(
                  currentPhase: _currentPhase,
                  secondsRemaining: _secondsRemaining,
                  totalPhaseSeconds: _totalPhaseSeconds,
                  size: 40,
                  showCountdown: false,
                  useHapticFeedback: false,
                ),
              ),
            ),
          ],
        ),
        
        // Breathing cycle indicator
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: BreathingCycleIndicator(
            currentPhase: _currentPhase,
            phaseDurations: {
              BreathingPhase.inhale: pattern.inhaleSeconds,
              BreathingPhase.inhaleHold: pattern.inhaleHoldSeconds,
              BreathingPhase.exhale: pattern.exhaleSeconds,
              BreathingPhase.exhaleHold: pattern.exhaleHoldSeconds,
            },
            indicatorSize: 12,
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Progress indicator
        if (widget.cyclesToComplete == null)
          RepaintBoundary(
            key: _progressKey,
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: _totalSeconds > 0 ? _elapsedSeconds / _totalSeconds : 0,
                  minHeight: 8,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${_formatTime(_totalSeconds - _elapsedSeconds)} remaining',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          )
        else
          Text(
            'Cycles: $_completedCycles / ${widget.cyclesToComplete}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        
        const SizedBox(height: 24),
        
        // Controls
        RepaintBoundary(
          key: _controlsKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Play/Pause button
                  ElevatedButton(
                    onPressed: _isPlaying ? _pauseExercise : _startExercise,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(16),
                    ),
                    child: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 32,
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Stop button
                  ElevatedButton(
                    onPressed: _stopExercise,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Colors.red,
                    ),
                    child: const Icon(
                      Icons.stop,
                      size: 32,
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Audio toggle button
                  IconButton(
                    onPressed: _toggleAudio,
                    icon: Icon(
                      _cachedAudioEnabled ? Icons.volume_up : Icons.volume_off,
                      size: 32,
                    ),
                    tooltip: _cachedAudioEnabled ? 'Mute' : 'Unmute',
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Background mode toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Background Mode'),
                  const SizedBox(width: 8),
                  Switch(
                    value: _cachedBackgroundModeEnabled,
                    onChanged: (value) => _toggleBackgroundMode(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}