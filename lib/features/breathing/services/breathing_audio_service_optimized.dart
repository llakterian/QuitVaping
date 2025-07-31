import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'package:quit_vaping/features/breathing/models/breathing_phase.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/breathing_exercise_model.dart';
import '../models/breathing_phase.dart';
import '../utils/breathing_audio_resource_optimizer.dart';
import '../utils/breathing_resource_manager.dart';
import 'breathing_audio_service.dart';
import 'breathing_background_handler.dart';

/// Optimized service responsible for managing audio guidance during breathing exercises.
/// Provides enhanced methods for initializing, controlling, and customizing audio playback
/// with improved resource management and background mode support.
class BreathingAudioServiceOptimized implements BreathingAudioService {
  /// Simple initialize method for compatibility
  @override
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
        _exhalePlayer!.setVolume(_volume),
      ]);
      
      _isInitialized = true;
      
      if (!_audioLoadCompleter.isCompleted) {
        _audioLoadCompleter.complete();
      }
    } catch (e) {
      debugPrint('Error initializing audio: $e');
      if (!_audioLoadCompleter.isCompleted) {
        _audioLoadCompleter.complete();
      }
    }
  }
  
  /// Play inhale - shorthand method for compatibility
  @override
  Future<void> playInhale() => playInhaleAudio();
  
  /// Play hold - shorthand method for compatibility
  @override
  Future<void> playHold() => playHoldAudio();
  
  /// Play exhale - shorthand method for compatibility
  @override
  Future<void> playExhale() => playExhaleAudio();
  // Constants for shared preferences keys
  static const String _audioEnabledKey = 'breathing_audio_enabled';
  static const String _audioVolumeKey = 'breathing_audio_volume';
  static const String _backgroundModeEnabledKey = 'breathing_background_mode_enabled';
  
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
  bool _isBackgroundModeEnabled = false;
  
  // Resource management
  final Set<AudioPlayer> _activePlayers = {};
  Timer? _resourceCleanupTimer;
  
  // Audio loading state
  final Completer<void> _audioLoadCompleter = Completer<void>();
  @override
  bool get isAudioLoaded => _audioLoadCompleter.isCompleted;
  
  // Background handler
  BreathingBackgroundHandler? _backgroundHandler;
  
  // Current exercise and pattern (for background mode)
  BreathingExerciseModel? _currentExercise;
  BreathingPattern? _currentPattern;
  int _currentDuration = 0;
  
  // State synchronization
  StreamSubscription<BackgroundPlaybackState>? _backgroundStateSubscription;
  final StreamController<BackgroundPlaybackState> _stateStreamController = 
      StreamController<BackgroundPlaybackState>.broadcast();
  
  // Performance metrics
  final AudioPerformanceMetrics _performanceMetrics = AudioPerformanceMetrics();
  OptimizationLevel _optimizationLevel = OptimizationLevel.medium;
  
  // Singleton instance
  static BreathingAudioServiceOptimized? _instance;
  
  /// Get the singleton instance of the service
  static BreathingAudioServiceOptimized get instance {
    _instance ??= BreathingAudioServiceOptimized._();
    return _instance!;
  }
  
  // Private constructor for singleton
  BreathingAudioServiceOptimized._();
  
  /// Initialize audio for a specific exercise and pattern
  @override
  Future<void> initializeAudio(BreathingExerciseModel exercise, BreathingPattern pattern) async {
    final startTime = DateTime.now().millisecondsSinceEpoch;
    
    // Store current exercise and pattern for background mode
    _currentExercise = exercise;
    _currentPattern = pattern;
    _currentDuration = exercise.recommendedDuration;
    
    // Load preferences first
    await _loadPreferences();
    
    // Clean up existing players
    await _cleanupPlayers();
    
    // Initialize audio resource optimizer if needed
    await _initializeAudioResourceOptimizer();
    
    // Create new optimized players using the resource optimizer
    _inhalePlayer = BreathingAudioResourceOptimizer.instance.createOptimizedAudioPlayer(
      handleInterruptions: true,
      androidApplyAudioAttributes: true,
      handleAudioSessionActivation: true,
    );
    
    _holdPlayer = BreathingAudioResourceOptimizer.instance.createOptimizedAudioPlayer(
      handleInterruptions: true,
      androidApplyAudioAttributes: true,
      handleAudioSessionActivation: true,
    );
    
    _exhalePlayer = BreathingAudioResourceOptimizer.instance.createOptimizedAudioPlayer(
      handleInterruptions: true,
      androidApplyAudioAttributes: true,
      handleAudioSessionActivation: true,
    );
    
    // Apply optimization level settings
    _applyOptimizationSettings();
    
    // Load audio assets based on optimization level
    try {
      // Register audio assets with resource manager for tracking
      BreathingResourceManager.instance.registerResource(_inhaleAudioPath, priority: 3);
      BreathingResourceManager.instance.registerResource(_holdAudioPath, priority: 3);
      BreathingResourceManager.instance.registerResource(_exhaleAudioPath, priority: 3);
      
      if (_optimizationLevel == OptimizationLevel.low) {
        // Sequential loading for low-end devices
        await _loadAudioAssetOptimized(_inhalePlayer!, _inhaleAudioPath);
        await _loadAudioAssetOptimized(_holdPlayer!, _holdAudioPath);
        await _loadAudioAssetOptimized(_exhalePlayer!, _exhaleAudioPath);
      } else {
        // Parallel loading for better performance on mid to high-end devices
        await Future.wait([
          _loadAudioAssetOptimized(_inhalePlayer!, _inhaleAudioPath),
          _loadAudioAssetOptimized(_holdPlayer!, _holdAudioPath),
          _loadAudioAssetOptimized(_exhalePlayer!, _exhaleAudioPath),
        ]);
      }
      
      // Set volume for all players
      await Future.wait([
        _inhalePlayer!.setVolume(_volume),
        _holdPlayer!.setVolume(_volume),
        _exhalePlayer!.setVolume(_volume),
      ]);
      
      _isInitialized = true;
      
      // Initialize background handler if enabled
      if (_isBackgroundModeEnabled) {
        await _initializeBackgroundHandler();
      }
      
      if (!_audioLoadCompleter.isCompleted) {
        _audioLoadCompleter.complete();
      }
      
      // Record performance metrics
      final endTime = DateTime.now().millisecondsSinceEpoch;
      _performanceMetrics.loadTimeMs = endTime - startTime;
    } catch (e) {
      debugPrint('Error initializing audio: $e');
      // Complete the completer even if there's an error to avoid blocking
      if (!_audioLoadCompleter.isCompleted) {
        _audioLoadCompleter.complete();
      }
    }
  }
  
  /// Apply settings based on the current optimization level
  void _applyOptimizationSettings() {
    switch (_optimizationLevel) {
      case OptimizationLevel.low:
        // Low-end device settings
        _inhalePlayer?.setSkipSilenceEnabled(true);
        _holdPlayer?.setSkipSilenceEnabled(true);
        _exhalePlayer?.setSkipSilenceEnabled(true);
        break;
      case OptimizationLevel.medium:
        // Medium device settings
        _inhalePlayer?.setSkipSilenceEnabled(false);
        _holdPlayer?.setSkipSilenceEnabled(false);
        _exhalePlayer?.setSkipSilenceEnabled(false);
        break;
      case OptimizationLevel.high:
        // High-end device settings
        _inhalePlayer?.setSkipSilenceEnabled(false);
        _holdPlayer?.setSkipSilenceEnabled(false);
        _exhalePlayer?.setSkipSilenceEnabled(false);
        break;
    }
  }
  
  /// Initialize the background handler
  Future<void> _initializeBackgroundHandler() async {
    try {
      _backgroundHandler = BreathingBackgroundHandler();
      await _backgroundHandler!.initialize();
      
      // Set up state synchronization
      _backgroundStateSubscription?.cancel();
      _backgroundStateSubscription = _backgroundHandler!.stateStream.listen(_handleBackgroundStateChange);
      
    } catch (e) {
      debugPrint('Error initializing background handler: $e');
      // Disable background mode if initialization fails
      await disableBackgroundMode();
    }
  }
  
  /// Handle background state changes
  void _handleBackgroundStateChange(BackgroundPlaybackState state) {
    // Forward the state to listeners
    _stateStreamController.add(state);
  }
  
  /// Initialize the audio resource optimizer
  Future<void> _initializeAudioResourceOptimizer() async {
    // Initialize the audio resource optimizer if not already initialized
    await BreathingAudioResourceOptimizer.instance.initialize();
  }
  
  /// Load an audio asset with error handling and caching (legacy method)
  Future<void> _loadAudioAsset(AudioPlayer player, String assetPath) async {
    final startTime = DateTime.now().millisecondsSinceEpoch;
    
    try {
      await player.setAsset(assetPath);
      
      // Record latency for performance metrics
      final endTime = DateTime.now().millisecondsSinceEpoch;
      _performanceMetrics.playbackLatencyMs = endTime - startTime;
    } catch (e) {
      debugPrint('Error loading audio asset $assetPath: $e');
      // Rethrow to be caught by the caller
      rethrow;
    }
  }
  
  /// Load an audio asset with optimization, lazy loading, and caching
  Future<void> _loadAudioAssetOptimized(AudioPlayer player, String assetPath) async {
    final startTime = DateTime.now().millisecondsSinceEpoch;
    
    try {
      // Use the audio resource optimizer to load the asset
      final duration = await BreathingAudioResourceOptimizer.instance.loadAudioAssetIntoPlayer(
        player, 
        assetPath
      );
      
      if (duration == null) {
        // Fallback to direct loading if optimized loading fails
        await player.setAsset(assetPath);
      }
      
      // Record latency for performance metrics
      final endTime = DateTime.now().millisecondsSinceEpoch;
      _performanceMetrics.playbackLatencyMs = endTime - startTime;
    } catch (e) {
      debugPrint('Error loading audio asset $assetPath: $e');
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
      _isBackgroundModeEnabled = prefs.getBool(_backgroundModeEnabledKey) ?? false;
    } catch (e) {
      debugPrint('Error loading audio preferences: $e');
      // Use defaults if preferences can't be loaded
      _isAudioEnabled = true;
      _volume = 1.0;
      _isBackgroundModeEnabled = false;
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
        debugPrint('Error disposing audio player: $e');
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
  @override
  Future<void> playInhaleAudio() async {
    if (!_isAudioEnabled || !_isInitialized || _inhalePlayer == null) return;
    
    final startTime = DateTime.now().millisecondsSinceEpoch;
    
    try {
      await _inhalePlayer!.seek(Duration.zero);
      await _inhalePlayer!.play();
      _activePlayers.add(_inhalePlayer!);
      _scheduleResourceCleanup();
      
      // Update background state if enabled
      if (_isBackgroundModeEnabled && _backgroundHandler != null) {
        await _backgroundHandler!.updateBackgroundState(
          BreathingPhase.inhale, 
          _currentPattern?.inhaleSeconds ?? 0
        );
      }
      
      // Record latency for performance metrics
      final endTime = DateTime.now().millisecondsSinceEpoch;
      _performanceMetrics.playbackLatencyMs = endTime - startTime;
    } catch (e) {
      debugPrint('Error playing inhale audio: $e');
    }
  }
  
  /// Play hold audio
  @override
  Future<void> playHoldAudio() async {
    if (!_isAudioEnabled || !_isInitialized || _holdPlayer == null) return;
    
    final startTime = DateTime.now().millisecondsSinceEpoch;
    
    try {
      await _holdPlayer!.seek(Duration.zero);
      await _holdPlayer!.play();
      _activePlayers.add(_holdPlayer!);
      _scheduleResourceCleanup();
      
      // Update background state if enabled
      if (_isBackgroundModeEnabled && _backgroundHandler != null) {
        // Determine which hold phase we're in based on the current state
        final state = await _backgroundHandler!.getCurrentState();
        final phase = state?.currentPhase == BreathingPhase.inhale || 
                     state?.currentPhase == BreathingPhase.inhaleHold
            ? BreathingPhase.inhaleHold
            : BreathingPhase.exhaleHold;
            
        final seconds = phase == BreathingPhase.inhaleHold
            ? _currentPattern?.inhaleHoldSeconds ?? 0
            : _currentPattern?.exhaleHoldSeconds ?? 0;
            
        await _backgroundHandler!.updateBackgroundState(phase, seconds);
      }
      
      // Record latency for performance metrics
      final endTime = DateTime.now().millisecondsSinceEpoch;
      _performanceMetrics.playbackLatencyMs = endTime - startTime;
    } catch (e) {
      debugPrint('Error playing hold audio: $e');
    }
  }
  
  /// Play exhale audio
  @override
  Future<void> playExhaleAudio() async {
    if (!_isAudioEnabled || !_isInitialized || _exhalePlayer == null) return;
    
    final startTime = DateTime.now().millisecondsSinceEpoch;
    
    try {
      await _exhalePlayer!.seek(Duration.zero);
      await _exhalePlayer!.play();
      _activePlayers.add(_exhalePlayer!);
      _scheduleResourceCleanup();
      
      // Update background state if enabled
      if (_isBackgroundModeEnabled && _backgroundHandler != null) {
        await _backgroundHandler!.updateBackgroundState(
          BreathingPhase.exhale, 
          _currentPattern?.exhaleSeconds ?? 0
        );
      }
      
      // Record latency for performance metrics
      final endTime = DateTime.now().millisecondsSinceEpoch;
      _performanceMetrics.playbackLatencyMs = endTime - startTime;
    } catch (e) {
      debugPrint('Error playing exhale audio: $e');
    }
  }
  
  /// Pause all audio
  @override
  Future<void> pauseAudio() async {
    if (!_isInitialized) return;
    
    try {
      for (final player in _activePlayers) {
        await player.pause();
      }
      
      // Update background state if enabled
      if (_isBackgroundModeEnabled && _backgroundHandler != null) {
        await _backgroundHandler!.stopBackgroundPlayback();
      }
    } catch (e) {
      debugPrint('Error pausing audio: $e');
    }
  }
  
  /// Resume audio
  @override
  Future<void> resumeAudio() async {
    if (!_isAudioEnabled || !_isInitialized) return;
    
    try {
      for (final player in _activePlayers) {
        await player.play();
      }
      
      // Update background state if enabled
      if (_isBackgroundModeEnabled && _backgroundHandler != null && 
          _currentExercise != null && _currentPattern != null) {
        // Get the current state to resume from
        final state = await _backgroundHandler!.getCurrentState();
        if (state != null) {
          await _backgroundHandler!.startBackgroundPlayback(
            _currentExercise!,
            _currentPattern!,
            _currentDuration
          );
          
          // Restore the phase
          await _backgroundHandler!.updateBackgroundState(
            state.currentPhase,
            state.secondsRemaining
          );
        }
      }
    } catch (e) {
      debugPrint('Error resuming audio: $e');
    }
  }
  
  /// Stop all audio
  @override
  Future<void> stopAudio() async {
    if (!_isInitialized) return;
    
    try {
      for (final player in _activePlayers) {
        await player.stop();
      }
      _activePlayers.clear();
      
      // Update background state if enabled
      if (_isBackgroundModeEnabled && _backgroundHandler != null) {
        await _backgroundHandler!.stopBackgroundPlayback();
      }
    } catch (e) {
      debugPrint('Error stopping audio: $e');
    }
  }
  
  /// Toggle audio enabled state
  @override
  Future<void> toggleAudio(bool enabled) async {
    _isAudioEnabled = enabled;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_audioEnabledKey, enabled);
      
      if (!enabled) {
        await stopAudio();
      }
    } catch (e) {
      debugPrint('Error toggling audio: $e');
    }
  }
  
  /// Set audio volume
  @override
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
      debugPrint('Error setting volume: $e');
    }
  }
  
  /// Check if audio is enabled
  @override
  bool isAudioEnabled() {
    return _isAudioEnabled;
  }
  
  /// Get current volume
  @override
  double getVolume() {
    return _volume;
  }
  
  /// Schedule resource cleanup to free memory
  void _scheduleResourceCleanup() {
    _resourceCleanupTimer?.cancel();
    _resourceCleanupTimer = Timer(const Duration(minutes: 2), () {
      // More aggressive cleanup for optimized version
      _activePlayers.removeWhere((player) => 
        player.processingState == ProcessingState.completed ||
        player.processingState == ProcessingState.idle
      );
      
      // Use the audio resource optimizer for more efficient cleanup
      releaseUnusedResources();
      
      // Update performance metrics
      _updatePerformanceMetrics();
    });
  }
  
  /// Update performance metrics from the audio resource optimizer
  void _updatePerformanceMetrics() {
    try {
      final metrics = BreathingAudioResourceOptimizer.instance.performanceMetrics;
      _performanceMetrics.cpuUsage = 0.0; // We don't have CPU usage metrics yet
      _performanceMetrics.memoryUsage = BreathingAudioResourceOptimizer.instance.memoryUsage;
      _performanceMetrics.playbackLatencyMs = metrics.avgPlaybackLatencyMs.toInt();
      
      // Only update load time if we have samples
      if (metrics.loadTimeSamples > 0) {
        _performanceMetrics.loadTimeMs = metrics.avgLoadTimeMs.toInt();
      }
    } catch (e) {
      debugPrint('Error updating performance metrics: $e');
    }
  }
  
  /// Dispose all resources
  @override
  Future<void> dispose() async {
    _resourceCleanupTimer?.cancel();
    await _cleanupPlayers();
    
    // Dispose background handler if enabled
    if (_isBackgroundModeEnabled && _backgroundHandler != null) {
      await _backgroundHandler!.stopBackgroundPlayback();
      await _backgroundHandler!.dispose();
    }
    
    // Cancel state subscription
    await _backgroundStateSubscription?.cancel();
    
    // Unregister audio assets from resource manager
    BreathingResourceManager.instance.unregisterResource(_inhaleAudioPath);
    BreathingResourceManager.instance.unregisterResource(_holdAudioPath);
    BreathingResourceManager.instance.unregisterResource(_exhaleAudioPath);
    
    // Release audio assets from cache
    await BreathingAudioResourceOptimizer.instance.releaseAudioAsset(_inhaleAudioPath);
    await BreathingAudioResourceOptimizer.instance.releaseAudioAsset(_holdAudioPath);
    await BreathingAudioResourceOptimizer.instance.releaseAudioAsset(_exhaleAudioPath);
    
    _isInitialized = false;
  }
  
  /// Enable background mode
  Future<void> enableBackgroundMode() async {
    _isBackgroundModeEnabled = true;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_backgroundModeEnabledKey, true);
      
      // Initialize background handler if not already initialized
      if (_backgroundHandler == null) {
        await _initializeBackgroundHandler();
      }
      
      // Start background playback if exercise is active
      if (_isInitialized && _currentExercise != null && _currentPattern != null) {
        await _backgroundHandler!.startBackgroundPlayback(
          _currentExercise!,
          _currentPattern!,
          _currentDuration
        );
      }
    } catch (e) {
      debugPrint('Error enabling background mode: $e');
    }
  }
  
  /// Disable background mode
  Future<void> disableBackgroundMode() async {
    _isBackgroundModeEnabled = false;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_backgroundModeEnabledKey, false);
      
      // Stop background playback if active
      if (_backgroundHandler != null) {
        await _backgroundHandler!.stopBackgroundPlayback();
      }
      
      // Cancel state subscription
      await _backgroundStateSubscription?.cancel();
      _backgroundStateSubscription = null;
    } catch (e) {
      debugPrint('Error disabling background mode: $e');
    }
  }
  
  /// Check if background mode is enabled
  bool isBackgroundModeEnabled() {
    return _isBackgroundModeEnabled;
  }
  
  /// Get the stream of background playback state updates
  Stream<BackgroundPlaybackState> get backgroundStateStream => _stateStreamController.stream;
  
  /// Preload audio assets for faster startup using lazy loading
  Future<void> preloadAudioAssets() async {
    if (_isInitialized) return;
    
    try {
      // Initialize audio resource optimizer if needed
      await _initializeAudioResourceOptimizer();
      
      // Register audio assets with resource manager for tracking
      BreathingResourceManager.instance.registerResource(_inhaleAudioPath, priority: 2);
      BreathingResourceManager.instance.registerResource(_holdAudioPath, priority: 2);
      BreathingResourceManager.instance.registerResource(_exhaleAudioPath, priority: 2);
      
      // Use the audio resource optimizer to preload assets
      // This will queue them for loading based on priority
      await Future.wait([
        BreathingAudioResourceOptimizer.instance.preloadAudioAsset(_inhaleAudioPath, priority: 2),
        BreathingAudioResourceOptimizer.instance.preloadAudioAsset(_holdAudioPath, priority: 2),
        BreathingAudioResourceOptimizer.instance.preloadAudioAsset(_exhaleAudioPath, priority: 2),
      ]);
      
      debugPrint('Audio assets preloaded successfully');
    } catch (e) {
      debugPrint('Error preloading audio assets: $e');
    }
  }
  
  /// Release unused resources to free memory
  Future<void> releaseUnusedResources() async {
    try {
      // Remove completed players from active set
      _activePlayers.removeWhere((player) => 
        player.processingState == ProcessingState.completed ||
        player.processingState == ProcessingState.idle
      );
      
      // Use the audio resource optimizer to clean up unused resources
      final cleanedCount = await BreathingAudioResourceOptimizer.instance.cleanupUnusedResources();
      
      // Update performance metrics
      _performanceMetrics.memoryUsage = BreathingAudioResourceOptimizer.instance.memoryUsage;
      
      debugPrint('Released $cleanedCount unused audio resources');
    } catch (e) {
      debugPrint('Error releasing unused resources: $e');
    }
  }
  
  /// Get performance metrics
  Future<AudioPerformanceMetrics> getPerformanceMetrics() async {
    return _performanceMetrics;
  }
  
  /// Set optimization level
  Future<void> setOptimizationLevel(OptimizationLevel level) async {
    _optimizationLevel = level;
    _applyOptimizationSettings();
  }
}

/// Optimization levels for different device capabilities
enum OptimizationLevel {
  low,    // For low-end devices
  medium, // For mid-range devices
  high    // For high-end devices
}

/// Audio performance metrics
class AudioPerformanceMetrics {
  double cpuUsage = 0.0;
  double memoryUsage = 0.0;
  int loadTimeMs = 0;
  int playbackLatencyMs = 0;
  
  AudioPerformanceMetrics({
    this.cpuUsage = 0.0,
    this.memoryUsage = 0.0,
    this.loadTimeMs = 0,
    this.playbackLatencyMs = 0,
  });
}