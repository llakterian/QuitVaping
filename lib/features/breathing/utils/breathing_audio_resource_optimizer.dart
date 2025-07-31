import 'dart:async';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'breathing_performance_monitor.dart';
import 'breathing_resource_manager.dart';

/// A utility class for optimizing audio resource usage in breathing exercises
class BreathingAudioResourceOptimizer {
  /// Singleton instance
  static final BreathingAudioResourceOptimizer _instance = BreathingAudioResourceOptimizer._internal();
  
  /// Get the singleton instance
  static BreathingAudioResourceOptimizer get instance => _instance;
  
  /// Private constructor
  BreathingAudioResourceOptimizer._internal();
  
  // Audio cache
  final Map<String, _CachedAudioAsset> _audioCache = {};
  
  // Audio preload queue
  final Queue<_AudioLoadRequest> _preloadQueue = Queue<_AudioLoadRequest>();
  
  // Active audio players
  final Set<AudioPlayer> _activePlayers = {};
  
  // Whether the optimizer is currently loading assets
  bool _isLoading = false;
  
  // Maximum concurrent loads
  int _maxConcurrentLoads = 2;
  
  // Memory usage threshold in MB
  double _memoryThreshold = 20.0;
  
  // Current estimated memory usage in MB
  double _estimatedMemoryUsage = 0.0;
  
  // Timer for periodic cleanup
  Timer? _cleanupTimer;
  
  // Last cleanup time
  DateTime _lastCleanupTime = DateTime.now();
  
  // Audio loading metrics
  final _AudioPerformanceMetrics _performanceMetrics = _AudioPerformanceMetrics();
  
  /// Initialize the audio resource optimizer
  Future<void> initialize() async {
    // Set max concurrent loads based on device performance
    _setMaxConcurrentLoadsForDevice();
    
    // Set memory threshold based on device performance
    _setMemoryThresholdForDevice();
    
    // Start periodic cleanup
    _startPeriodicCleanup();
  }
  
  /// Set max concurrent loads based on device performance
  void _setMaxConcurrentLoadsForDevice() {
    final performanceTier = BreathingPerformanceMonitor.instance.performanceTier;
    
    switch (performanceTier) {
      case DevicePerformanceTier.high:
        _maxConcurrentLoads = 3; // More concurrent loads for high-end devices
        break;
      case DevicePerformanceTier.medium:
        _maxConcurrentLoads = 2; // Moderate concurrent loads for mid-range devices
        break;
      case DevicePerformanceTier.low:
        _maxConcurrentLoads = 1; // Single load at a time for low-end devices
        break;
    }
  }
  
  /// Set memory threshold based on device performance
  void _setMemoryThresholdForDevice() {
    final performanceTier = BreathingPerformanceMonitor.instance.performanceTier;
    
    switch (performanceTier) {
      case DevicePerformanceTier.high:
        _memoryThreshold = 30.0; // 30MB for high-end devices
        break;
      case DevicePerformanceTier.medium:
        _memoryThreshold = 20.0; // 20MB for mid-range devices
        break;
      case DevicePerformanceTier.low:
        _memoryThreshold = 10.0; // 10MB for low-end devices
        break;
    }
  }
  
  /// Start periodic cleanup of unused resources
  void _startPeriodicCleanup() {
    _cleanupTimer?.cancel();
    _cleanupTimer = Timer.periodic(const Duration(minutes: 2), (_) {
      cleanupUnusedResources();
    });
  }
  
  /// Stop periodic cleanup
  void stopPeriodicCleanup() {
    _cleanupTimer?.cancel();
    _cleanupTimer = null;
  }
  
