import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'package:quit_vaping/features/breathing/models/breathing_phase.dart';
import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../../data/models/breathing_exercise_model.dart';
import '../models/breathing_phase.dart';

/// Background handler for managing audio playback in background mode
/// Uses audio_service package to provide background audio capabilities
class BreathingBackgroundHandler {
  // Audio service task handler
  late AudioHandler _audioHandler;
  bool _isInitialized = false;
  
  // State management
  final StreamController<BackgroundPlaybackState> _stateController = 
      StreamController<BackgroundPlaybackState>.broadcast();
  
  BackgroundPlaybackState _currentState = BackgroundPlaybackState(
    isPlaying: false,
    currentPhase: BreathingPhase.inhale,
    secondsRemaining: 0,
    elapsedSeconds: 0,
    totalSeconds: 0,
    completedCycles: 0,
  );
  
  // Audio asset paths
  static const String _inhaleAudioPath = 'assets/audio/breathing/inhale.mp3';
  static const String _holdAudioPath = 'assets/audio/breathing/hold.mp3';
  static const String _exhaleAudioPath = 'assets/audio/breathing/exhale.mp3';
  
  /// Initialize background service
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      // Initialize AudioService with the background handler
      _audioHandler = await AudioService.init(
        builder: () => BreathingAudioHandler(),
        config: const AudioServiceConfig(
          androidNotificationChannelId: 'com.quitvaping.breathing',
          androidNotificationChannelName: 'Breathing Exercises',
          androidNotificationOngoing: false,
          androidStopForegroundOnPause: false,
          androidNotificationIcon: 'drawable/ic_breathing',
          notificationColor: Color(0xFF1E88E5),
          androidShowNotificationBadge: true,
        ),
      );
      
      // Listen to playback state changes
      _audioHandler.playbackState.listen((playbackState) {
        final isPlaying = playbackState.playing;
        _updateCurrentState(isPlaying: isPlaying);
      });
      
      _isInitialized = true;
    } catch (e) {
      debugPrint('Error initializing background handler: $e');
      // Rethrow to be handled by the caller
      rethrow;
    }
  }
  
  /// Start background playback
  Future<void> startBackgroundPlayback(
    BreathingExerciseModel exercise,
    BreathingPattern pattern,
    int durationSeconds
  ) async {
    if (!_isInitialized) {
      await initialize();
    }
    
    try {
      // Set media item with exercise details
      await _audioHandler.addQueueItem(
        MediaItem(
          id: 'breathing_exercise_${exercise.id}',
          title: 'Breathing Exercise: ${exercise.name}',
          artist: 'Quit Vaping App',
          duration: Duration(seconds: durationSeconds),
          artUri: Uri.parse('asset:///assets/images/backgrounds/calm_background.jpg'),
          extras: {
            'exerciseId': exercise.id,
            'patternInhale': pattern.inhaleSeconds,
            'patternInhaleHold': pattern.inhaleHoldSeconds,
            'patternExhale': pattern.exhaleSeconds,
            'patternExhaleHold': pattern.exhaleHoldSeconds,
          },
        ),
      );
      
      // Start playback
      await _audioHandler.play();
      
      // Update current state
      _currentState = BackgroundPlaybackState(
        isPlaying: true,
        currentPhase: BreathingPhase.inhale,
        secondsRemaining: pattern.inhaleSeconds,
        elapsedSeconds: 0,
        totalSeconds: durationSeconds,
        completedCycles: 0,
      );
      
      _stateController.add(_currentState);
    } catch (e) {
      debugPrint('Error starting background playback: $e');
      // Rethrow to be handled by the caller
      rethrow;
    }
  }
  
  /// Update background playback state
  Future<void> updateBackgroundState(BreathingPhase phase, int secondsRemaining) async {
    if (!_isInitialized) return;
    
    try {
      // Update the current state
      _updateCurrentState(
        currentPhase: phase,
        secondsRemaining: secondsRemaining,
      );
      
      // Send custom event to the background handler
      await _audioHandler.customAction('updatePhase', {
        'phase': phase.toString(),
        'secondsRemaining': secondsRemaining,
      });
      
      // Play the appropriate audio for the phase
      switch (phase) {
        case BreathingPhase.inhale:
          await _audioHandler.customAction('playAudio', {'path': _inhaleAudioPath});
          break;
        case BreathingPhase.inhaleHold:
        case BreathingPhase.exhaleHold:
          await _audioHandler.customAction('playAudio', {'path': _holdAudioPath});
          break;
        case BreathingPhase.exhale:
          await _audioHandler.customAction('playAudio', {'path': _exhaleAudioPath});
          break;
      }
    } catch (e) {
      debugPrint('Error updating background state: $e');
    }
  }
  
  /// Stop background playback
  Future<void> stopBackgroundPlayback() async {
    if (!_isInitialized) return;
    
    try {
      // Stop playback
      await _audioHandler.stop();
      
      // Update current state
      _updateCurrentState(isPlaying: false);
    } catch (e) {
      debugPrint('Error stopping background playback: $e');
    }
  }
  
  /// Get current background state
  Future<BackgroundPlaybackState?> getCurrentState() async {
    return _currentState;
  }
  
  /// Listen to state changes
  Stream<BackgroundPlaybackState> get stateStream => _stateController.stream;
  
  /// Update the current state and notify listeners
  void _updateCurrentState({
    bool? isPlaying,
    BreathingPhase? currentPhase,
    int? secondsRemaining,
    int? elapsedSeconds,
    int? totalSeconds,
    int? completedCycles,
  }) {
    _currentState = _currentState.copyWith(
      isPlaying: isPlaying ?? _currentState.isPlaying,
      currentPhase: currentPhase ?? _currentState.currentPhase,
      secondsRemaining: secondsRemaining ?? _currentState.secondsRemaining,
      elapsedSeconds: elapsedSeconds ?? _currentState.elapsedSeconds,
      totalSeconds: totalSeconds ?? _currentState.totalSeconds,
      completedCycles: completedCycles ?? _currentState.completedCycles,
    );
    
    _stateController.add(_currentState);
  }
  
  /// Dispose resources
  Future<void> dispose() async {
    if (_isInitialized) {
      await _audioHandler.stop();
    }
    await _stateController.close();
  }
}

