import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/breathing_exercise_model.dart';
import '../../../data/models/breathing_session_model.dart';
import '../../../data/models/craving_model.dart';
import '../../../data/services/breathing_exercise_service.dart';

/// Service for integrating breathing exercises with the craving tracker
class BreathingCravingIntegrationService {
  static const String _prefsKeyPrefix = 'breathing_craving_integration_';
  static const String _prefsCravingBreathingCorrelation = '${_prefsKeyPrefix}correlation';
  static const String _prefsLastSuggestedExercise = '${_prefsKeyPrefix}last_suggested';
  static const String _prefsCravingBreathingStats = '${_prefsKeyPrefix}stats';
  static const String _prefsCravingReductionData = '${_prefsKeyPrefix}craving_reduction';
  
  final BreathingExerciseService _breathingService;
  final SharedPreferences _prefs;
  
  /// Creates a new BreathingCravingIntegrationService
  BreathingCravingIntegrationService(this._breathingService, this._prefs);
  
  /// Gets a recommended breathing exercise based on craving intensity and trigger
  Future<BreathingExerciseModel?> getRecommendedExerciseForCraving(CravingModel craving) async {
    final exercises = await _breathingService.getExercises();
    
    if (exercises.isEmpty) {
      return null;
    }
    
    // First check if we have effectiveness data to make a personalized recommendation
    final mostEffectiveId = await getMostEffectiveExerciseForTrigger(craving.triggerCategory ?? "unknown");
    if (mostEffectiveId != null) {
      final mostEffectiveExercise = exercises.firstWhere(
        (e) => e.id == mostEffectiveId,
        orElse: () => exercises.first,
      );
      return mostEffectiveExercise;
    }
    
    // For high intensity cravings (7-10), recommend exercises good for immediate relief
    if (craving.intensity >= 7) {
      // Look for exercises with 'craving' tag
      final cravingExercises = exercises.where((e) => e.tags.contains('craving')).toList();
      if (cravingExercises.isNotEmpty) {
        // Prioritize box breathing for high intensity cravings
        final boxBreathing = cravingExercises.firstWhere(
          (e) => e.id == 'box-breathing',
          orElse: () => cravingExercises.first,
        );
        return boxBreathing;
      }
    }
    
    // For medium intensity cravings (4-6), recommend based on trigger category
    if (craving.intensity >= 4 && craving.intensity <= 6) {
      if (craving.triggerCategory?.toLowerCase().contains('stress') || 
          craving.trigger?.toLowerCase().contains('stress')) {
        // Find stress-related exercises
        final stressExercises = exercises.where((e) => e.tags.contains('stress')).toList();
        if (stressExercises.isNotEmpty) {
          return stressExercises.first;
        }
      }
      
      if (craving.triggerCategory?.toLowerCase().contains('emotion') || 
          craving.trigger?.toLowerCase().contains('emotion') ||
          craving.triggerCategory?.toLowerCase().contains('mood') || 
          craving.trigger?.toLowerCase().contains('mood')) {
        // Find emotional balance exercises
        final emotionalExercises = exercises.where((e) => e.tags.contains('emotional')).toList();
        if (emotionalExercises.isNotEmpty) {
          return emotionalExercises.first;
        }
      }
    }
    
    // For low intensity cravings (1-3), recommend relaxation exercises
    if (craving.intensity <= 3) {
      final relaxationExercises = exercises.where((e) => e.tags.contains('relaxation')).toList();
      if (relaxationExercises.isNotEmpty) {
        return relaxationExercises.first;
      }
    }
    
    // If no specific match, return a beginner-friendly exercise
    final beginnerExercises = exercises.where((e) => e.tags.contains('beginner')).toList();
    if (beginnerExercises.isNotEmpty) {
      return beginnerExercises.first;
    }
    
    // Fallback to the first exercise
    return exercises.first;
  }
  
  /// Records the correlation between a craving and a breathing exercise
  Future<void> recordCravingBreathingCorrelation(
    String cravingId, 
    String exerciseId, 
    bool wasEffective,
    {String? triggerCategory, int? cravingIntensity}
  ) async {
    final correlations = await _getCravingBreathingCorrelations();
    
    correlations[cravingId] = {
      'exerciseId': exerciseId,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'wasEffective': wasEffective,
      'triggerCategory': triggerCategory,
      'cravingIntensity': cravingIntensity,
    };
    
    await _prefs.setString(
      _prefsCravingBreathingCorrelation, 
      _encodeJson(correlations)
    );
    
    // Update statistics
    await _updateCravingBreathingStats(exerciseId, wasEffective, triggerCategory);
  }
  