  /// Preload an audio asset
  Future<bool> preloadAudioAsset(String assetPath, {int priority = 0}) async {
    // If already in cache, update last access time and return
    if (_audioCache.containsKey(assetPath)) {
      final cachedAsset = _audioCache[assetPath]!;
      cachedAsset.lastAccessTime = DateTime.now();
      cachedAsset.accessCount++;
      return true;
    }
    
    // Register with resource manager
    BreathingResourceManager.instance.registerResource(assetPath, priority: priority);
    
    // Add to preload queue
    _preloadQueue.add(_AudioLoadRequest(
      assetPath: assetPath,
      priority: priority,
      completer: Completer<bool>(),
    ));
    
    // Sort queue by priority (higher priority first)
    final sortedQueue = _preloadQueue.toList()
      ..sort((a, b) => b.priority.compareTo(a.priority));
    
    _preloadQueue.clear();
    _preloadQueue.addAll(sortedQueue);
    
    // Start processing queue if not already processing
    if (!_isLoading) {
      _processPreloadQueue();
    }
    
    // Return future that completes when asset is loaded
    return _preloadQueue.last.completer.future;
  }
  
  /// Process the preload queue
  Future<void> _processPreloadQueue() async {
    if (_preloadQueue.isEmpty || _isLoading) {
      return;
    }
    
    _isLoading = true;
    
    // Process up to max concurrent loads
    final batch = <_AudioLoadRequest>[];
    while (batch.length < _maxConcurrentLoads && _preloadQueue.isNotEmpty) {
      batch.add(_preloadQueue.removeFirst());
    }
    
    // Load assets in parallel
    await Future.wait(
      batch.map((request) => _loadAudioAsset(request)),
    );
    
    _isLoading = false;
    
    // Continue processing if there are more items in the queue
    if (_preloadQueue.isNotEmpty) {
      _processPreloadQueue();
    }
  }
  
  /// Load an audio asset
  Future<bool> _loadAudioAsset(_AudioLoadRequest request) async {
    final startTime = DateTime.now().millisecondsSinceEpoch;
    
    try {
      // Check if we need to clean up before loading new asset
      if (_isMemoryUsageHigh()) {
        await cleanupUnusedResources();
      }
      
      // Load the asset data
      final data = await rootBundle.load(request.assetPath);
      final bytes = data.buffer.asUint8List();
      
      // Estimate memory usage (rough estimate)
      final memorySizeInMB = bytes.length / (1024 * 1024);
      
      // Update estimated memory usage
      _estimatedMemoryUsage += memorySizeInMB;
      
      // Create a temporary player to get duration
      final tempPlayer = AudioPlayer();
      await tempPlayer.setAudioSource(
        AudioSource.uri(Uri.parse('asset:///${request.assetPath}')),
      );
      final duration = tempPlayer.duration;
      await tempPlayer.dispose();
      
      // Cache the asset
      _audioCache[request.assetPath] = _CachedAudioAsset(
        assetPath: request.assetPath,
        sizeInMB: memorySizeInMB,
        lastAccessTime: DateTime.now(),
        accessCount: 1,
        duration: duration,
      );
      
      // Record performance metrics
      final endTime = DateTime.now().millisecondsSinceEpoch;
      final loadTime = endTime - startTime;
      _performanceMetrics.recordLoadTime(loadTime);
      
      // Complete the request
      request.completer.complete(true);
      return true;
    } catch (e) {
      debugPrint('Error loading audio asset ${request.assetPath}: $e');
      request.completer.complete(false);
      return false;
    }
  }
  
  /// Get a cached audio asset
  _CachedAudioAsset? getCachedAudioAsset(String assetPath) {
    if (_audioCache.containsKey(assetPath)) {
      final cachedAsset = _audioCache[assetPath]!;
      cachedAsset.lastAccessTime = DateTime.now();
      cachedAsset.accessCount++;
      return cachedAsset;
    }
    return null;
  }
  
  /// Check if an audio asset is cached
  bool isAudioAssetCached(String assetPath) {
    return _audioCache.containsKey(assetPath);
  }
  
  /// Register an audio player as active
  void registerAudioPlayer(AudioPlayer player) {
    _activePlayers.add(player);
  }
  
