import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'dart:async';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/breathing_exercise_model.dart';

/// Service responsible for managing audio guidance during breathing exercises.
/// Provides methods for initializing, controlling, and customizing audio playback.
class BreathingAudioService {
  // Constants for shared preferences keys
  static const String _audioEnabledKey = 'breathing_audio_enabled';
  static const String _audioVolumeKey = 'breathing_audio_volume';
  
  // Audio players for different phases
  AudioPlayer? _inhalePlayer;
  AudioPlayer? _holdPlayer;
  AudioPlayer? _exhalePlayer;
  
  // Audio asset paths
  static const String _inhaleAudioPath = 'assets/audio/breathing/inhale.mp3';
  static const String _holdAudioPath = 'assets/audio/breathing/hold.mp3';
  static const String _exhaleAudioPath = 'assets/audio/breathing/exhale.mp3';
  
  // Audio state
  bool _isAudioEnabled = true;
  double _volume = 1.0;
  bool _isInitialized = false;
  
  // Resource management
  final Set<AudioPlayer> _activePlayers = {};
  Timer? _resourceCleanupTimer;
  
  // Audio loading state
  final Completer<void> _audioLoadCompleter = Completer<void>();
  bool get isAudioLoaded => _audioLoadCompleter.isCompleted;
  
  /// Simple initialize method for compatibility
  Future<void> initialize() async {
    // Load preferences
    await _loadPreferences();
    
    // Create new players
    _inhalePlayer = AudioPlayer();
    _holdPlayer = AudioPlayer();
    _exhalePlayer = AudioPlayer();
    
    // Load audio assets in parallel for better performance
    try {
      await Future.wait([
        _loadAudioAsset(_inhalePlayer!, _inhaleAudioPath),
        _loadAudioAsset(_holdPlayer!, _holdAudioPath),
        _loadAudioAsset(_exhalePlayer!, _exhaleAudioPath),
      ]);
      
      // Set volume for all players
      await Future.wait([
        _inhalePlayer!.setVolume(_volume),
        _holdPlayer!.setVolume(_volume),
        _holdPlayer!.setVolume(_volume),
      ]);
      
      _isInitialized = true;
      
      if (!_audioLoadCompleter.isCompleted) {
        _audioLoadCompleter.complete();
      }
    } catch (e) {
      print('Error initializing audio: $e');
      if (!_audioLoadCompleter.isCompleted) {
        _audioLoadCompleter.complete();
      }
    }
  }
  
  /// Initialize audio for a specific exercise and pattern
  Future<void> initializeAudio(BreathingExerciseModel exercise, BreathingPattern pattern) async {
    // Load preferences first
    await _loadPreferences();
    
    // Clean up existing players
    await _cleanupPlayers();
    
    // Create new players
    _inhalePlayer = AudioPlayer();
    _holdPlayer = AudioPlayer();
    _exhalePlayer = AudioPlayer();
    
    // Load audio assets in parallel for better performance
    try {
      await Future.wait([
        _loadAudioAsset(_inhalePlayer!, _inhaleAudioPath),
        _loadAudioAsset(_holdPlayer!, _holdAudioPath),
        _loadAudioAsset(_exhalePlayer!, _exhaleAudioPath),
      ]);
      
      // Set volume for all players
      await Future.wait([
        _inhalePlayer!.setVolume(_volume),
        _holdPlayer!.setVolume(_volume),
        _exhalePlayer!.setVolume(_volume),
      ]);
      
      _isInitialized = true;
      
      if (!_audioLoadCompleter.isCompleted) {
        _audioLoadCompleter.complete();
      }
    } catch (e) {
      print('Error initializing audio: $e');
      // Complete the completer even if there's an error to avoid blocking
      if (!_audioLoadCompleter.isCompleted) {
        _audioLoadCompleter.complete();
      }
    }
  }
  
  /// Load an audio asset with error handling
  Future<void> _loadAudioAsset(AudioPlayer player, String assetPath) async {
    try {
      await player.setAsset(assetPath);
    } catch (e) {
      print('Error loading audio asset $assetPath: $e');
      // Rethrow to be caught by the caller
      rethrow;
    }
  }
  
