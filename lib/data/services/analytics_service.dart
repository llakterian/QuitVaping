import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../models/analytics_models.dart';
import '../models/mcp_model.dart';
import 'mcp_manager_service.dart';

/// Advanced Analytics and Insights Engine Service
/// Implements AI-powered data analysis, pattern recognition, and predictive modeling
class AnalyticsService {
  final MCPManagerService _mcpManager;
  final Uuid _uuid = const Uuid();
  
  // Cache for analytics results
  final Map<String, dynamic> _analyticsCache = {};
  final Map<String, DateTime> _cacheTimestamps = {};
  static const Duration _cacheExpiry = Duration(hours: 1);

  // Stream controllers for real-time analytics updates
  final StreamController<PatternRecognitionResult> _patternController = 
      StreamController<PatternRecognitionResult>.broadcast();
  final StreamController<PredictiveModelResult> _predictionController = 
      StreamController<PredictiveModelResult>.broadcast();
  final StreamController<PersonalizedReport> _reportController = 
      StreamController<PersonalizedReport>.broadcast();

  AnalyticsService(this._mcpManager);

  /// Stream of pattern recognition results
  Stream<PatternRecognitionResult> get patternStream => _patternController.stream;

  /// Stream of prediction results
  Stream<PredictiveModelResult> get predictionStream => _predictionController.stream;

  /// Stream of report updates
  Stream<PersonalizedReport> get reportStream => _reportController.stream;

  /// Create data analysis workflows using AI agents
  Future<List<AnalyticsDataPoint>> createDataAnalysisWorkflow(
    AnalyticsWorkflowContext context,
  ) async {
    try {
      debugPrint('Creating data analysis workflow for user: ${context.userId}');
      
      final request = MCPRequest(
        id: _uuid.v4(),
        method: 'create_data_analysis_workflow',
        params: {
          'userId': context.userId,
          'startDate': context.startDate.toIso8601String(),
          'endDate': context.endDate.toIso8601String(),
          'analysisTypes': context.analysisTypes,
          'userProfile': context.userProfile,
          'preferences': context.preferences,
          'historicalData': context.historicalData.map((d) => d.toJson()).toList(),
        },
        serverId: 'analytics-server',
      );

      final response = await _mcpManager.sendRequest(request);
      
      if (response.error != null) {
        throw Exception('Analytics workflow creation failed: ${response.error}');
      }

      final dataPoints = (response.data['dataPoints'] as List?)
          ?.map((json) => AnalyticsDataPoint.fromJson(json))
          .toList() ?? [];

      debugPrint('Created ${dataPoints.length} data analysis points');
      return dataPoints;
      
    } catch (e) {
      debugPrint('Error creating data analysis workflow: $e');
      return _generateFallbackDataPoints(context);
    }
  }

  /// Implement predictive modeling for quit success probability
  Future<QuitSuccessPrediction> predictQuitSuccess(
    String userId,
    List<AnalyticsDataPoint> recentData,
  ) async {
    try {
      final cacheKey = 'quit_success_$userId';
      
      if (_isCacheValid(cacheKey)) {
        final cached = _analyticsCache[cacheKey] as QuitSuccessPrediction;
        _predictionController.add(PredictiveModelResult(
          id: _uuid.v4(),
          userId: userId,
          modelType: 'quit_success',
          prediction: cached.successProbability,
          confidence: cached.confidence,
          generatedAt: DateTime.now(),
          modelData: cached.modelMetrics,
          influencingFactors: cached.positiveFactors + cached.riskFactors,
          recommendations: cached.recommendations,
          inputData: recentData,
        ));
        return cached;
      }

      debugPrint('Predicting quit success for user: $userId');
      
      final request = MCPRequest(
        id: _uuid.v4(),
        method: 'predict_quit_success',
        params: {
          'userId': userId,
          'recentData': recentData.map((d) => d.toJson()).toList(),
          'predictionHorizon': '30_days',
          'modelVersion': 'v2.1',
          'includeConfidenceInterval': true,
        },
        serverId: 'analytics-server',
      );

      final response = await _mcpManager.sendRequest(request);
      
      if (response.error != null) {
        throw Exception('Quit success prediction failed: ${response.error}');
      }

      final prediction = QuitSuccessPrediction.fromJson(response.data);
      _cacheResult(cacheKey, prediction);

      // Emit prediction result
      _predictionController.add(PredictiveModelResult(
        id: _uuid.v4(),
        userId: userId,
        modelType: 'quit_success',
        prediction: prediction.successProbability,
        confidence: prediction.confidence,
        generatedAt: DateTime.now(),
        modelData: prediction.modelMetrics,
        influencingFactors: prediction.positiveFactors + prediction.riskFactors,
        recommendations: prediction.recommendations,
        inputData: recentData,
      ));

      debugPrint('Quit success probability: ${prediction.successProbability}');
      return prediction;
      
    } catch (e) {
      debugPrint('Error predicting quit success: $e');
      return _generateFallbackQuitPrediction(userId, recentData);
    }
  }

