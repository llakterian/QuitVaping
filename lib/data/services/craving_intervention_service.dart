import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/craving_model.dart';
import '../models/user_model.dart';
import 'mcp_client_service.dart';
import 'storage_service.dart';
import 'notification_service.dart';
import 'package:geolocator/geolocator.dart';

class CravingInterventionService {
  static final CravingInterventionService _instance = CravingInterventionService._internal();
  factory CravingInterventionService() => _instance;
  CravingInterventionService._internal();

  final MCPClientService _mcpClient = MCPClientService();
  final StorageService _storage = StorageService();
  final NotificationService _notifications = NotificationService();
  
  Timer? _patternAnalysisTimer;
  Timer? _externalTriggerTimer;
  Timer? _locationMonitorTimer;
  
  // Enhanced pattern recognition data
  List<CravingModel> _recentCravings = [];
  Map<String, double> _triggerWeights = {};
  Map<String, List<DateTime>> _temporalPatterns = {};
  Map<String, double> _locationRiskScores = {};
  DateTime? _lastInterventionTime;
  
  // External factors cache
  Map<String, dynamic> _weatherData = {};
  Map<String, dynamic> _locationData = {};
  Position? _currentLocation;
  
  // Advanced pattern recognition
  List<Map<String, dynamic>> _patternHistory = [];
  Map<String, double> _interventionEffectiveness = {};
  
  // Panic mode state
  bool _panicModeActive = false;
  DateTime? _panicModeActivatedAt;
  
  Future<void> initialize() async {
    await _loadHistoricalData();
    await _initializeLocationServices();
    _startPatternAnalysis();
    _startExternalTriggerMonitoring();
    _startLocationMonitoring();
    await _buildAdvancedPatterns();
  }

  Future<void> _loadHistoricalData() async {
    try {
      final cravingsData = await _storage.getCravings();
      _recentCravings = cravingsData.take(50).toList(); // Last 50 cravings
      _analyzeTriggerPatterns();
    } catch (e) {
      debugPrint('Error loading historical craving data: $e');
    }
  }

  void _startPatternAnalysis() {
    _patternAnalysisTimer = Timer.periodic(
      const Duration(minutes: 15),
      (_) => _analyzeCurrentRiskLevel(),
    );
  }

  void _startExternalTriggerMonitoring() {
    _externalTriggerTimer = Timer.periodic(
      const Duration(minutes: 30),
      (_) => _updateExternalFactors(),
    );
  }

  Future<void> _analyzeCurrentRiskLevel() async {
    try {
      final riskLevel = await _calculateCurrentRiskLevel();
      
      if (riskLevel > 0.7 && _shouldTriggerIntervention()) {
        await _triggerProactiveIntervention(riskLevel);
      }
    } catch (e) {
      debugPrint('Error analyzing risk level: $e');
    }
  }

  Future<double> _calculateCurrentRiskLevel() async {
    double riskScore = 0.0;
    
    // Time-based risk factors
    final now = DateTime.now();
    final hour = now.hour;
    
    // Historical high-risk hours
    final hourlyRisk = _getHourlyRiskScore(hour);
    riskScore += hourlyRisk * 0.3;
    
    // Day of week patterns
    final dayOfWeekRisk = _getDayOfWeekRiskScore(now.weekday);
    riskScore += dayOfWeekRisk * 0.2;
    
    // Time since last craving
    final timeSinceLastCraving = _getTimeSinceLastCraving();
    if (timeSinceLastCraving != null) {
      // Higher risk if it's been a while (withdrawal) or very recent (pattern)
      final hoursSince = timeSinceLastCraving.inHours;
      if (hoursSince < 2 || (hoursSince > 12 && hoursSince < 24)) {
        riskScore += 0.2;
      }
    }
    
    // External trigger factors
    riskScore += await _getExternalTriggerRisk();
    
    // Stress indicators (if available from other services)
    riskScore += await _getStressIndicatorRisk();
    
    return math.min(riskScore, 1.0);
  }

  double _getHourlyRiskScore(int hour) {
    // Analyze historical cravings by hour
    final hourlyCounts = <int, int>{};
    for (final craving in _recentCravings) {
      final cravingHour = craving.timestamp.hour;
      hourlyCounts[cravingHour] = (hourlyCounts[cravingHour] ?? 0) + 1;
    }
    
    final maxCount = hourlyCounts.values.isEmpty ? 1 : hourlyCounts.values.reduce(math.max);
    return (hourlyCounts[hour] ?? 0) / maxCount;
  }

