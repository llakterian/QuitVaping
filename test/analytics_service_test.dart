import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:quit_vaping/lib/data/models/analytics_models.dart';
import 'package:quit_vaping/lib/data/models/mcp_model.dart';
import 'package:quit_vaping/lib/data/services/analytics_service.dart';
import 'package:quit_vaping/lib/data/services/mcp_manager_service.dart';

import 'analytics_service_test.mocks.dart';

@GenerateMocks([MCPManagerService])
void main() {
  group('AnalyticsService Tests', () {
    late AnalyticsService analyticsService;
    late MockMCPManagerService mockMCPManager;

    setUp(() {
      mockMCPManager = MockMCPManagerService();
      analyticsService = AnalyticsService(mockMCPManager);
    });

    tearDown(() async {
      await analyticsService.dispose();
    });

    group('Data Analysis Workflow', () {
      test('should create data analysis workflow successfully', () async {
        // Arrange
        final context = AnalyticsWorkflowContext(
          userId: 'test_user_001',
          startDate: DateTime(2024, 11, 1),
          endDate: DateTime(2024, 12, 1),
          analysisTypes: ['pattern_recognition', 'predictive_modeling'],
          userProfile: {
            'quitDate': '2024-10-01T00:00:00Z',
            'vapingHistory': {'dailyUsage': 20, 'duration': '2_years'}
          },
        );

        final mockResponse = MCPResponse(
          id: 'test_response_001',
          serverId: 'analytics-server',
          responseType: MCPResponseType.analytics,
          data: {
            'dataPoints': [
              {
                'id': 'dp_001',
                'userId': 'test_user_001',
                'metricType': 'pattern_recognition_metric',
                'value': 75.5,
                'timestamp': '2024-12-01T10:00:00Z',
                'metadata': {'source': 'ai_workflow', 'confidence': 0.85},
                'category': 'workflow_generated',
                'source': 'analytics_mcp_server'
              }
            ],
            'workflowId': 'workflow_001',
            'status': 'completed'
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.sendRequest(any)).thenAnswer((_) async => mockResponse);

        // Act
        final result = await analyticsService.createDataAnalysisWorkflow(context);

        // Assert
        expect(result, isNotEmpty);
        expect(result.first.userId, equals('test_user_001'));
        expect(result.first.metricType, equals('pattern_recognition_metric'));
        expect(result.first.value, equals(75.5));
        verify(mockMCPManager.sendRequest(any)).called(1);
      });

      test('should handle workflow creation failure gracefully', () async {
        // Arrange
        final context = AnalyticsWorkflowContext(
          userId: 'test_user_001',
          startDate: DateTime(2024, 11, 1),
          endDate: DateTime(2024, 12, 1),
          analysisTypes: ['pattern_recognition'],
          userProfile: {},
        );

        final errorResponse = MCPResponse(
          id: 'error_response_001',
          serverId: 'analytics-server',
          responseType: MCPResponseType.error,
          data: {},
          timestamp: DateTime.now(),
          error: 'Server connection failed',
        );

        when(mockMCPManager.sendRequest(any)).thenAnswer((_) async => errorResponse);

        // Act
        final result = await analyticsService.createDataAnalysisWorkflow(context);

        // Assert
        expect(result, isNotEmpty); // Should return fallback data
        expect(result.first.source, equals('local_analytics'));
        verify(mockMCPManager.sendRequest(any)).called(1);
      });
    });

    group('Predictive Modeling', () {
      test('should predict quit success probability accurately', () async {
        // Arrange
        const userId = 'test_user_001';
        final recentData = [
          AnalyticsDataPoint(
            id: 'data_001',
            userId: userId,
            metricType: 'mood_score',
            value: 75.0,
            timestamp: DateTime.now().subtract(const Duration(days: 1)),
            metadata: {'source': 'user_input'},
          ),
          AnalyticsDataPoint(
            id: 'data_002',
            userId: userId,
            metricType: 'craving_intensity',
            value: 30.0,
            timestamp: DateTime.now().subtract(const Duration(hours: 12)),
            metadata: {'source': 'real_time_tracking'},
          ),
        ];

        final mockResponse = MCPResponse(
          id: 'prediction_response_001',
          serverId: 'analytics-server',
          responseType: MCPResponseType.analytics,
          data: {
            'id': 'prediction_001',
            'userId': userId,
            'successProbability': 0.87,
            'confidence': 0.85,
            'predictionDate': DateTime.now().toIso8601String(),
            'timeHorizon': '30_days',
            'positiveFactors': ['consistent_engagement', 'positive_mood_trend'],
            'riskFactors': ['occasional_stress_spikes'],
            'recommendations': ['maintain_current_routine', 'prepare_for_challenges'],
            'modelMetrics': {
              'accuracy': 0.82,
              'precision': 0.79,
              'recall': 0.85,
              'f1_score': 0.82
            }
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.sendRequest(any)).thenAnswer((_) async => mockResponse);

        // Act
        final result = await analyticsService.predictQuitSuccess(userId, recentData);

        // Assert
        expect(result.userId, equals(userId));
        expect(result.successProbability, equals(0.87));
        expect(result.confidence, equals(0.85));
        expect(result.positiveFactors, contains('consistent_engagement'));
        expect(result.recommendations, contains('maintain_current_routine'));
        verify(mockMCPManager.sendRequest(any)).called(1);
      });

      test('should emit prediction results to stream', () async {
        // Arrange
        const userId = 'test_user_001';
        final recentData = <AnalyticsDataPoint>[];

        final mockResponse = MCPResponse(
          id: 'prediction_response_002',
          serverId: 'analytics-server',
          responseType: MCPResponseType.analytics,
          data: {
            'id': 'prediction_002',
            'userId': userId,
            'successProbability': 0.75,
            'confidence': 0.80,
            'predictionDate': DateTime.now().toIso8601String(),
            'timeHorizon': '30_days',
            'positiveFactors': ['app_usage'],
            'riskFactors': ['stress_indicators'],
            'recommendations': ['increase_support'],
            'modelMetrics': {'accuracy': 0.80}
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.sendRequest(any)).thenAnswer((_) async => mockResponse);

        // Act & Assert
        expectLater(
          analyticsService.predictionStream,
          emits(isA<PredictiveModelResult>()
              .having((p) => p.userId, 'userId', userId)
              .having((p) => p.modelType, 'modelType', 'quit_success')
              .having((p) => p.prediction, 'prediction', 0.75)),
        );

        await analyticsService.predictQuitSuccess(userId, recentData);
      });
    });

    group('Pattern Recognition', () {
      test('should recognize behavioral patterns successfully', () async {
        // Arrange
        const userId = 'test_user_001';
        final data = [
          AnalyticsDataPoint(
            id: 'pattern_data_001',
            userId: userId,
            metricType: 'craving_level',
            value: 80.0,
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
            metadata: {'context': 'morning_routine'},
          ),
          AnalyticsDataPoint(
            id: 'pattern_data_002',
            userId: userId,
            metricType: 'craving_level',
            value: 85.0,
            timestamp: DateTime.now().subtract(const Duration(hours: 1)),
            metadata: {'context': 'work_stress'},
          ),
        ];

        final patternTypes = [PatternType.craving, PatternType.trigger];

        final mockResponse = MCPResponse(
          id: 'pattern_response_001',
          serverId: 'analytics-server',
          responseType: MCPResponseType.analytics,
          data: {
            'patterns': [
              {
                'id': 'pattern_001',
                'userId': userId,
                'patternType': 'craving',
                'description': 'Morning craving pattern detected',
                'confidence': 0.85,
                'detectedAt': DateTime.now().toIso8601String(),
                'patternData': {'frequency': 0.8, 'intensity': 'high'},
                'triggers': ['morning_routine', 'work_stress'],
                'recommendations': ['breathing_exercises', 'distraction_techniques'],
                'supportingData': []
              }
            ]
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.sendRequest(any)).thenAnswer((_) async => mockResponse);

        // Act
        final result = await analyticsService.recognizePatterns(userId, data, patternTypes);

        // Assert
        expect(result, hasLength(1));
        expect(result.first.userId, equals(userId));
        expect(result.first.patternType, equals('craving'));
        expect(result.first.confidence, equals(0.85));
        expect(result.first.triggers, contains('morning_routine'));
        verify(mockMCPManager.sendRequest(any)).called(1);
      });

      test('should emit pattern results to stream', () async {
        // Arrange
        const userId = 'test_user_001';
        final data = <AnalyticsDataPoint>[];
        final patternTypes = [PatternType.mood];

        final mockResponse = MCPResponse(
          id: 'pattern_response_002',
          serverId: 'analytics-server',
          responseType: MCPResponseType.analytics,
          data: {
            'patterns': [
              {
                'id': 'pattern_002',
                'userId': userId,
                'patternType': 'mood',
                'description': 'Mood improvement pattern',
                'confidence': 0.75,
                'detectedAt': DateTime.now().toIso8601String(),
                'patternData': {'trend': 'positive'},
                'triggers': ['milestone_achievements'],
                'recommendations': ['maintain_momentum'],
                'supportingData': []
              }
            ]
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.sendRequest(any)).thenAnswer((_) async => mockResponse);

        // Act & Assert
        expectLater(
          analyticsService.patternStream,
          emits(isA<PatternRecognitionResult>()
              .having((p) => p.userId, 'userId', userId)
              .having((p) => p.patternType, 'patternType', 'mood')
              .having((p) => p.confidence, 'confidence', 0.75)),
        );

        await analyticsService.recognizePatterns(userId, data, patternTypes);
      });
    });

    group('Report Generation', () {
      test('should generate personalized report successfully', () async {
        // Arrange
        const userId = 'test_user_001';
        const reportType = 'comprehensive';
        final preferences = {
          'timeRange': '30_days',
          'includeVisualizations': true,
          'shareable': false
        };

        final mockResponse = MCPResponse(
          id: 'report_response_001',
          serverId: 'analytics-server',
          responseType: MCPResponseType.analytics,
          data: {
            'id': 'report_001',
            'userId': userId,
            'reportType': reportType,
            'generatedAt': DateTime.now().toIso8601String(),
            'reportData': {'analysisDepth': 'comprehensive'},
            'sections': [
              {
                'title': 'Progress Summary',
                'content': 'Excellent progress in your quit journey',
                'sectionType': 'summary',
                'data': {'overallProgress': 'positive'},
                'visualizations': ['progress_chart'],
                'recommendations': ['maintain_routine']
              }
            ],
            'keyFindings': ['consistent_engagement', 'positive_trends'],
            'actionableRecommendations': ['continue_current_approach'],
            'isShareable': false
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.sendRequest(any)).thenAnswer((_) async => mockResponse);

        // Act
        final result = await analyticsService.generatePersonalizedReport(
          userId,
          reportType,
          preferences,
        );

        // Assert
        expect(result.userId, equals(userId));
        expect(result.reportType, equals(reportType));
        expect(result.sections, hasLength(1));
        expect(result.sections.first.title, equals('Progress Summary'));
        expect(result.keyFindings, contains('consistent_engagement'));
        verify(mockMCPManager.sendRequest(any)).called(1);
      });

      test('should emit report to stream when generated', () async {
        // Arrange
        const userId = 'test_user_001';
        const reportType = 'weekly';
        final preferences = <String, dynamic>{};

        final mockResponse = MCPResponse(
          id: 'report_response_002',
          serverId: 'analytics-server',
          responseType: MCPResponseType.analytics,
          data: {
            'id': 'report_002',
            'userId': userId,
            'reportType': reportType,
            'generatedAt': DateTime.now().toIso8601String(),
            'reportData': {},
            'sections': [],
            'keyFindings': [],
            'actionableRecommendations': [],
            'isShareable': false
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.sendRequest(any)).thenAnswer((_) async => mockResponse);

        // Act & Assert
        expectLater(
          analyticsService.reportStream,
          emits(isA<PersonalizedReport>()
              .having((r) => r.userId, 'userId', userId)
              .having((r) => r.reportType, 'reportType', reportType)),
        );

        await analyticsService.generatePersonalizedReport(userId, reportType, preferences);
      });
    });

    group('Risk Assessment', () {
      test('should perform risk assessment accurately', () async {
        // Arrange
        const userId = 'test_user_001';
        final recentData = [
          AnalyticsDataPoint(
            id: 'risk_data_001',
            userId: userId,
            metricType: 'stress_level',
            value: 85.0,
            timestamp: DateTime.now().subtract(const Duration(hours: 2)),
            metadata: {'source': 'biometric'},
          ),
        ];

        final mockResponse = MCPResponse(
          id: 'risk_response_001',
          serverId: 'analytics-server',
          responseType: MCPResponseType.analytics,
          data: {
            'overallRisk': 'moderate',
            'riskScore': 0.6,
            'riskFactors': ['elevated_stress', 'mood_decline'],
            'protectiveFactors': ['strong_support_system'],
            'recommendations': ['increase_monitoring', 'stress_management'],
            'confidence': 0.8,
            'lastAssessed': DateTime.now().toIso8601String()
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.sendRequest(any)).thenAnswer((_) async => mockResponse);

        // Act
        final result = await analyticsService.performAnalysis('user123');
 
       // Assert
        expect(result, isNotNull);
        expect(result.data['patterns'], isNotEmpty);
        verify(mockMCPManager.sendRequest(any)).called(1);
      });
    });
  });
}