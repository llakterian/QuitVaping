import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/mcp_model.dart';
import '../models/health_models.dart';
import 'mcp_manager_service.dart';

/// Service for managing health insights and recovery timeline data
/// Integrates with Health Data MCP Server for personalized health information
class HealthInsightsService {
  final MCPManagerService _mcpManager;
  
  // Cache for health data
  final Map<String, HealthRecoveryTimeline> _timelineCache = {};
  final Map<String, List<HealthBenefit>> _benefitsCache = {};
  final Map<String, NRTProtocol> _nrtCache = {};
  final Map<String, DateTime> _cacheTimestamps = {};
  
  static const Duration _cacheExpiry = Duration(hours: 1);
  static const String _healthDataServerId = 'health-data-server';

  // Stream controllers for real-time updates
  final StreamController<HealthRecoveryTimeline> _timelineController = 
      StreamController<HealthRecoveryTimeline>.broadcast();
  final StreamController<List<HealthBenefit>> _benefitsController = 
      StreamController<List<HealthBenefit>>.broadcast();
  final StreamController<PersonalizedHealthInsights> _insightsController = 
      StreamController<PersonalizedHealthInsights>.broadcast();

  HealthInsightsService(this._mcpManager);

  /// Stream of health recovery timeline updates
  Stream<HealthRecoveryTimeline> get timelineStream => _timelineController.stream;

  /// Stream of health benefits updates
  Stream<List<HealthBenefit>> get benefitsStream => _benefitsController.stream;

  /// Stream of personalized health insights
  Stream<PersonalizedHealthInsights> get insightsStream => _insightsController.stream;

  /// Get personalized health recovery timeline for a user
  Future<HealthRecoveryTimeline> getHealthRecoveryTimeline(String userId, {bool forceRefresh = false}) async {
    final cacheKey = 'timeline_$userId';
    
    if (!forceRefresh && _isCacheValid(cacheKey) && _timelineCache.containsKey(cacheKey)) {
      return _timelineCache[cacheKey]!;
    }

    try {
      final response = await _mcpManager.getHealthRecoveryTimeline(userId);
      
      if (response.responseType == MCPResponseType.health && response.error == null) {
        final timeline = _parseHealthRecoveryTimeline(response.data);
        
        _timelineCache[cacheKey] = timeline;
        _cacheTimestamps[cacheKey] = DateTime.now();
        
        _timelineController.add(timeline);
        return timeline;
      } else {
        throw HealthInsightsException('Failed to get health recovery timeline: ${response.error}');
      }
    } catch (e) {
      debugPrint('Error getting health recovery timeline: $e');
      
      // Return cached data if available, otherwise throw
      if (_timelineCache.containsKey(cacheKey)) {
        return _timelineCache[cacheKey]!;
      }
      
      rethrow;
    }
  }

  /// Get current health benefits based on quit duration
  Future<List<HealthBenefit>> getCurrentHealthBenefits(String userId, {bool forceRefresh = false}) async {
    final cacheKey = 'benefits_$userId';
    
    if (!forceRefresh && _isCacheValid(cacheKey) && _benefitsCache.containsKey(cacheKey)) {
      return _benefitsCache[cacheKey]!;
    }

    try {
      final context = AIWorkflowContext(
        userId: userId,
        currentMood: MoodState.neutral,
        recentActivity: [],
        externalFactors: const ExternalFactors(),
        availableInterventions: [],
        learningData: const UserLearningProfile(),
      );

      final response = await _mcpManager.generateMotivationContent(context);
      
      if (response.responseType == MCPResponseType.health && response.error == null) {
        final benefits = _parseHealthBenefits(response.data);
        
        _benefitsCache[cacheKey] = benefits;
        _cacheTimestamps[cacheKey] = DateTime.now();
        
        _benefitsController.add(benefits);
        return benefits;
      } else {
        throw HealthInsightsException('Failed to get current health benefits: ${response.error}');
      }
    } catch (e) {
      debugPrint('Error getting current health benefits: $e');
      
      // Return cached data if available, otherwise throw
      if (_benefitsCache.containsKey(cacheKey)) {
        return _benefitsCache[cacheKey]!;
      }
      
      rethrow;
    }
  }