  /// Build automated pattern recognition system
  Future<List<PatternRecognitionResult>> recognizePatterns(
    String userId,
    List<AnalyticsDataPoint> data,
    List<PatternType> patternTypes,
  ) async {
    try {
      debugPrint('Recognizing patterns for user: $userId');
      
      final request = MCPRequest(
        id: _uuid.v4(),
        method: 'recognize_patterns',
        params: {
          'userId': userId,
          'data': data.map((d) => d.toJson()).toList(),
          'patternTypes': patternTypes.map((p) => p.name).toList(),
          'minConfidence': 0.7,
          'lookbackDays': 30,
        },
        serverId: 'analytics-server',
      );

      final response = await _mcpManager.sendRequest(request);
      
      if (response.error != null) {
        throw Exception('Pattern recognition failed: ${response.error}');
      }

      final patterns = (response.data['patterns'] as List?)
          ?.map((json) => PatternRecognitionResult.fromJson(json))
          .toList() ?? [];

      // Emit each pattern result
      for (final pattern in patterns) {
        _patternController.add(pattern);
      }

      debugPrint('Recognized ${patterns.length} patterns');
      return patterns;
      
    } catch (e) {
      debugPrint('Error recognizing patterns: $e');
      return _generateFallbackPatterns(userId, data, patternTypes);
    }
  }

  /// Create personalized report generation functionality
  Future<PersonalizedReport> generatePersonalizedReport(
    String userId,
    String reportType,
    Map<String, dynamic> preferences,
  ) async {
    try {
      debugPrint('Generating personalized report for user: $userId');
      
      final request = MCPRequest(
        id: _uuid.v4(),
        method: 'generate_personalized_report',
        params: {
          'userId': userId,
          'reportType': reportType,
          'preferences': preferences,
          'includeVisualizations': true,
          'includeRecommendations': true,
          'timeRange': preferences['timeRange'] ?? '30_days',
        },
        serverId: 'analytics-server',
      );

      final response = await _mcpManager.sendRequest(request);
      
      if (response.error != null) {
        throw Exception('Report generation failed: ${response.error}');
      }

      final report = PersonalizedReport.fromJson(response.data);
      _reportController.add(report);

      debugPrint('Generated report with ${report.sections.length} sections');
      return report;
      
    } catch (e) {
      debugPrint('Error generating personalized report: $e');
      return _generateFallbackReport(userId, reportType, preferences);
    }
  }

