import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'package:quit_vaping/features/breathing/models/breathing_phase.dart';
import 'package:flutter/foundation.dart';
import '../../../data/models/breathing_exercise_model.dart';
import '../models/breathing_phase.dart';
import '../services/breathing_audio_service.dart';
import '../utils/breathing_accessibility_utils.dart';

/// Controller responsible for synchronizing audio cues with visual breathing guidance.
/// Acts as a bridge between the BreathingAnimationWidget and BreathingAudioService.
class BreathingController extends ChangeNotifier {
  /// The audio service for playing breathing cues
  final BreathingAudioService audioService;
  
  /// Callback when a phase changes
  final void Function(BreathingPhase phase, int secondsRemaining)? onPhaseChanged;
  
  /// Callback when a cycle completes
  final VoidCallback? onCycleCompleted;
  
  /// Callback when the controller is paused
  final VoidCallback? onPaused;
  
  /// Callback when the controller is resumed
  final VoidCallback? onResumed;
  
  /// Callback when the controller is stopped
  final VoidCallback? onStopped;
  
  // State variables
  BreathingExerciseModel? _exercise;
  BreathingPattern? _pattern;
  bool _isActive = false;
  BreathingPhase? _lastPhase;
  int? _lastSecondsRemaining;
  
  // Additional state variables needed for compatibility
  BreathingPhase _currentPhase = BreathingPhase.inhale;
  bool _isPlaying = false;
  int _secondsRemaining = 300; // Default 5 minutes
  int _elapsedSeconds = 0;
  int _completedCycles = 0;
  double _phaseProgress = 0.0;
  double _totalProgress = 0.0;
  int _phaseSecondsRemaining = 0;
  
  // Performance optimization: cache the audio enabled state
  bool _cachedAudioEnabled = true;
  
  // Performance optimization: debounce phase changes
  DateTime _lastPhaseChangeTime = DateTime.now();
  static const _phaseChangeDebounceMs = 200;

  /// Creates a new BreathingController
  BreathingController({
    required this.audioService,
    this.onPhaseChanged,
    this.onCycleCompleted,
    this.onPaused,
    this.onResumed,
    this.onStopped,
  });

  /// Initialize the controller with an exercise and optional custom pattern
  Future<void> initialize(BreathingExerciseModel exercise, [BreathingPattern? customPattern]) async {
    _exercise = exercise;
    _pattern = customPattern ?? exercise.defaultPattern;
    _cachedAudioEnabled = audioService.isAudioEnabled();
    
    await audioService.initializeAudio(exercise, _pattern!);
  }

  /// Start the breathing exercise
  Future<void> start() async {
    _isActive = true;
  }

  /// Pause the breathing exercise
  Future<void> pause() async {
    _isActive = false;
    await audioService.pauseAudio();
    
    if (onPaused != null) {
      onPaused!();
    }
  }

  /// Resume the breathing exercise
  Future<void> resume() async {
    _isActive = true;
    await audioService.resumeAudio();
    
    if (onResumed != null) {
      onResumed!();
    }
  }

  /// Stop the breathing exercise
  Future<void> stop() async {
    _isActive = false;
    await audioService.stopAudio();
    
    if (onStopped != null) {
      onStopped!();
    }
  }

  /// Handle phase changes from the animation widget
  Future<void> handlePhaseChange(BreathingPhase phase, int secondsRemaining) async {
    // Performance optimization: debounce rapid phase changes
    final now = DateTime.now();
    if (now.difference(_lastPhaseChangeTime).inMilliseconds < _phaseChangeDebounceMs) {
      return;
    }
    _lastPhaseChangeTime = now;
    
    // Only play audio at the start of a phase
    final isPhaseStart = phase != _lastPhase || secondsRemaining != (_lastSecondsRemaining ?? 0) - 1;
    _lastPhase = phase;
    _lastSecondsRemaining = secondsRemaining;
    
    // Notify phase change
    if (onPhaseChanged != null) {
      onPhaseChanged!(phase, secondsRemaining);
    }
    
    // Skip audio if not active or audio disabled
    if (!_isActive || !_cachedAudioEnabled) return;
    
    // Only play audio at the start of a phase
    if (!isPhaseStart) return;
    
    // Play the appropriate audio for the phase
    switch (phase) {
      case BreathingPhase.inhale:
        await audioService.playInhaleAudio();
        break;
      case BreathingPhase.inhaleHold:
      case BreathingPhase.exhaleHold:
        await audioService.playHoldAudio();
        break;
      case BreathingPhase.exhale:
        await audioService.playExhaleAudio();
        break;
    }
    
    // Provide haptic feedback for accessibility
    BreathingAccessibilityUtils.provideHapticFeedback(phase);
  }

  /// Handle cycle completion from the animation widget
  void handleCycleCompleted() {
    if (onCycleCompleted != null) {
      onCycleCompleted!();
    }
  }

  /// Toggle audio enabled state
  Future<void> toggleAudio(bool enabled) async {
    await audioService.toggleAudio(enabled);
    _cachedAudioEnabled = enabled;
  }

  /// Set audio volume
  Future<void> setVolume(double volume) async {
    await audioService.setVolume(volume);
  }

  /// Check if audio is enabled
  bool isAudioEnabled() {
    return _cachedAudioEnabled;
  }

  /// Get audio volume
  double getVolume() {
    return audioService.getVolume();
  }

  /// Check if the controller is active
  bool isActive() {
    return _isActive;
  }

  /// Get the current exercise
  BreathingExerciseModel? getExercise() {
    return _exercise;
  }

  /// Get the current pattern
  BreathingPattern? getPattern() {
    return _pattern;
  }
  
  /// Get the current pattern - property accessor for compatibility
  BreathingPattern? get pattern => _pattern;
  
  /// Get the current phase - property accessor for compatibility
  BreathingPhase get currentPhase => _currentPhase;
  
  /// Get whether the exercise is playing - property accessor for compatibility
  bool get isPlaying => _isPlaying;
  
  /// Get the seconds remaining - property accessor for compatibility
  int get secondsRemaining => _secondsRemaining;
  
  /// Get the elapsed seconds - property accessor for compatibility
  int get elapsedSeconds => _elapsedSeconds;
  
  /// Get the completed cycles - property accessor for compatibility
  int get completedCycles => _completedCycles;
  
  /// Get the phase progress - property accessor for compatibility
  double get phaseProgress => _phaseProgress;
  
  /// Get the total progress - property accessor for compatibility
  double get totalProgress => _totalProgress;
  
  /// Get the phase seconds remaining - property accessor for compatibility
  int get phaseSecondsRemaining => _phaseSecondsRemaining;
  
  /// Set the pattern - method for compatibility
  Future<void> setPattern(BreathingPattern newPattern) async {
    _pattern = newPattern;
    notifyListeners();
  }
  
  /// Set the duration - method for compatibility
  Future<void> setDuration(int seconds) async {
    _secondsRemaining = seconds;
    notifyListeners();
  }
  
  /// Reset the controller - method for compatibility
  Future<void> reset() async {
    _elapsedSeconds = 0;
    _completedCycles = 0;
    _phaseProgress = 0.0;
    _totalProgress = 0.0;
    _currentPhase = BreathingPhase.inhale;
    notifyListeners();
  }
  
  /// Dispose resources
  @override
  Future<void> dispose() async {
    await audioService.stopAudio();
    super.dispose();
  }
}