  /// Get NRT protocols and recommendations
  Future<NRTProtocol> getNRTProtocols(String userId, UserHealthProfile userProfile, {bool forceRefresh = false}) async {
    final cacheKey = 'nrt_$userId';
    
    if (!forceRefresh && _isCacheValid(cacheKey) && _nrtCache.containsKey(cacheKey)) {
      return _nrtCache[cacheKey]!;
    }

    try {
      final response = await _mcpManager.getNRTProtocols(userId, userProfile.toJson());
      
      if (response.responseType == MCPResponseType.health && response.error == null) {
        final protocol = _parseNRTProtocol(response.data);
        
        _nrtCache[cacheKey] = protocol;
        _cacheTimestamps[cacheKey] = DateTime.now();
        
        return protocol;
      } else {
        throw HealthInsightsException('Failed to get NRT protocols: ${response.error}');
      }
    } catch (e) {
      debugPrint('Error getting NRT protocols: $e');
      
      // Return cached data if available, otherwise throw
      if (_nrtCache.containsKey(cacheKey)) {
        return _nrtCache[cacheKey]!;
      }
      
      rethrow;
    }
  }

  /// Get comprehensive personalized health insights
  Future<PersonalizedHealthInsights> getPersonalizedInsights(String userId, {bool forceRefresh = false}) async {
    try {
      final response = await _mcpManager.createProgressReport(userId);
      
      if (response.responseType == MCPResponseType.analytics && response.error == null) {
        final insights = _parsePersonalizedInsights(response.data);
        
        _insightsController.add(insights);
        return insights;
      } else {
        throw HealthInsightsException('Failed to get personalized insights: ${response.error}');
      }
    } catch (e) {
      debugPrint('Error getting personalized insights: $e');
      rethrow;
    }
  }

  /// Calculate health improvements based on quit duration
  Future<HealthImprovements> calculateHealthImprovements(String userId, DateTime quitDate) async {
    try {
      final quitDuration = DateTime.now().difference(quitDate);
      final days = quitDuration.inDays;
      
      // Calculate improvements based on medical research
      final improvements = HealthImprovements(
        lungCapacityImprovement: _calculateLungCapacityImprovement(days),
        circulationImprovement: _calculateCirculationImprovement(days),
        tasteSmellRecovery: _calculateTasteSmellRecovery(days),
        energyLevelIncrease: _calculateEnergyLevelIncrease(days),
        heartRateImprovement: _calculateHeartRateImprovement(days),
        bloodPressureImprovement: _calculateBloodPressureImprovement(days),
      );
      
      return improvements;
    } catch (e) {
      debugPrint('Error calculating health improvements: $e');
      rethrow;
    }
  }

  /// Calculate financial savings from quitting
  Future<FinancialSavings> calculateFinancialSavings(String userId, DateTime quitDate, double dailyCost) async {
    try {
      final quitDuration = DateTime.now().difference(quitDate);
      final days = quitDuration.inDays;
      
      final totalSaved = days * dailyCost;
      
      final savings = FinancialSavings(
        totalSaved: totalSaved,
        dailySavings: dailyCost,
        weeklySavings: dailyCost * 7,
        monthlySavings: dailyCost * 30,
        yearlySavings: dailyCost * 365,
        daysQuit: days,
      );
      
      return savings;
    } catch (e) {
      debugPrint('Error calculating financial savings: $e');
      rethrow;
    }
  }

  /// Get next health milestone
  Future<HealthMilestone> getNextHealthMilestone(String userId, DateTime quitDate) async {
    try {
      final quitDuration = DateTime.now().difference(quitDate);
      final days = quitDuration.inDays;
      
      final milestones = [
        HealthMilestone(
          days: 1,
          title: "24 Hours Smoke-Free",
          description: "Heart rate and blood pressure begin to normalize",
          achieved: days >= 1,
        ),
        HealthMilestone(
          days: 3,
          title: "72 Hours - Breathing Improves",
          description: "Breathing becomes easier, lung capacity increases",
          achieved: days >= 3,
        ),
        HealthMilestone(
          days: 7,
          title: "1 Week Milestone",
          description: "Major withdrawal symptoms subside",
          achieved: days >= 7,
        ),
        HealthMilestone(
          days: 14,
          title: "2 Weeks - Circulation Improves",
          description: "Blood circulation improves significantly",
          achieved: days >= 14,
        ),
        HealthMilestone(
          days: 30,
          title: "1 Month Milestone",
          description: "Coughing and shortness of breath decrease",
          achieved: days >= 30,
        ),
        HealthMilestone(
          days: 90,
          title: "3 Months - Major Lung Improvement",
          description: "Lung function improves by up to 30%",
          achieved: days >= 90,
        ),
        HealthMilestone(
          days: 180,
          title: "6 Months Milestone",
          description: "Risk of respiratory infections decreases significantly",
          achieved: days >= 180,
        ),
        HealthMilestone(
          days: 365,
          title: "1 Year - Major Health Milestone",
          description: "Risk of heart disease reduced by 50%",
          achieved: days >= 365,
        ),
      ];
      
      // Find next unachieved milestone
      for (final milestone in milestones) {
        if (!milestone.achieved) {
          return milestone.copyWith(
            daysRemaining: milestone.days - days,
          );
        }
      }
      
      // All milestones achieved
      return HealthMilestone(
        days: days,
        title: "All Major Milestones Achieved!",
        description: "Congratulations on your incredible journey",
        achieved: true,
        daysRemaining: 0,
      );
    } catch (e) {
      debugPrint('Error getting next health milestone: $e');
      rethrow;
    }
  }

