import 'package:flutter/foundation.dart';
import '../../../data/models/breathing_session_model.dart';
import '../../../data/services/breathing_exercise_service.dart';
import 'breathing_health_metrics_service.dart';

/// Service that listens for breathing sessions and updates health metrics
class BreathingHealthMetricsListener {
  final BreathingHealthMetricsService _healthMetricsService;
  bool _isInitialized = false;
  
  /// Creates a new BreathingHealthMetricsListener
  BreathingHealthMetricsListener(this._healthMetricsService);
  
  /// Initializes the listener
  void initialize() {
    if (_isInitialized) return;
    
    // Add callback to breathing exercise service
    BreathingExerciseService.addSessionRecordedCallback(_onSessionRecorded);
    
    _isInitialized = true;
    debugPrint('BreathingHealthMetricsListener initialized');
  }
  
  /// Disposes the listener
  void dispose() {
    if (!_isInitialized) return;
    
    // Remove callback from breathing exercise service
    BreathingExerciseService.removeSessionRecordedCallback(_onSessionRecorded);
    
    _isInitialized = false;
    debugPrint('BreathingHealthMetricsListener disposed');
  }
  
  /// Called when a breathing session is recorded
  void _onSessionRecorded(BreathingSessionModel session) {
    debugPrint('BreathingHealthMetricsListener: Session recorded - ${session.id}');
    
    // Update health metrics
    _healthMetricsService.updateHealthMetricsAfterSession(session);
  }
}