  double _getDayOfWeekRiskScore(int weekday) {
    final weekdayCounts = <int, int>{};
    for (final craving in _recentCravings) {
      final cravingWeekday = craving.timestamp.weekday;
      weekdayCounts[cravingWeekday] = (weekdayCounts[cravingWeekday] ?? 0) + 1;
    }
    
    final maxCount = weekdayCounts.values.isEmpty ? 1 : weekdayCounts.values.reduce(math.max);
    return (weekdayCounts[weekday] ?? 0) / maxCount;
  }

  Duration? _getTimeSinceLastCraving() {
    if (_recentCravings.isEmpty) return null;
    return DateTime.now().difference(_recentCravings.first.timestamp);
  }

  Future<double> _getExternalTriggerRisk() async {
    double risk = 0.0;
    
    // Weather-based triggers
    if (_weatherData.isNotEmpty) {
      final weather = _weatherData['current'];
      if (weather != null) {
        // Rainy/cloudy weather might increase cravings for some users
        if (weather['condition']?.toString().toLowerCase().contains('rain') == true ||
            weather['condition']?.toString().toLowerCase().contains('cloud') == true) {
          risk += 0.1;
        }
        
        // Temperature extremes
        final temp = weather['temperature'] as double?;
        if (temp != null && (temp < 5 || temp > 30)) {
          risk += 0.1;
        }
      }
    }
    
    return risk;
  }

  Future<double> _getStressIndicatorRisk() async {
    // This could integrate with health data or user-reported stress levels
    // For now, return a baseline
    return 0.0;
  }

  bool _shouldTriggerIntervention() {
    if (_lastInterventionTime == null) return true;
    
    // Don't trigger interventions more than once per hour
    final timeSinceLastIntervention = DateTime.now().difference(_lastInterventionTime!);
    return timeSinceLastIntervention.inHours >= 1;
  }

  Future<void> _triggerProactiveIntervention(double riskLevel) async {
    _lastInterventionTime = DateTime.now();
    
    try {
      // Get personalized intervention from AI workflow
      final intervention = await _getPersonalizedIntervention(riskLevel);
      
      // Send notification
      await _notifications.showInterventionNotification(
        title: intervention['title'] ?? 'Stay Strong!',
        body: intervention['message'] ?? 'You\'ve got this! Try a breathing exercise.',
        payload: jsonEncode({
          'type': 'proactive_intervention',
          'riskLevel': riskLevel,
          'interventionId': intervention['id'],
        }),
      );
      
      // Log the intervention
      await _logIntervention(intervention, riskLevel);
      
    } catch (e) {
      debugPrint('Error triggering proactive intervention: $e');
    }
  }

  Future<Map<String, dynamic>> _getPersonalizedIntervention(double riskLevel) async {
    try {
      final response = await _mcpClient.callTool(
        'ai-workflow',
        'generate_intervention',
        {
          'riskLevel': riskLevel,
          'recentCravings': _recentCravings.take(5).map((c) => c.toJson()).toList(),
          'triggerWeights': _triggerWeights,
          'externalFactors': {
            'weather': _weatherData,
            'location': _locationData,
            'timeOfDay': DateTime.now().hour,
            'dayOfWeek': DateTime.now().weekday,
          },
        },
      );
      
      return response.data as Map<String, dynamic>;
    } catch (e) {
      debugPrint('Error getting personalized intervention: $e');
      return _getFallbackIntervention(riskLevel);
    }
  }

  Map<String, dynamic> _getFallbackIntervention(double riskLevel) {
    final interventions = [
      {
        'id': 'breathing_exercise',
        'title': 'Take a Deep Breath',
        'message': 'Try the 4-7-8 breathing technique to calm your mind.',
        'type': 'breathing',
      },
      {
        'id': 'distraction',
        'title': 'Distract Yourself',
        'message': 'This craving will pass. Try doing something with your hands.',
        'type': 'distraction',
      },
      {
        'id': 'motivation',
        'title': 'Remember Your Why',
        'message': 'Think about why you decided to quit. You\'re stronger than this craving.',
        'type': 'motivation',
      },
    ];
    
    return interventions[Random().nextInt(interventions.length)];
  }