  /// Unregister an audio player
  void unregisterAudioPlayer(AudioPlayer player) {
    _activePlayers.remove(player);
  }
  
  /// Release a specific audio asset from cache
  Future<void> releaseAudioAsset(String assetPath) async {
    if (_audioCache.containsKey(assetPath)) {
      final cachedAsset = _audioCache[assetPath]!;
      _estimatedMemoryUsage -= cachedAsset.sizeInMB;
      _audioCache.remove(assetPath);
      
      // Unregister from resource manager
      BreathingResourceManager.instance.unregisterResource(assetPath);
    }
  }
  
  /// Clean up unused resources
  Future<int> cleanupUnusedResources() async {
    final now = DateTime.now();
    _lastCleanupTime = now;
    
    // Clean up audio assets that haven't been accessed in the last 5 minutes
    final assetsToRemove = <String>[];
    for (final entry in _audioCache.entries) {
      final cachedAsset = entry.value;
      final minutesSinceLastAccess = now.difference(cachedAsset.lastAccessTime).inMinutes;
      
      // Remove if not accessed recently or if memory usage is high
      if (minutesSinceLastAccess > 5 || (_isMemoryUsageHigh() && minutesSinceLastAccess > 2)) {
        assetsToRemove.add(entry.key);
        _estimatedMemoryUsage -= cachedAsset.sizeInMB;
        
        // Unregister from resource manager
        BreathingResourceManager.instance.unregisterResource(entry.key);
      }
    }
    
    // Remove unused assets
    for (final key in assetsToRemove) {
      _audioCache.remove(key);
    }
    
    // Clean up inactive audio players
    final playersToRemove = <AudioPlayer>[];
    for (final player in _activePlayers) {
      if (player.processingState == ProcessingState.completed || 
          player.processingState == ProcessingState.idle) {
        playersToRemove.add(player);
      }
    }
    
    // Dispose inactive players
    for (final player in playersToRemove) {
      _activePlayers.remove(player);
      await player.dispose();
    }
    
    // Force garbage collection if memory usage is still high
    if (_isMemoryUsageHigh()) {
      await _forceGarbageCollection();
    }
    
    return assetsToRemove.length;
  }
  
  /// Force garbage collection
  Future<void> _forceGarbageCollection() async {
    // This is a hint to the VM to perform GC
    // It's not guaranteed to run immediately
    await Future.delayed(const Duration(milliseconds: 100));
    
    // Run multiple microtasks to encourage GC
    for (int i = 0; i < 5; i++) {
      await Future.microtask(() {});
    }
  }
  
  /// Check if memory usage is high
  bool _isMemoryUsageHigh() {
    return _estimatedMemoryUsage > _memoryThreshold;
  }
  
  /// Get current memory usage in MB
  double get memoryUsage => _estimatedMemoryUsage;
  
  /// Get performance metrics
  _AudioPerformanceMetrics get performanceMetrics => _performanceMetrics;
  
  /// Get the number of cached assets
  int get cachedAssetCount => _audioCache.length;
  
  /// Get the number of active players
  int get activePlayerCount => _activePlayers.length;
  
  /// Dispose the audio resource optimizer
  void dispose() {
    stopPeriodicCleanup();
    _audioCache.clear();
    _preloadQueue.clear();
    _estimatedMemoryUsage = 0.0;
  }
  
  /// Create an optimized audio player
  AudioPlayer createOptimizedAudioPlayer({
    bool handleInterruptions = true,
    bool androidApplyAudioAttributes = true,
    bool handleAudioSessionActivation = true,
  }) {
    final player = AudioPlayer(
      handleInterruptions: handleInterruptions,
      androidApplyAudioAttributes: androidApplyAudioAttributes,
      handleAudioSessionActivation: handleAudioSessionActivation,
    );
    
    // Register the player
    registerAudioPlayer(player);
    
    return player;
  }
  