/// Audio handler implementation for background audio service
class BreathingAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  // Audio players for different phases
  final AudioPlayer _inhalePlayer = AudioPlayer();
  final AudioPlayer _exhalePlayer = AudioPlayer();
  final AudioPlayer _holdPlayer = AudioPlayer();
  
  // Current active player
  AudioPlayer? _currentPlayer;
  
  // Current phase information
  BreathingPhase _currentPhase = BreathingPhase.inhale;
  int _secondsRemaining = 0;
  int _elapsedSeconds = 0;
  int _completedCycles = 0;
  
  BreathingAudioHandler() {
    // Initialize players
    _initializePlayers();
    
    // Set up custom action handlers
    customEventStream.listen((event) {
      switch (event.name) {
        case 'updatePhase':
          _handleUpdatePhase(event.arguments);
          break;
        case 'playAudio':
          _handlePlayAudio(event.arguments);
          break;
      }
    });
  }
  
  Future<void> _initializePlayers() async {
    try {
      // Load audio assets
      await _inhalePlayer.setAsset('assets/audio/breathing/inhale.mp3');
      await _holdPlayer.setAsset('assets/audio/breathing/hold.mp3');
      await _exhalePlayer.setAsset('assets/audio/breathing/exhale.mp3');
      
      // Set up completion listeners
      _inhalePlayer.processingStateStream.listen(_onAudioProcessingStateChanged);
      _holdPlayer.processingStateStream.listen(_onAudioProcessingStateChanged);
      _exhalePlayer.processingStateStream.listen(_onAudioProcessingStateChanged);
    } catch (e) {
      debugPrint('Error initializing audio players: $e');
    }
  }
  
  void _onAudioProcessingStateChanged(ProcessingState state) {
    switch (state) {
      case ProcessingState.completed:
        // Audio completed, update playback state
        playbackState.add(playbackState.value.copyWith(
          processingState: AudioProcessingState.ready,
        ));
        break;
      case ProcessingState.ready:
        playbackState.add(playbackState.value.copyWith(
          processingState: AudioProcessingState.ready,
        ));
        break;
      case ProcessingState.buffering:
        playbackState.add(playbackState.value.copyWith(
          processingState: AudioProcessingState.buffering,
        ));
        break;
      case ProcessingState.loading:
        playbackState.add(playbackState.value.copyWith(
          processingState: AudioProcessingState.loading,
        ));
        break;
      case ProcessingState.idle:
        // Do nothing
        break;
    }
  }
  
  void _handleUpdatePhase(Map<dynamic, dynamic>? arguments) {
    if (arguments == null) return;
    
    try {
      final phaseStr = arguments['phase'] as String;
      _secondsRemaining = arguments['secondsRemaining'] as int;
      
      // Parse phase from string
      _currentPhase = BreathingPhase.values.firstWhere(
        (p) => p.toString() == phaseStr,
        orElse: () => BreathingPhase.inhale,
      );
      
      // Update media item with phase information
      if (queue.value.isNotEmpty) {
        final currentItem = queue.value.first;
        mediaItem.add(currentItem.copyWith(
          extras: {
            ...?currentItem.extras,
            'currentPhase': _currentPhase.toString(),
            'secondsRemaining': _secondsRemaining,
          },
        ));
      }
    } catch (e) {
      debugPrint('Error handling phase update: $e');
    }
  }
  
  Future<void> _handlePlayAudio(Map<dynamic, dynamic>? arguments) async {
    if (arguments == null) return;
    
    try {
      final path = arguments['path'] as String;
      
      // Determine which player to use
      AudioPlayer? playerToUse;
      if (path.contains('inhale.mp3')) {
        playerToUse = _inhalePlayer;
      } else if (path.contains('hold.mp3')) {
        playerToUse = _holdPlayer;
      } else if (path.contains('exhale.mp3')) {
        playerToUse = _exhalePlayer;
      }
      
      if (playerToUse != null) {
        // Stop current player if different
        if (_currentPlayer != null && _currentPlayer != playerToUse) {
          await _currentPlayer!.stop();
        }
        
        // Play the new audio
        _currentPlayer = playerToUse;
        await _currentPlayer!.seek(Duration.zero);
        await _currentPlayer!.play();
        
        // Update playback state
        playbackState.add(playbackState.value.copyWith(
          playing: true,
          processingState: AudioProcessingState.ready,
        ));
      }
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }
  }
  
  @override
  Future<void> play() async {
    try {
      // Start or resume playback
      if (_currentPlayer != null) {
        await _currentPlayer!.play();
      }
      
      // Update playback state
      playbackState.add(playbackState.value.copyWith(
        playing: true,
        processingState: AudioProcessingState.ready,
      ));
    } catch (e) {
      debugPrint('Error playing audio: $e');
    }
  }
  
  @override
  Future<void> pause() async {
    try {
      // Pause all players
      await _inhalePlayer.pause();
      await _holdPlayer.pause();
      await _exhalePlayer.pause();
      
      // Update playback state
      playbackState.add(playbackState.value.copyWith(
        playing: false,
        processingState: AudioProcessingState.ready,
      ));
    } catch (e) {
      debugPrint('Error pausing audio: $e');
    }
  }
  
  @override
  Future<void> stop() async {
    try {
      // Stop all players
      await _inhalePlayer.stop();
      await _holdPlayer.stop();
      await _exhalePlayer.stop();
      
      _currentPlayer = null;
      
      // Clear queue
      await _clearQueue();
      
      // Update playback state
      playbackState.add(playbackState.value.copyWith(
        playing: false,
        processingState: AudioProcessingState.idle,
      ));
    } catch (e) {
      debugPrint('Error stopping audio: $e');
    }
  }
  
  Future<void> _clearQueue() async {
    try {
      final currentQueue = queue.value;
      for (final item in currentQueue) {
        await removeQueueItem(item);
      }
    } catch (e) {
      debugPrint('Error clearing queue: $e');
    }
  }
  
  @override
  Future<void> onTaskRemoved() async {
    await stop();
    super.onTaskRemoved();
  }
  
  @override
  Future<void> onNotificationDeleted() async {
    await stop();
    super.onNotificationDeleted();
  }
}

/// Background playback state
class BackgroundPlaybackState {
  final bool isPlaying;
  final BreathingPhase currentPhase;
  final int secondsRemaining;
  final int elapsedSeconds;
  final int totalSeconds;
  final int completedCycles;
  
  BackgroundPlaybackState({
    required this.isPlaying,
    required this.currentPhase,
    required this.secondsRemaining,
    required this.elapsedSeconds,
    required this.totalSeconds,
    required this.completedCycles,
  });
  
  BackgroundPlaybackState copyWith({
    bool? isPlaying,
    BreathingPhase? currentPhase,
    int? secondsRemaining,
    int? elapsedSeconds,
    int? totalSeconds,
    int? completedCycles,
  }) {
    return BackgroundPlaybackState(
      isPlaying: isPlaying ?? this.isPlaying,
      currentPhase: currentPhase ?? this.currentPhase,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      completedCycles: completedCycles ?? this.completedCycles,
    );
  }
}