  /// Load user preferences
  Future<void> _loadPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isAudioEnabled = prefs.getBool(_audioEnabledKey) ?? true;
      _volume = prefs.getDouble(_audioVolumeKey) ?? 1.0;
    } catch (e) {
      print('Error loading audio preferences: $e');
      // Use defaults if preferences can't be loaded
      _isAudioEnabled = true;
      _volume = 1.0;
    }
  }
  
  /// Clean up existing audio players
  Future<void> _cleanupPlayers() async {
    // Stop and dispose all active players
    for (final player in _activePlayers) {
      try {
        await player.stop();
        await player.dispose();
      } catch (e) {
        print('Error disposing audio player: $e');
      }
    }
    _activePlayers.clear();
    
    // Dispose existing players
    await _inhalePlayer?.dispose();
    await _holdPlayer?.dispose();
    await _exhalePlayer?.dispose();
    
    _inhalePlayer = null;
    _holdPlayer = null;
    _exhalePlayer = null;
  }
  
  /// Play inhale audio
  Future<void> playInhaleAudio() async {
    if (!_isAudioEnabled || !_isInitialized || _inhalePlayer == null) return;
    
    try {
      await _inhalePlayer!.seek(Duration.zero);
      await _inhalePlayer!.play();
      _activePlayers.add(_inhalePlayer!);
      _scheduleResourceCleanup();
    } catch (e) {
      print('Error playing inhale audio: $e');
    }
  }
  
  /// Play inhale - shorthand method for compatibility
  Future<void> playInhale() => playInhaleAudio();
  
  /// Play hold audio
  Future<void> playHoldAudio() async {
    if (!_isAudioEnabled || !_isInitialized || _holdPlayer == null) return;
    
    try {
      await _holdPlayer!.seek(Duration.zero);
      await _holdPlayer!.play();
      _activePlayers.add(_holdPlayer!);
      _scheduleResourceCleanup();
    } catch (e) {
      print('Error playing hold audio: $e');
    }
  }
  
  /// Play hold - shorthand method for compatibility
  Future<void> playHold() => playHoldAudio();
  
  /// Play exhale audio
  Future<void> playExhaleAudio() async {
    if (!_isAudioEnabled || !_isInitialized || _exhalePlayer == null) return;
    
    try {
      await _exhalePlayer!.seek(Duration.zero);
      await _exhalePlayer!.play();
      _activePlayers.add(_exhalePlayer!);
      _scheduleResourceCleanup();
    } catch (e) {
      print('Error playing exhale audio: $e');
    }
  }
  
  /// Play exhale - shorthand method for compatibility
  Future<void> playExhale() => playExhaleAudio();
  
  /// Pause all audio
  Future<void> pauseAudio() async {
    if (!_isInitialized) return;
    
    try {
      for (final player in _activePlayers) {
        await player.pause();
      }
    } catch (e) {
      print('Error pausing audio: $e');
    }
  }
  
  /// Resume audio
  Future<void> resumeAudio() async {
    if (!_isAudioEnabled || !_isInitialized) return;
    
    try {
      for (final player in _activePlayers) {
        await player.play();
      }
    } catch (e) {
      print('Error resuming audio: $e');
    }
  }
  
  /// Stop all audio
  Future<void> stopAudio() async {
    if (!_isInitialized) return;
    
    try {
      for (final player in _activePlayers) {
        await player.stop();
      }
      _activePlayers.clear();
    } catch (e) {
      print('Error stopping audio: $e');
    }
  }
  
  /// Toggle audio enabled state
  Future<void> toggleAudio(bool enabled) async {
    _isAudioEnabled = enabled;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_audioEnabledKey, enabled);
      
      if (!enabled) {
        await stopAudio();
      }
    } catch (e) {
      print('Error toggling audio: $e');
    }
  }
  
  /// Set audio volume
  Future<void> setVolume(double volume) async {
    if (volume < 0 || volume > 1) {
      throw ArgumentError('Volume must be between 0 and 1');
    }
    
    _volume = volume;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_audioVolumeKey, volume);
      
      if (_isInitialized) {
        await Future.wait([
          _inhalePlayer?.setVolume(volume) ?? Future.value(),
          _holdPlayer?.setVolume(volume) ?? Future.value(),
          _exhalePlayer?.setVolume(volume) ?? Future.value(),
        ]);
      }
    } catch (e) {
      print('Error setting volume: $e');
    }
  }
  
  /// Check if audio is enabled
  bool isAudioEnabled() {
    return _isAudioEnabled;
  }
  
  /// Get current volume
  double getVolume() {
    return _volume;
  }
  
  /// Schedule resource cleanup to free memory
  void _scheduleResourceCleanup() {
    _resourceCleanupTimer?.cancel();
    _resourceCleanupTimer = Timer(const Duration(minutes: 5), () {
      // Remove players that have completed playback
      _activePlayers.removeWhere((player) => player.processingState == ProcessingState.completed);
    });
  }
  
  /// Dispose all resources
  Future<void> dispose() async {
    _resourceCleanupTimer?.cancel();
    await _cleanupPlayers();
    _isInitialized = false;
  }
}