  Future<void> activatePanicMode() async {
    try {
      // Get immediate multi-modal support
      final panicResponse = await _mcpClient.callTool(
        'ai-workflow',
        'panic_mode_support',
        {
          'timestamp': DateTime.now().toIso8601String(),
          'userHistory': _recentCravings.take(3).map((c) => c.toJson()).toList(),
        },
      );
      
      final interventions = panicResponse.data['interventions'] as List<dynamic>;
      
      // Execute multiple interventions simultaneously
      for (final intervention in interventions) {
        await _executeIntervention(intervention as Map<String, dynamic>);
      }
      
      // Log panic mode activation
      await _logPanicModeActivation();
      
    } catch (e) {
      debugPrint('Error activating panic mode: $e');
      await _executeFallbackPanicMode();
    }
  }

  Future<void> _executeIntervention(Map<String, dynamic> intervention) async {
    final type = intervention['type'] as String;
    
    switch (type) {
      case 'notification':
        await _notifications.showInterventionNotification(
          title: intervention['title'],
          body: intervention['message'],
          payload: jsonEncode(intervention),
        );
        break;
      case 'breathing_prompt':
        // This would trigger the breathing exercise screen
        // Implementation depends on navigation service
        break;
      case 'distraction_activity':
        // This would suggest or launch a distraction activity
        break;
      case 'emergency_contact':
        // This would facilitate contacting support person
        break;
    }
  }

  Future<void> _executeFallbackPanicMode() async {
    // Basic panic mode without AI
    await _notifications.showInterventionNotification(
      title: 'Panic Mode Activated',
      body: 'You\'re going to be okay. Try the breathing exercise or call someone you trust.',
      payload: jsonEncode({'type': 'panic_mode_fallback'}),
    );
  }

  Future<void> _updateExternalFactors() async {
    try {
      // Update weather data
      final weatherResponse = await _mcpClient.callTool(
        'external-services',
        'get_weather',
        {'location': 'current'},
      );
      _weatherData = weatherResponse.data as Map<String, dynamic>;
      
      // Update location context if needed
      // This would depend on location permissions and services
      
    } catch (e) {
      debugPrint('Error updating external factors: $e');
    }
  }

  void _analyzeTriggerPatterns() {
    _triggerWeights.clear();
    
    for (final craving in _recentCravings) {
      // Use triggerCategory and specificTrigger from the model
      _triggerWeights[craving.triggerCategory] = (_triggerWeights[craving.triggerCategory] ?? 0) + 1;
      
      if (craving.specificTrigger != null) {
        _triggerWeights[craving.specificTrigger!] = (_triggerWeights[craving.specificTrigger!] ?? 0) + 1;
      }
    }
    
    // Normalize weights
    final maxWeight = _triggerWeights.values.isEmpty ? 1.0 : _triggerWeights.values.reduce(math.max);
    _triggerWeights.updateAll((key, value) => value / maxWeight);
  }

  Future<void> _logIntervention(Map<String, dynamic> intervention, double riskLevel) async {
    try {
      await _storage.logInterventionEvent({
        'timestamp': DateTime.now().toIso8601String(),
        'type': 'proactive',
        'intervention': intervention,
        'riskLevel': riskLevel,
        'triggered': true,
      });
    } catch (e) {
      debugPrint('Error logging intervention: $e');
    }
  }

  Future<void> _logPanicModeActivation() async {
    try {
      await _storage.logInterventionEvent({
        'timestamp': DateTime.now().toIso8601String(),
        'type': 'panic_mode',
        'userInitiated': true,
      });
    } catch (e) {
      debugPrint('Error logging panic mode activation: $e');
    }
  }

  Future<void> recordCravingOutcome(String interventionId, bool wasEffective) async {
    try {
      // Send feedback to AI workflow for learning
      await _mcpClient.callTool(
        'ai-workflow',
        'record_intervention_outcome',
        {
          'interventionId': interventionId,
          'effective': wasEffective,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
      
      // Update local learning data
      await _storage.updateInterventionEffectiveness(interventionId, wasEffective);
      
    } catch (e) {
      debugPrint('Error recording craving outcome: $e');
    }
  }

  void dispose() {
    _patternAnalysisTimer?.cancel();
    _externalTriggerTimer?.cancel();
  }
}