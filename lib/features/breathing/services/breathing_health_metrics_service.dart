import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/breathing_session_model.dart';
import '../../../data/services/breathing_exercise_service.dart';
import '../../../data/services/user_service.dart';

/// Service for connecting breathing exercises with health metrics
class BreathingHealthMetricsService {
  static const String _prefsKeyPrefix = 'breathing_health_metrics_';
  static const String _prefsKeyTotalBreathingMinutes = '${_prefsKeyPrefix}total_minutes';
  static const String _prefsKeyLastHealthUpdate = '${_prefsKeyPrefix}last_health_update';
  static const String _prefsKeyBreathingImpact = '${_prefsKeyPrefix}impact_data';
  
  final SharedPreferences _prefs;
  final BreathingExerciseService _breathingService;
  final UserService _userService;
  
  /// Creates a new BreathingHealthMetricsService
  BreathingHealthMetricsService(
    this._prefs,
    this._breathingService,
    this._userService,
  );
  
  /// Updates health metrics after a breathing session
  Future<void> updateHealthMetricsAfterSession(BreathingSessionModel session) async {
    // Get current statistics
    final stats = await _breathingService.getStatistics();
    final totalMinutes = stats['totalMinutes'] as int;
    
    // Save total breathing minutes
    await _prefs.setInt(_prefsKeyTotalBreathingMinutes, totalMinutes);
    
    // Save last health update timestamp
    await _prefs.setString(_prefsKeyLastHealthUpdate, DateTime.now().toIso8601String());
    
    // Calculate health impact based on breathing practice
    await _calculateHealthImpact(totalMinutes);
  }
  
  /// Calculates the health impact of breathing practice
  Future<void> _calculateHealthImpact(int totalMinutes) async {
    // Define impact thresholds
    const Map<String, Map<String, dynamic>> impactThresholds = {
      'stress': {
        'threshold': 30, // 30 minutes of practice
        'impactPercentage': 5, // 5% reduction in stress per 30 minutes
        'maxImpact': 30, // Maximum 30% reduction
        'metric': 'stress reduction',
        'icon': Icons.spa,
      },
      'anxiety': {
        'threshold': 60, // 60 minutes of practice
        'impactPercentage': 8, // 8% reduction in anxiety per 60 minutes
        'maxImpact': 40, // Maximum 40% reduction
        'metric': 'anxiety reduction',
        'icon': Icons.psychology,
      },
      'focus': {
        'threshold': 45, // 45 minutes of practice
        'impactPercentage': 7, // 7% improvement in focus per 45 minutes
        'maxImpact': 35, // Maximum 35% improvement
        'metric': 'focus improvement',
        'icon': Icons.center_focus_strong,
      },
      'sleep': {
        'threshold': 90, // 90 minutes of practice
        'impactPercentage': 10, // 10% improvement in sleep quality per 90 minutes
        'maxImpact': 50, // Maximum 50% improvement
        'metric': 'sleep quality improvement',
        'icon': Icons.nightlight,
      },
      'craving_management': {
        'threshold': 20, // 20 minutes of practice
        'impactPercentage': 6, // 6% improvement in craving management per 20 minutes
        'maxImpact': 45, // Maximum 45% improvement
        'metric': 'craving management improvement',
        'icon': Icons.trending_down,
      },
    };
    
    // Calculate impact for each metric
    final Map<String, Map<String, dynamic>> impacts = {};
    
    impactThresholds.forEach((key, thresholdData) {
      final threshold = thresholdData['threshold'] as int;
      final impactPercentage = thresholdData['impactPercentage'] as int;
      final maxImpact = thresholdData['maxImpact'] as int;
      
      // Calculate raw impact based on total minutes
      final rawImpact = (totalMinutes / threshold) * impactPercentage;
      
      // Cap at maximum impact
      final actualImpact = rawImpact > maxImpact ? maxImpact : rawImpact;
      
      impacts[key] = {
        'impact': actualImpact.round(),
        'metric': thresholdData['metric'],
        'icon': thresholdData['icon'],
      };
    });
    
    // Save impact data
    await _prefs.setString(_prefsKeyBreathingImpact, _encodeImpactData(impacts));
  }
  
  /// Gets the health impact of breathing practice
  Future<Map<String, Map<String, dynamic>>> getHealthImpact() async {
    final impactJson = _prefs.getString(_prefsKeyBreathingImpact);
    
    if (impactJson == null) {
      // Calculate impact if not available
      final stats = await _breathingService.getStatistics();
      final totalMinutes = stats['totalMinutes'] as int;
      await _calculateHealthImpact(totalMinutes);
      
      // Get newly calculated impact
      return _decodeImpactData(_prefs.getString(_prefsKeyBreathingImpact) ?? '{}');
    }
    
    return _decodeImpactData(impactJson);
  }
  