  /// Load audio asset into player with optimization
  Future<Duration?> loadAudioAssetIntoPlayer(AudioPlayer player, String assetPath) async {
    final startTime = DateTime.now().millisecondsSinceEpoch;
    
    try {
      // Check if asset is cached
      final cachedAsset = getCachedAudioAsset(assetPath);
      
      if (cachedAsset != null) {
        // Asset is cached, load it into player
        await player.setAsset(assetPath);
        
        // Record performance metrics
        final endTime = DateTime.now().millisecondsSinceEpoch;
        final loadTime = endTime - startTime;
        _performanceMetrics.recordPlaybackLatency(loadTime);
        
        return cachedAsset.duration;
      } else {
        // Asset is not cached, preload it first
        final success = await preloadAudioAsset(assetPath);
        
        if (success) {
          // Now load it into player
          await player.setAsset(assetPath);
          
          // Record performance metrics
          final endTime = DateTime.now().millisecondsSinceEpoch;
          final loadTime = endTime - startTime;
          _performanceMetrics.recordPlaybackLatency(loadTime);
          
          return player.duration;
        } else {
          return null;
        }
      }
    } catch (e) {
      debugPrint('Error loading audio asset into player: $e');
      return null;
    }
  }
}

/// A cached audio asset with metadata
class _CachedAudioAsset {
  /// The asset path
  final String assetPath;
  
  /// Size of the asset in MB
  final double sizeInMB;
  
  /// Last access time
  DateTime lastAccessTime;
  
  /// Number of times the asset has been accessed
  int accessCount;
  
  /// Duration of the audio
  final Duration? duration;
  
  /// Creates a new _CachedAudioAsset
  _CachedAudioAsset({
    required this.assetPath,
    required this.sizeInMB,
    required this.lastAccessTime,
    required this.accessCount,
    this.duration,
  });
}

/// Audio load request
class _AudioLoadRequest {
  /// The asset path to load
  final String assetPath;
  
  /// The priority of the load request
  final int priority;
  
  /// Completer for the load request
  final Completer<bool> completer;
  
  /// Creates a new _AudioLoadRequest
  _AudioLoadRequest({
    required this.assetPath,
    required this.priority,
    required this.completer,
  });
}

/// Audio performance metrics
class _AudioPerformanceMetrics {
  /// Average load time in milliseconds
  double _avgLoadTimeMs = 0.0;
  
  /// Average playback latency in milliseconds
  double _avgPlaybackLatencyMs = 0.0;
  
  /// Number of load time samples
  int _loadTimeSamples = 0;
  
  /// Number of playback latency samples
  int _playbackLatencySamples = 0;
  
  /// Record a load time sample
  void recordLoadTime(int loadTimeMs) {
    if (_loadTimeSamples == 0) {
      _avgLoadTimeMs = loadTimeMs.toDouble();
    } else {
      // Exponential moving average with alpha = 0.3
      _avgLoadTimeMs = 0.3 * loadTimeMs + 0.7 * _avgLoadTimeMs;
    }
    _loadTimeSamples++;
  }
  
  /// Record a playback latency sample
  void recordPlaybackLatency(int latencyMs) {
    if (_playbackLatencySamples == 0) {
      _avgPlaybackLatencyMs = latencyMs.toDouble();
    } else {
      // Exponential moving average with alpha = 0.3
      _avgPlaybackLatencyMs = 0.3 * latencyMs + 0.7 * _avgPlaybackLatencyMs;
    }
    _playbackLatencySamples++;
  }
  
  /// Get average load time in milliseconds
  double get avgLoadTimeMs => _avgLoadTimeMs;
  
  /// Get average playback latency in milliseconds
  double get avgPlaybackLatencyMs => _avgPlaybackLatencyMs;
  
  /// Get number of load time samples
  int get loadTimeSamples => _loadTimeSamples;
  
  /// Get number of playback latency samples
  int get playbackLatencySamples => _playbackLatencySamples;
}