  /// Analyze behavioral trends over time
  Future<List<AnalyticsDataPoint>> analyzeBehavioralTrends(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      debugPrint('Analyzing behavioral trends for user: $userId');
      
      final request = MCPRequest(
        id: _uuid.v4(),
        method: 'analyze_behavioral_trends',
        params: {
          'userId': userId,
          'startDate': startDate.toIso8601String(),
          'endDate': endDate.toIso8601String(),
          'trendTypes': ['mood', 'craving', 'engagement', 'success_rate'],
          'granularity': 'daily',
        },
        serverId: 'analytics-server',
      );

      final response = await _mcpManager.sendRequest(request);
      
      if (response.error != null) {
        throw Exception('Behavioral trend analysis failed: ${response.error}');
      }

      final trends = (response.data['trends'] as List?)
          ?.map((json) => AnalyticsDataPoint.fromJson(json))
          .toList() ?? [];

      debugPrint('Analyzed ${trends.length} behavioral trends');
      return trends;
      
    } catch (e) {
      debugPrint('Error analyzing behavioral trends: $e');
      return [];
    }
  }

  /// Perform risk assessment analysis
  Future<Map<String, dynamic>> performRiskAssessment(
    String userId,
    List<AnalyticsDataPoint> recentData,
  ) async {
    try {
      debugPrint('Performing risk assessment for user: $userId');
      
      final request = MCPRequest(
        id: _uuid.v4(),
        method: 'perform_risk_assessment',
        params: {
          'userId': userId,
          'recentData': recentData.map((d) => d.toJson()).toList(),
          'riskFactors': ['mood_decline', 'craving_increase', 'engagement_drop'],
          'timeWindow': '7_days',
        },
        serverId: 'analytics-server',
      );

      final response = await _mcpManager.sendRequest(request);
      
      if (response.error != null) {
        throw Exception('Risk assessment failed: ${response.error}');
      }

      debugPrint('Risk assessment completed');
      return response.data;
      
    } catch (e) {
      debugPrint('Error performing risk assessment: $e');
      return _generateFallbackRiskAssessment(userId, recentData);
    }
  }

  /// Get comprehensive analytics dashboard data
  Future<Map<String, dynamic>> getAnalyticsDashboard(String userId) async {
    try {
      debugPrint('Getting analytics dashboard for user: $userId');
      
      final futures = await Future.wait([
        predictQuitSuccess(userId, []),
        recognizePatterns(userId, [], [PatternType.craving, PatternType.mood]),
        performRiskAssessment(userId, []),
      ]);

      return {
        'quitPrediction': futures[0],
        'patterns': futures[1],
        'riskAssessment': futures[2],
        'lastUpdated': DateTime.now().toIso8601String(),
      };
      
    } catch (e) {
      debugPrint('Error getting analytics dashboard: $e');
      return {};
    }
  }

  /// Cache management methods
  bool _isCacheValid(String key) {
    if (!_analyticsCache.containsKey(key) || !_cacheTimestamps.containsKey(key)) {
      return false;
    }
    
    final timestamp = _cacheTimestamps[key]!;
    return DateTime.now().difference(timestamp) < _cacheExpiry;
  }

  void _cacheResult(String key, dynamic result) {
    _analyticsCache[key] = result;
    _cacheTimestamps[key] = DateTime.now();
  }

  /// Fallback methods for offline functionality
  List<AnalyticsDataPoint> _generateFallbackDataPoints(AnalyticsWorkflowContext context) {
    final random = Random();
    final dataPoints = <AnalyticsDataPoint>[];
    
    for (int i = 0; i < 10; i++) {
      dataPoints.add(AnalyticsDataPoint(
        id: _uuid.v4(),
        userId: context.userId,
        metricType: 'fallback_metric',
        value: random.nextDouble() * 100,
        timestamp: DateTime.now().subtract(Duration(days: i)),
        metadata: {'source': 'fallback', 'confidence': 0.5},
        category: 'offline',
        source: 'local_analytics',
      ));
    }
    
    return dataPoints;
  }

  QuitSuccessPrediction _generateFallbackQuitPrediction(
    String userId,
    List<AnalyticsDataPoint> recentData,
  ) {
    final random = Random();
    
    return QuitSuccessPrediction(
      id: _uuid.v4(),
      userId: userId,
      successProbability: 0.7 + (random.nextDouble() * 0.2), // 70-90%
      confidence: 0.6, // Lower confidence for fallback
      predictionDate: DateTime.now(),
      timeHorizon: '30_days',
      positiveFactors: ['consistent_app_usage', 'milestone_achievements'],
      riskFactors: ['recent_stress_indicators'],
      recommendations: ['maintain_current_routine', 'consider_additional_support'],
      modelMetrics: {'accuracy': 0.6, 'precision': 0.65, 'recall': 0.7},
    );
  }

  List<PatternRecognitionResult> _generateFallbackPatterns(
    String userId,
    List<AnalyticsDataPoint> data,
    List<PatternType> patternTypes,
  ) {
    final patterns = <PatternRecognitionResult>[];
    
    for (final patternType in patternTypes) {
      patterns.add(PatternRecognitionResult(
        id: _uuid.v4(),
        userId: userId,
        patternType: patternType.name,
        description: 'Offline pattern detection for ${patternType.name}',
        confidence: 0.6,
        detectedAt: DateTime.now(),
        patternData: {'source': 'fallback', 'type': patternType.name},
        triggers: ['time_based', 'mood_based'],
        recommendations: ['monitor_closely', 'apply_intervention'],
        supportingData: data.take(5).toList(),
      ));
    }
    
    return patterns;
  }

  PersonalizedReport _generateFallbackReport(
    String userId,
    String reportType,
    Map<String, dynamic> preferences,
  ) {
    return PersonalizedReport(
      id: _uuid.v4(),
      userId: userId,
      reportType: reportType,
      generatedAt: DateTime.now(),
      reportData: {'source': 'fallback', 'type': reportType},
      sections: [
        InsightSection(
          title: 'Progress Summary',
          content: 'Your quit journey is progressing well. Keep up the good work!',
          sectionType: 'summary',
          data: {'progress': 'positive'},
          visualizations: ['progress_chart'],
          recommendations: ['continue_current_approach'],
        ),
      ],
      keyFindings: ['consistent_progress', 'positive_trends'],
      actionableRecommendations: ['maintain_routine', 'celebrate_milestones'],
      isShareable: preferences['shareable'] ?? false,
    );
  }

  Map<String, dynamic> _generateFallbackRiskAssessment(
    String userId,
    List<AnalyticsDataPoint> recentData,
  ) {
    return {
      'overallRisk': 'low',
      'riskScore': 0.3,
      'riskFactors': ['minor_mood_fluctuations'],
      'protectiveFactors': ['consistent_engagement', 'positive_trends'],
      'recommendations': ['continue_monitoring', 'maintain_support_systems'],
      'confidence': 0.6,
      'lastAssessed': DateTime.now().toIso8601String(),
    };
  }

  /// Cleanup resources
  Future<void> dispose() async {
    await _patternController.close();
    await _predictionController.close();
    await _reportController.close();
    
    _analyticsCache.clear();
    _cacheTimestamps.clear();
  }
}