  /// Gets the top health impact of breathing practice
  Future<Map<String, dynamic>?> getTopHealthImpact() async {
    final impacts = await getHealthImpact();
    
    if (impacts.isEmpty) {
      return null;
    }
    
    // Find the metric with the highest impact
    String topMetric = '';
    int highestImpact = 0;
    
    impacts.forEach((key, data) {
      final impact = data['impact'] as int;
      if (impact > highestImpact) {
        highestImpact = impact;
        topMetric = key;
      }
    });
    
    if (topMetric.isEmpty) {
      return null;
    }
    
    return {
      'key': topMetric,
      ...impacts[topMetric]!,
    };
  }
  
  /// Gets the total breathing minutes
  Future<int> getTotalBreathingMinutes() async {
    return _prefs.getInt(_prefsKeyTotalBreathingMinutes) ?? 0;
  }
  
  /// Gets the last health update timestamp
  Future<DateTime?> getLastHealthUpdate() async {
    final timestamp = _prefs.getString(_prefsKeyLastHealthUpdate);
    
    if (timestamp == null) {
      return null;
    }
    
    try {
      return DateTime.parse(timestamp);
    } catch (e) {
      return null;
    }
  }
  
  /// Gets breathing practice milestones for health info screen
  Future<List<Map<String, dynamic>>> getBreathingHealthMilestones() async {
    final totalMinutes = await getTotalBreathingMinutes();
    
    return [
      {
        'title': '30 Minutes',
        'description': 'Regular breathing practice has begun to reduce your stress levels.',
        'isAchieved': totalMinutes >= 30,
        'icon': Icons.spa,
      },
      {
        'title': '60 Minutes',
        'description': 'Your anxiety levels have decreased, making cravings easier to manage.',
        'isAchieved': totalMinutes >= 60,
        'icon': Icons.psychology,
      },
      {
        'title': '120 Minutes',
        'description': 'Your focus and concentration have improved, helping you stay committed to quitting.',
        'isAchieved': totalMinutes >= 120,
        'icon': Icons.center_focus_strong,
      },
      {
        'title': '180 Minutes',
        'description': 'Your sleep quality has improved, helping your body recover from nicotine dependence.',
        'isAchieved': totalMinutes >= 180,
        'icon': Icons.nightlight,
      },
      {
        'title': '300 Minutes',
        'description': 'Your breathing exercises have significantly improved your ability to manage cravings.',
        'isAchieved': totalMinutes >= 300,
        'icon': Icons.trending_down,
      },
      {
        'title': '500 Minutes',
        'description': 'Your consistent breathing practice has created new neural pathways that support your quit journey.',
        'isAchieved': totalMinutes >= 500,
        'icon': Icons.psychology_alt,
      },
    ];
  }
  
  /// Encodes impact data to JSON string
  String _encodeImpactData(Map<String, Map<String, dynamic>> impacts) {
    final Map<String, dynamic> encodedData = {};
    
    impacts.forEach((key, data) {
      encodedData[key] = {
        'impact': data['impact'],
        'metric': data['metric'],
        'icon': (data['icon'] as IconData).codePoint,
      };
    });
    
    return encodedData.toString();
  }
  
  /// Decodes impact data from JSON string
  Map<String, Map<String, dynamic>> _decodeImpactData(String jsonString) {
    // Simple parsing of the toString() format
    if (jsonString.isEmpty || jsonString == '{}') {
      return {};
    }
    
    final Map<String, Map<String, dynamic>> decodedData = {};
    
    try {
      // Remove curly braces
      final content = jsonString.substring(1, jsonString.length - 1);
      
      // Split by key-value pairs
      final pairs = content.split(', ');
      
      for (final pair in pairs) {
        final keyValue = pair.split(': ');
        if (keyValue.length == 2) {
          final key = keyValue[0].replaceAll(RegExp(r'[{}]'), '');
          final value = keyValue[1];
          
          // Parse the inner map
          if (value.startsWith('{') && value.endsWith('}')) {
            final innerContent = value.substring(1, value.length - 1);
            final innerPairs = innerContent.split(', ');
            
            final Map<String, dynamic> innerMap = {};
            
            for (final innerPair in innerPairs) {
              final innerKeyValue = innerPair.split(': ');
              if (innerKeyValue.length == 2) {
                final innerKey = innerKeyValue[0];
                final innerValue = innerKeyValue[1];
                
                if (innerKey == 'impact') {
                  innerMap[innerKey] = int.tryParse(innerValue) ?? 0;
                } else if (innerKey == 'icon') {
                  innerMap[innerKey] = IconData(
                    int.tryParse(innerValue) ?? 0xe000,
                    fontFamily: 'MaterialIcons',
                  );
                } else {
                  innerMap[innerKey] = innerValue.replaceAll(RegExp(r'^"|"$'), '');
                }
              }
            }
            
            decodedData[key.replaceAll(RegExp(r'^"|"$'), '')] = innerMap;
          }
        }
      }
      
      return decodedData;
    } catch (e) {
      return {};
    }
  }
}