  /// Check if MCP health server is available
  bool isHealthServerAvailable() {
    return _mcpManager.areServersAvailable([_healthDataServerId]);
  }

  /// Get health server status
  MCPServerStatus? getHealthServerStatus() {
    final statuses = _mcpManager.getServerStatuses();
    return statuses[_healthDataServerId];
  }

  // Private helper methods

  HealthRecoveryTimeline _parseHealthRecoveryTimeline(Map<String, dynamic> data) {
    final timelineData = data['timeline'] as List<dynamic>;
    final benefits = timelineData.map((item) => HealthBenefit.fromJson(item as Map<String, dynamic>)).toList();
    
    return HealthRecoveryTimeline(
      userId: data['user_id'] as String,
      benefits: benefits,
      generatedAt: DateTime.parse(data['generated_at'] as String),
      personalized: data['personalized'] as bool? ?? false,
    );
  }

  List<HealthBenefit> _parseHealthBenefits(Map<String, dynamic> data) {
    final benefitsData = data['benefits'] as List<dynamic>;
    return benefitsData.map((item) => HealthBenefit.fromJson(item as Map<String, dynamic>)).toList();
  }

  NRTProtocol _parseNRTProtocol(Map<String, dynamic> data) {
    return NRTProtocol.fromJson(data['protocols'] as Map<String, dynamic>);
  }

  PersonalizedHealthInsights _parsePersonalizedInsights(Map<String, dynamic> data) {
    return PersonalizedHealthInsights.fromJson(data);
  }

  double _calculateLungCapacityImprovement(int days) {
    // Based on medical research: lung capacity can improve up to 30% over time
    return (days * 0.5).clamp(0.0, 30.0);
  }

  double _calculateCirculationImprovement(int days) {
    // Circulation can improve up to 100% over several months
    return (days * 2.0).clamp(0.0, 100.0);
  }

  double _calculateTasteSmellRecovery(int days) {
    // Taste and smell can recover up to 100% within weeks
    return (days * 3.0).clamp(0.0, 100.0);
  }

  double _calculateEnergyLevelIncrease(int days) {
    // Energy levels can increase up to 50% over time
    return (days * 1.5).clamp(0.0, 50.0);
  }

  double _calculateHeartRateImprovement(int days) {
    // Heart rate improvements are most significant in first few weeks
    if (days < 1) return 0.0;
    if (days < 7) return days * 5.0;
    return (35.0 + (days - 7) * 0.5).clamp(0.0, 50.0);
  }

  double _calculateBloodPressureImprovement(int days) {
    // Blood pressure improvements similar to heart rate
    if (days < 1) return 0.0;
    if (days < 14) return days * 3.0;
    return (42.0 + (days - 14) * 0.3).clamp(0.0, 60.0);
  }

  bool _isCacheValid(String key) {
    if (!_cacheTimestamps.containsKey(key)) return false;
    
    final timestamp = _cacheTimestamps[key]!;
    return DateTime.now().difference(timestamp) < _cacheExpiry;
  }

  /// Clear all cached data
  void clearCache() {
    _timelineCache.clear();
    _benefitsCache.clear();
    _nrtCache.clear();
    _cacheTimestamps.clear();
  }

  /// Dispose of resources
  Future<void> dispose() async {
    await _timelineController.close();
    await _benefitsController.close();
    await _insightsController.close();
    clearCache();
  }
}

/// Custom exception for health insights operations
class HealthInsightsException implements Exception {
  final String message;
  final dynamic originalError;

  HealthInsightsException(this.message, {this.originalError});

  @override
  String toString() => 'HealthInsightsException: $message';
}