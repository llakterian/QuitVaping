import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'package:quit_vaping/features/breathing/models/breathing_phase.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../../data/models/breathing_exercise_model.dart';
import '../models/breathing_phase.dart';
import '../widgets/breathing_animation_widget.dart';
import 'breathing_audio_service_optimized.dart';
import 'breathing_background_handler.dart';

/// Service responsible for synchronizing state between the UI and background service
/// Ensures seamless transition when returning to the app from background
class BreathingStateSyncService {
  // Singleton instance
  static final BreathingStateSyncService _instance = BreathingStateSyncService._();
  static BreathingStateSyncService get instance => _instance;
  
  // Audio service reference
  final BreathingAudioServiceOptimized _audioService = BreathingAudioServiceOptimized.instance;
  
  // State management
  final StreamController<BreathingSessionState> _stateController = 
      StreamController<BreathingSessionState>.broadcast();
  
  // Current state
  BreathingSessionState _currentState = BreathingSessionState(
    isActive: false,
    currentPhase: BreathingPhase.inhale,
    secondsRemaining: 0,
    elapsedSeconds: 0,
    totalSeconds: 0,
    completedCycles: 0,
    pattern: null,
    exercise: null,
  );
  
  // Subscriptions
  StreamSubscription<BackgroundPlaybackState>? _backgroundStateSubscription;
  
  // Private constructor for singleton
  BreathingStateSyncService._() {
    _initializeSubscriptions();
  }
  
  /// Initialize subscriptions to state changes
  void _initializeSubscriptions() {
    // Listen to background state changes
    _backgroundStateSubscription?.cancel();
    _backgroundStateSubscription = _audioService.backgroundStateStream.listen(_handleBackgroundStateChange);
  }
  
  /// Handle background state changes
  void _handleBackgroundStateChange(BackgroundPlaybackState state) {
    // Update current state from background
    _currentState = _currentState.copyWith(
      isActive: state.isPlaying,
      currentPhase: state.currentPhase,
      secondsRemaining: state.secondsRemaining,
      elapsedSeconds: state.elapsedSeconds,
      totalSeconds: state.totalSeconds,
      completedCycles: state.completedCycles,
    );
    
    // Notify listeners
    _stateController.add(_currentState);
  }
  
  /// Update state from UI
  void updateState({
    bool? isActive,
    BreathingPhase? currentPhase,
    int? secondsRemaining,
    int? elapsedSeconds,
    int? totalSeconds,
    int? completedCycles,
    BreathingPattern? pattern,
    BreathingExerciseModel? exercise,
  }) {
    // Update current state
    _currentState = _currentState.copyWith(
      isActive: isActive ?? _currentState.isActive,
      currentPhase: currentPhase ?? _currentState.currentPhase,
      secondsRemaining: secondsRemaining ?? _currentState.secondsRemaining,
      elapsedSeconds: elapsedSeconds ?? _currentState.elapsedSeconds,
      totalSeconds: totalSeconds ?? _currentState.totalSeconds,
      completedCycles: completedCycles ?? _currentState.completedCycles,
      pattern: pattern ?? _currentState.pattern,
      exercise: exercise ?? _currentState.exercise,
    );
    
    // Notify listeners
    _stateController.add(_currentState);
  }
  
  /// Start a new breathing session
  Future<void> startSession(BreathingExerciseModel exercise, BreathingPattern pattern, int duration) async {
    // Update state
    updateState(
      isActive: true,
      currentPhase: BreathingPhase.inhale,
      secondsRemaining: pattern.inhaleSeconds,
      elapsedSeconds: 0,
      totalSeconds: duration,
      completedCycles: 0,
      pattern: pattern,
      exercise: exercise,
    );
    
    // Start background playback if enabled
    if (_audioService.isBackgroundModeEnabled()) {
      await _audioService.enableBackgroundMode();
    }
  }
  
  /// Pause the current session
  Future<void> pauseSession() async {
    updateState(isActive: false);
  }
  
  /// Resume the current session
  Future<void> resumeSession() async {
    updateState(isActive: true);
  }
  
  /// Stop the current session
  Future<void> stopSession() async {
    updateState(
      isActive: false,
      elapsedSeconds: 0,
      completedCycles: 0,
    );
  }
  
  /// Get the current state
  BreathingSessionState getCurrentState() {
    return _currentState;
  }
  
  /// Listen to state changes
  Stream<BreathingSessionState> get stateStream => _stateController.stream;
  
  /// Check if a session is active in the background
  Future<bool> isSessionActiveInBackground() async {
    if (!_audioService.isBackgroundModeEnabled()) {
      return false;
    }
    
    try {
      final state = await _audioService._backgroundHandler?.getCurrentState();
      return state?.isPlaying ?? false;
    } catch (e) {
      debugPrint('Error checking background session: $e');
      return false;
    }
  }
  
  /// Restore state from background
  Future<BreathingSessionState?> restoreStateFromBackground() async {
    if (!_audioService.isBackgroundModeEnabled()) {
      return null;
    }
    
    try {
      final state = await _audioService._backgroundHandler?.getCurrentState();
      if (state != null && state.isPlaying) {
        // Update current state
        _currentState = _currentState.copyWith(
          isActive: state.isPlaying,
          currentPhase: state.currentPhase,
          secondsRemaining: state.secondsRemaining,
          elapsedSeconds: state.elapsedSeconds,
          totalSeconds: state.totalSeconds,
          completedCycles: state.completedCycles,
        );
        
        // Notify listeners
        _stateController.add(_currentState);
        
        return _currentState;
      }
    } catch (e) {
      debugPrint('Error restoring state from background: $e');
    }
    
    return null;
  }
  
  /// Dispose resources
  Future<void> dispose() async {
    await _backgroundStateSubscription?.cancel();
    await _stateController.close();
  }
}

/// Breathing session state
class BreathingSessionState {
  final bool isActive;
  final BreathingPhase currentPhase;
  final int secondsRemaining;
  final int elapsedSeconds;
  final int totalSeconds;
  final int completedCycles;
  final BreathingPattern? pattern;
  final BreathingExerciseModel? exercise;
  
  BreathingSessionState({
    required this.isActive,
    required this.currentPhase,
    required this.secondsRemaining,
    required this.elapsedSeconds,
    required this.totalSeconds,
    required this.completedCycles,
    required this.pattern,
    required this.exercise,
  });
  
  BreathingSessionState copyWith({
    bool? isActive,
    BreathingPhase? currentPhase,
    int? secondsRemaining,
    int? elapsedSeconds,
    int? totalSeconds,
    int? completedCycles,
    BreathingPattern? pattern,
    BreathingExerciseModel? exercise,
  }) {
    return BreathingSessionState(
      isActive: isActive ?? this.isActive,
      currentPhase: currentPhase ?? this.currentPhase,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      completedCycles: completedCycles ?? this.completedCycles,
      pattern: pattern ?? this.pattern,
      exercise: exercise ?? this.exercise,
    );
  }
}