  /// Records a breathing session that was performed after a craving
  Future<void> recordBreathingSessionAfterCraving(
    CravingModel craving,
    BreathingSessionModel session,
    bool reducedCraving,
    int? intensityAfter
  ) async {
    // Record the correlation
    await recordCravingBreathingCorrelation(
      craving.timestamp.millisecondsSinceEpoch.toString(),
      session.exerciseId,
      reducedCraving,
      triggerCategory: craving.triggerCategory,
      cravingIntensity: craving.intensity,
    );
    
    // Record craving reduction data
    if (intensityAfter != null) {
      final reductionData = await _getCravingReductionData();
      
      reductionData[session.id] = {
        'cravingId': craving.timestamp.millisecondsSinceEpoch.toString(),
        'exerciseId': session.exerciseId,
        'intensityBefore': craving.intensity,
        'intensityAfter': intensityAfter,
        'reduction': craving.intensity - intensityAfter,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
      
      await _prefs.setString(
        _prefsCravingReductionData,
        _encodeJson(reductionData)
      );
    }
  }
  
  /// Gets the correlation data between cravings and breathing exercises
  Future<Map<String, dynamic>> _getCravingBreathingCorrelations() async {
    final correlationsString = _prefs.getString(_prefsCravingBreathingCorrelation);
    
    if (correlationsString != null) {
      return _decodeJson(correlationsString);
    }
    
    return {};
  }
  
  /// Gets the craving reduction data
  Future<Map<String, dynamic>> _getCravingReductionData() async {
    final dataString = _prefs.getString(_prefsCravingReductionData);
    
    if (dataString != null) {
      return _decodeJson(dataString);
    }
    
    return {};
  }
  
  /// Updates statistics about breathing exercises and cravings
  Future<void> _updateCravingBreathingStats(
    String exerciseId, 
    bool wasEffective,
    String? triggerCategory
  ) async {
    final stats = await _getCravingBreathingStats();
    
    // Update overall stats
    if (!stats.containsKey('overall')) {
      stats['overall'] = {
        'total': 0,
        'effective': 0,
      };
    }
    
    stats['overall']['total'] = (stats['overall']['total'] ?? 0) + 1;
    if (wasEffective) {
      stats['overall']['effective'] = (stats['overall']['effective'] ?? 0) + 1;
    }
    
    // Update exercise-specific stats
    if (!stats.containsKey('byExercise')) {
      stats['byExercise'] = {};
    }
    
    if (!stats['byExercise'].containsKey(exerciseId)) {
      stats['byExercise'][exerciseId] = {
        'total': 0,
        'effective': 0,
      };
    }
    
    stats['byExercise'][exerciseId]['total'] = 
        (stats['byExercise'][exerciseId]['total'] ?? 0) + 1;
    
    if (wasEffective) {
      stats['byExercise'][exerciseId]['effective'] = 
          (stats['byExercise'][exerciseId]['effective'] ?? 0) + 1;
    }
    
    // Update trigger-specific stats if available
    if (triggerCategory != null && triggerCategory.isNotEmpty) {
      if (!stats.containsKey('byTrigger')) {
        stats['byTrigger'] = {};
      }
      
      if (!stats['byTrigger'].containsKey(triggerCategory)) {
        stats['byTrigger'][triggerCategory] = {};
      }
      
      if (!stats['byTrigger'][triggerCategory].containsKey(exerciseId)) {
        stats['byTrigger'][triggerCategory][exerciseId] = {
          'total': 0,
          'effective': 0,
        };
      }
      
      stats['byTrigger'][triggerCategory][exerciseId]['total'] = 
          (stats['byTrigger'][triggerCategory][exerciseId]['total'] ?? 0) + 1;
      
      if (wasEffective) {
        stats['byTrigger'][triggerCategory][exerciseId]['effective'] = 
            (stats['byTrigger'][triggerCategory][exerciseId]['effective'] ?? 0) + 1;
      }
    }
    
    await _prefs.setString(
      _prefsCravingBreathingStats,
      _encodeJson(stats)
    );
  }
  
  /// Gets statistics about breathing exercises and cravings
  Future<Map<String, dynamic>> _getCravingBreathingStats() async {
    final statsString = _prefs.getString(_prefsCravingBreathingStats);
    
    if (statsString != null) {
      return _decodeJson(statsString);
    }
    
    return {};
  }
  
  /// Gets the effectiveness rate of breathing exercises for cravings
  Future<double> getBreathingEffectivenessRate() async {
    final stats = await _getCravingBreathingStats();
    
    if (!stats.containsKey('overall') || 
        stats['overall']['total'] == 0) {
      return 0.0;
    }
    
    final total = stats['overall']['total'] as int;
    final effective = stats['overall']['effective'] as int;
    
    return effective / total;
  }
  
  /// Gets the most effective breathing exercise for cravings
  Future<String?> getMostEffectiveExerciseId() async {
    final stats = await _getCravingBreathingStats();
    
    if (!stats.containsKey('byExercise') || 
        (stats['byExercise'] as Map<String, dynamic>).isEmpty) {
      return null;
    }
    
    // Find the exercise with the highest effectiveness rate
    String? mostEffectiveId;
    double highestRate = 0;
    
    (stats['byExercise'] as Map<String, dynamic>).forEach((exerciseId, data) {
      final total = data['total'] as int;
      final effective = data['effective'] as int;
      
      if (total > 0) {
        final rate = effective / total;
        
        if (rate > highestRate) {
          highestRate = rate;
          mostEffectiveId = exerciseId;
        }
      }
    });
    
    return mostEffectiveId;
  }
  
  /// Gets the most effective breathing exercise for a specific trigger category
  Future<String?> getMostEffectiveExerciseForTrigger(String triggerCategory) async {
    final stats = await _getCravingBreathingStats();
    
    if (!stats.containsKey('byTrigger') || 
        !stats['byTrigger'].containsKey(triggerCategory) ||
        (stats['byTrigger'][triggerCategory] as Map<String, dynamic>).isEmpty) {
      return null;
    }
    
    // Find the exercise with the highest effectiveness rate for this trigger
    String? mostEffectiveId;
    double highestRate = 0;
    
    (stats['byTrigger'][triggerCategory] as Map<String, dynamic>).forEach((exerciseId, data) {
      final total = data['total'] as int;
      final effective = data['effective'] as int;
      
      if (total > 0) {
        final rate = effective / total;
        
        if (rate > highestRate) {
          highestRate = rate;
          mostEffectiveId = exerciseId;
        }
      }
    });
    
    return mostEffectiveId;
  }
  
  /// Gets the average craving intensity reduction by exercise
  Future<Map<String, double>> getAverageCravingReductionByExercise() async {
    final reductionData = await _getCravingReductionData();
    
    if (reductionData.isEmpty) {
      return {};
    }
    
    // Group by exercise ID
    final Map<String, List<int>> reductionsByExercise = {};
    
    reductionData.forEach((_, data) {
      final exerciseId = data['exerciseId'] as String;
      final reduction = data['reduction'] as int;
      
      if (!reductionsByExercise.containsKey(exerciseId)) {
        reductionsByExercise[exerciseId] = [];
      }
      
      reductionsByExercise[exerciseId]!.add(reduction);
    });
    
    // Calculate averages
    final Map<String, double> averageReductions = {};
    
    reductionsByExercise.forEach((exerciseId, reductions) {
      if (reductions.isNotEmpty) {
        final total = reductions.reduce((a, b) => a + b);
        averageReductions[exerciseId] = total / reductions.length;
      }
    });
    
    return averageReductions;
  }
  
  /// Gets the effectiveness of breathing exercises by trigger category
  Future<Map<String, Map<String, double>>> getEffectivenessByTriggerCategory() async {
    final stats = await _getCravingBreathingStats();
    
    if (!stats.containsKey('byTrigger')) {
      return {};
    }
    
    final Map<String, Map<String, double>> result = {};
    
    (stats['byTrigger'] as Map<String, dynamic>).forEach((trigger, exercises) {
      result[trigger] = {};
      
      (exercises as Map<String, dynamic>).forEach((exerciseId, data) {
        final total = data['total'] as int;
        final effective = data['effective'] as int;
        
        if (total > 0) {
          result[trigger]![exerciseId] = effective / total;
        }
      });
    });
    
    return result;
  }
  
  /// Gets correlation data for analytics
  Future<Map<String, dynamic>> getCorrelationAnalytics() async {
    final correlations = await _getCravingBreathingCorrelations();
    final stats = await _getCravingBreathingStats();
    final reductionData = await _getCravingReductionData();
    
    return {
      'totalCorrelations': correlations.length,
      'stats': stats,
      'reductionData': reductionData,
      'effectivenessRate': await getBreathingEffectivenessRate(),
      'mostEffectiveExercise': await getMostEffectiveExerciseId(),
      'averageReduction': await getAverageCravingReductionByExercise(),
      'effectivenessByTrigger': await getEffectivenessByTriggerCategory(),
    };
  }
  
  /// Sets the last suggested exercise ID
  Future<void> setLastSuggestedExercise(String exerciseId) async {
    await _prefs.setString(_prefsLastSuggestedExercise, exerciseId);
  }
  
  /// Gets the last suggested exercise ID
  String? getLastSuggestedExerciseId() {
    return _prefs.getString(_prefsLastSuggestedExercise);
  }
  
  /// Helper method to encode JSON
  String _encodeJson(Map<String, dynamic> data) {
    return const JsonEncoder().convert(data);
  }
  
  /// Helper method to decode JSON
  Map<String, dynamic> _decodeJson(String jsonString) {
    return const JsonDecoder().convert(jsonString) as Map<String, dynamic>;
  }
}

/// Widget that shows a breathing exercise suggestion after logging a craving
class BreathingExerciseSuggestion extends StatelessWidget {
  final CravingModel craving;
  final BreathingExerciseModel exercise;
  final VoidCallback onStartExercise;
  final VoidCallback onDismiss;
  
  const BreathingExerciseSuggestion({
    Key? key,
    required this.craving,
    required this.exercise,
    required this.onStartExercise,
    required this.onDismiss,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.spa,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'Breathing Exercise Suggestion',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onDismiss,
                  tooltip: 'Dismiss',
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              'Try this breathing exercise to help with your craving:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.air,
                    size: 32,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        exercise.benefitsDescription,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Duration: ${exercise.recommendedDuration ~/ 60} minutes',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onDismiss,
                  child: const Text('Maybe Later'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: onStartExercise,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Start Now'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}