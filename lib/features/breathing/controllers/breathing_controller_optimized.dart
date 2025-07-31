import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'package:quit_vaping/features/breathing/models/breathing_phase.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../../data/models/breathing_exercise_model.dart';
import '../models/breathing_phase.dart';
import '../services/breathing_audio_service_optimized.dart';
import '../services/breathing_state_sync_service.dart';
import '../utils/breathing_accessibility_utils.dart';
import '../widgets/breathing_animation_widget.dart';

/// Optimized controller responsible for synchronizing audio cues with visual breathing guidance.
/// Acts as a bridge between the BreathingAnimationWidget and BreathingAudioServiceOptimized.
/// Adds support for background mode and state synchronization.
class BreathingControllerOptimized {
  /// The audio service for playing breathing cues
  final BreathingAudioServiceOptimized audioService;
  
  /// The state sync service for synchronizing state between UI and background
  final BreathingStateSyncService _stateSyncService;
  
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
  
  /// Callback when background state is restored
  final void Function(BreathingSessionState state)? onBackgroundStateRestored;
  
  // State variables
  BreathingExerciseModel? _exercise;
  BreathingPattern? _pattern;
  bool _isActive = false;
  BreathingPhase? _lastPhase;
  int? _lastSecondsRemaining;
  int _elapsedSeconds = 0;
  int _completedCycles = 0;
  
  // Performance optimization: cache the audio enabled state
  bool _cachedAudioEnabled = true;
  
  // Performance optimization: debounce phase changes
  DateTime _lastPhaseChangeTime = DateTime.now();
  static const _phaseChangeDebounceMs = 200;
  
  // Background state subscription
  StreamSubscription<BreathingSessionState>? _stateSubscription;

  /// Creates a new BreathingControllerOptimized
  BreathingControllerOptimized({
    required this.audioService,
    BreathingStateSyncService? stateSyncService,
    this.onPhaseChanged,
    this.onCycleCompleted,
    this.onPaused,
    this.onResumed,
    this.onStopped,
    this.onBackgroundStateRestored,
  }) : _stateSyncService = stateSyncService ?? BreathingStateSyncService.instance {
    _initializeStateSubscription();
  }
  
  /// Initialize subscription to state changes
  void _initializeStateSubscription() {
    _stateSubscription?.cancel();
    _stateSubscription = _stateSyncService.stateStream.listen(_handleStateChange);
  }
  
  /// Handle state changes from the sync service
  void _handleStateChange(BreathingSessionState state) {
    // Update local state
    _isActive = state.isActive;
    _lastPhase = state.currentPhase;
    _lastSecondsRemaining = state.secondsRemaining;
    _elapsedSeconds = state.elapsedSeconds;
    _completedCycles = state.completedCycles;
    
    // Notify phase change
    if (onPhaseChanged != null) {
      onPhaseChanged!(state.currentPhase, state.secondsRemaining);
    }
    
    // Notify background state restored
    if (onBackgroundStateRestored != null) {
      onBackgroundStateRestored!(state);
    }
  }

  /// Initialize the controller with an exercise and optional custom pattern
  Future<void> initialize(BreathingExerciseModel exercise, [BreathingPattern? customPattern]) async {
    _exercise = exercise;
    _pattern = customPattern ?? exercise.defaultPattern;
    _cachedAudioEnabled = audioService.isAudioEnabled();
    
    await audioService.initializeAudio(exercise, _pattern!);
    
    // Check for active background session
    await _checkForBackgroundSession();
  }
  
  /// Check if there's an active session in the background
  Future<void> _checkForBackgroundSession() async {
    if (await _stateSyncService.isSessionActiveInBackground()) {
      // Restore state from background
      final state = await _stateSyncService.restoreStateFromBackground();
      if (state != null) {
        _isActive = state.isActive;
        _lastPhase = state.currentPhase;
        _lastSecondsRemaining = state.secondsRemaining;
        _elapsedSeconds = state.elapsedSeconds;
        _completedCycles = state.completedCycles;
        
        // Notify background state restored
        if (onBackgroundStateRestored != null) {
          onBackgroundStateRestored!(state);
        }
      }
    }
  }

  /// Start the breathing exercise
  Future<void> start() async {
    _isActive = true;
    
    // Update state sync service
    await _stateSyncService.startSession(
      _exercise!, 
      _pattern!, 
      _exercise!.recommendedDuration
    );
  }

  /// Pause the breathing exercise
  Future<void> pause() async {
    _isActive = false;
    await audioService.pauseAudio();
    
    // Update state sync service
    await _stateSyncService.pauseSession();
    
    if (onPaused != null) {
      onPaused!();
    }
  }

  /// Resume the breathing exercise
  Future<void> resume() async {
    _isActive = true;
    await audioService.resumeAudio();
    
    // Update state sync service
    await _stateSyncService.resumeSession();
    
    if (onResumed != null) {
      onResumed!();
    }
  }

  /// Stop the breathing exercise
  Future<void> stop() async {
    _isActive = false;
    await audioService.stopAudio();
    
    // Update state sync service
    await _stateSyncService.stopSession();
    
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
    
    // Update state sync service
    _stateSyncService.updateState(
      currentPhase: phase,
      secondsRemaining: secondsRemaining,
    );
    
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
    _completedCycles++;
    
    // Update state sync service
    _stateSyncService.updateState(completedCycles: _completedCycles);
    
    if (onCycleCompleted != null) {
      onCycleCompleted!();
    }
  }
  
  /// Update elapsed time
  void updateElapsedTime(int seconds) {
    _elapsedSeconds = seconds;
    
    // Update state sync service
    _stateSyncService.updateState(elapsedSeconds: seconds);
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
  
  /// Toggle background mode
  Future<void> toggleBackgroundMode(bool enabled) async {
    if (enabled) {
      await audioService.enableBackgroundMode();
    } else {
      await audioService.disableBackgroundMode();
    }
  }
  
  /// Check if background mode is enabled
  bool isBackgroundModeEnabled() {
    return audioService.isBackgroundModeEnabled();
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
  
  /// Get the elapsed seconds
  int getElapsedSeconds() {
    return _elapsedSeconds;
  }
  
  /// Get the completed cycles
  int getCompletedCycles() {
    return _completedCycles;
  }
  
  /// Dispose resources
  Future<void> dispose() async {
    await audioService.stopAudio();
    await _stateSubscription?.cancel();
  }
}