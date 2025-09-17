import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:quit_vaping/data/services/smart_nrt_service.dart';
import 'package:quit_vaping/data/services/mcp_manager_service.dart';
import 'package:quit_vaping/data/services/nrt_service.dart';
import 'package:quit_vaping/data/models/smart_nrt_models.dart';
import 'package:quit_vaping/data/models/mcp_model.dart';
import 'package:quit_vaping/data/models/health_models.dart';
import 'package:quit_vaping/data/models/nrt_model.dart';

@GenerateMocks([MCPManagerService, NRTService])
import 'smart_nrt_service_test.mocks.dart';

void main() {
  group('SmartNRTService', () {
    late SmartNRTService smartNRTService;
    late MockMCPManagerService mockMCPManager;
    late MockNRTService mockNRTService;

    setUp(() {
      mockMCPManager = MockMCPManagerService();
      mockNRTService = MockNRTService();
      smartNRTService = SmartNRTService(mockMCPManager, mockNRTService);
    });

    group('generatePersonalizedProtocol', () {
      test('should generate protocol successfully', () async {
        // Arrange
        const userId = 'test-user-id';
        final mockResponse = MCPResponse(
          id: 'test-id',
          serverId: 'health-data-server',
          responseType: MCPResponseType.health,
          data: {
            'recommendedNrtType': 'patch',
            'dosageSchedule': [
              {'week': '1', 'dosage': '21mg'},
              {'week': '7', 'dosage': '14mg'},
            ],
            'durationWeeks': 12,
            'monitoringSchedule': ['Weekly assessment'],
            'successIndicators': ['Reduced symptoms'],
            'safetyWarnings': ['Do not smoke while using NRT'],
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.getNRTProtocols(any, any))
            .thenAnswer((_) async => mockResponse);

        // Act
        await smartNRTService.generatePersonalizedProtocol(userId);

        // Assert
        expect(smartNRTService.currentProtocol, isNotNull);
        expect(smartNRTService.currentProtocol!.recommendedNrtType, equals('patch'));
        expect(smartNRTService.currentProtocol!.durationWeeks, equals(12));
        verify(mockMCPManager.getNRTProtocols(userId, any)).called(1);
      });

      test('should handle MCP service failure gracefully', () async {
        // Arrange
        const userId = 'test-user-id';
        final mockResponse = MCPResponse(
          id: 'test-id',
          serverId: 'health-data-server',
          responseType: MCPResponseType.error,
          data: {},
          timestamp: DateTime.now(),
          error: 'Service unavailable',
        );

        when(mockMCPManager.getNRTProtocols(any, any))
            .thenAnswer((_) async => mockResponse);

        // Act
        await smartNRTService.generatePersonalizedProtocol(userId);

        // Assert
        expect(smartNRTService.currentProtocol, isNull);
        verify(mockMCPManager.getNRTProtocols(userId, any)).called(1);
      });
    });

    group('calculatePersonalizedDosage', () {
      test('should calculate dosage based on symptoms', () async {
        // Arrange
        const userId = 'test-user-id';
        final recentSymptoms = [
          WithdrawalSymptom(
            id: 'symptom-1',
            userId: userId,
            type: WithdrawalSymptomType.craving,
            severity: 8,
            timestamp: DateTime.now(),
          ),
        ];

        final mockResponse = MCPResponse(
          id: 'test-id',
          serverId: 'health-data-server',
          responseType: MCPResponseType.health,
          data: {
            'recommendedDosage': '21mg',
            'adjustment': 'increase',
            'confidence': 0.9,
            'reasoning': 'High symptom severity',
            'nextReviewDate': DateTime.now().add(const Duration(days: 3)).toIso8601String(),
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.sendRequest(any))
            .thenAnswer((_) async => mockResponse);

        // Act
        final recommendation = await smartNRTService.calculatePersonalizedDosage(
          userId,
          recentSymptoms,
        );

        // Assert
        expect(recommendation.recommendedDosage, equals('21mg'));
        expect(recommendation.adjustment, equals('increase'));
        expect(recommendation.confidence, equals(0.9));
        verify(mockMCPManager.sendRequest(any)).called(1);
      });

      test('should provide fallback calculation when MCP fails', () async {
        // Arrange
        const userId = 'test-user-id';
        final recentSymptoms = [
          WithdrawalSymptom(
            id: 'symptom-1',
            userId: userId,
            type: WithdrawalSymptomType.craving,
            severity: 3,
            timestamp: DateTime.now(),
          ),
        ];

        final mockResponse = MCPResponse(
          id: 'test-id',
          serverId: 'smart-nrt-server',
          responseType: MCPResponseType.error,
          data: {},
          timestamp: DateTime.now(),
          error: 'Service unavailable',
        );

        when(mockMCPManager.sendRequest(any))
            .thenAnswer((_) async => mockResponse);

        // Act
        final recommendation = await smartNRTService.calculatePersonalizedDosage(
          userId,
          recentSymptoms,
        );

        // Assert
        expect(recommendation, isNotNull);
        expect(recommendation.confidence, lessThan(1.0));
        verify(mockMCPManager.sendRequest(any)).called(1);
      });
    });

    group('monitorSafety', () {
      test('should create safety alerts for concerning patterns', () async {
        // Arrange
        const userId = 'test-user-id';
        
        // Mock excessive usage
        when(mockNRTService.nrtUsage).thenReturn(
          List.generate(12, (index) => NRTModel(
            id: 'usage-$index',
            userId: userId,
            type: NRTType.patch,
            nicotineStrength: 14.0,
            timestamp: DateTime.now().subtract(Duration(hours: index)),
            notes: null,
          )),
        );

        final mockResponse = MCPResponse(
          id: 'test-id',
          serverId: 'smart-nrt-server',
          responseType: MCPResponseType.analytics,
          data: {
            'alerts': [
              {
                'id': 'alert-1',
                'userId': userId,
                'type': 'overdose_risk',
                'message': 'Excessive usage detected',
                'severity': 'high',
                'createdAt': DateTime.now().toIso8601String(),
                'acknowledged': false,
              }
            ]
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.sendRequest(any))
            .thenAnswer((_) async => mockResponse);

        // Act
        await smartNRTService.monitorSafety(userId);

        // Assert
        expect(smartNRTService.safetyAlerts.length, greaterThan(0));
        verify(mockMCPManager.sendRequest(any)).called(1);
      });
    });

    group('generateProgressReport', () {
      test('should generate comprehensive progress report', () async {
        // Arrange
        const userId = 'test-user-id';
        final mockResponse = MCPResponse(
          id: 'test-id',
          serverId: 'smart-nrt-server',
          responseType: MCPResponseType.analytics,
          data: {
            'userId': userId,
            'generatedAt': DateTime.now().toIso8601String(),
            'summary': {
              'daysOnNRT': 30,
              'initialDosage': 21.0,
              'currentDosage': 14.0,
              'reductionPercentage': 33.3,
              'symptomsReported': 5,
              'averageSymptomSeverity': 4.2,
              'milestonesAchieved': 3,
            },
            'metrics': [
              {
                'name': 'Adherence Rate',
                'value': 85.0,
                'unit': '%',
                'trend': 'improving',
                'description': 'Consistency in following NRT protocol',
              }
            ],
            'achievements': ['Started NRT protocol'],
            'recommendations': ['Continue current dosage'],
            'overallScore': 0.8,
            'nextReviewDate': DateTime.now().add(const Duration(days: 7)).toIso8601String(),
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.sendRequest(any))
            .thenAnswer((_) async => mockResponse);

        // Act
        final report = await smartNRTService.generateProgressReport(userId);

        // Assert
        expect(report.userId, equals(userId));
        expect(report.summary.daysOnNRT, equals(30));
        expect(report.overallScore, equals(0.8));
        verify(mockMCPManager.sendRequest(any)).called(1);
      });
    });

    group('predictSuccessProbability', () {
      test('should predict success probability', () async {
        // Arrange
        const userId = 'test-user-id';
        final mockResponse = MCPResponse(
          id: 'test-id',
          serverId: 'smart-nrt-server',
          responseType: MCPResponseType.analytics,
          data: {
            'userId': userId,
            'successProbability': 0.75,
            'positiveFactors': ['High adherence to protocol'],
            'riskFactors': [],
            'recommendations': ['Continue following protocol'],
            'predictionDate': DateTime.now().toIso8601String(),
            'predictionHorizonDays': 30,
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.sendRequest(any))
            .thenAnswer((_) async => mockResponse);

        // Act
        final prediction = await smartNRTService.predictSuccessProbability(userId);

        // Assert
        expect(prediction.userId, equals(userId));
        expect(prediction.successProbability, equals(0.75));
        expect(prediction.positiveFactors, contains('High adherence to protocol'));
        verify(mockMCPManager.sendRequest(any)).called(1);
      });
    });

    group('trackWithdrawalSymptom', () {
      test('should track symptom and generate response', () async {
        // Arrange
        const userId = 'test-user-id';
        const symptomType = WithdrawalSymptomType.craving;
        const severity = 7;
        const notes = 'Strong craving after meal';

        final mockResponse = MCPResponse(
          id: 'test-id',
          serverId: 'smart-nrt-server',
          responseType: MCPResponseType.health,
          data: {
            'id': 'response-1',
            'userId': userId,
            'message': 'Try deep breathing exercises',
            'copingStrategies': ['Deep breathing', 'Distraction'],
            'evidenceSources': ['CDC Guidelines'],
            'requiresImmediateAction': false,
            'requiresMedicalAttention': false,
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.sendRequest(any))
            .thenAnswer((_) async => mockResponse);

        // Act
        await smartNRTService.trackWithdrawalSymptom(userId, symptomType, severity, notes);

        // Assert
        expect(smartNRTService.withdrawalSymptoms.length, equals(1));
        final trackedSymptom = smartNRTService.withdrawalSymptoms.first;
        expect(trackedSymptom.type, equals(symptomType));
        expect(trackedSymptom.severity, equals(severity));
        expect(trackedSymptom.notes, equals(notes));
        verify(mockMCPManager.sendRequest(any)).called(1);
      });
    });

    group('assessReductionReadiness', () {
      test('should assess readiness for dosage reduction', () async {
        // Arrange
        const userId = 'test-user-id';
        final mockResponse = MCPResponse(
          id: 'test-id',
          serverId: 'smart-nrt-server',
          responseType: MCPResponseType.analytics,
          data: {
            'isReady': true,
            'readinessScore': 0.8,
            'reasons': ['Low withdrawal symptoms', 'Consistent usage'],
            'recommendedWaitDays': 0,
            'preparationSteps': [],
            'nextAssessmentDate': DateTime.now().add(const Duration(days: 7)).toIso8601String(),
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.sendRequest(any))
            .thenAnswer((_) async => mockResponse);

        // Act
        final assessment = await smartNRTService.assessReductionReadiness(userId);

        // Assert
        expect(assessment.isReady, isTrue);
        expect(assessment.readinessScore, equals(0.8));
        expect(assessment.reasons, contains('Low withdrawal symptoms'));
        verify(mockMCPManager.sendRequest(any)).called(1);
      });

      test('should provide fallback assessment when MCP fails', () async {
        // Arrange
        const userId = 'test-user-id';
        final mockResponse = MCPResponse(
          id: 'test-id',
          serverId: 'smart-nrt-server',
          responseType: MCPResponseType.error,
          data: {},
          timestamp: DateTime.now(),
          error: 'Service unavailable',
        );

        when(mockMCPManager.sendRequest(any))
            .thenAnswer((_) async => mockResponse);

        // Act
        final assessment = await smartNRTService.assessReductionReadiness(userId);

        // Assert
        expect(assessment, isNotNull);
        expect(assessment.readinessScore, greaterThanOrEqualTo(0.0));
        expect(assessment.readinessScore, lessThanOrEqualTo(1.0));
        verify(mockMCPManager.sendRequest(any)).called(1);
      });
    });

    group('acknowledgeSafetyAlert', () {
      test('should acknowledge safety alert', () async {
        // Arrange
        const userId = 'test-user-id';
        const alertId = 'alert-1';
        const userResponse = 'I will be more careful';

        final alert = NRTSafetyAlert(
          id: alertId,
          userId: userId,
          type: NRTSafetyAlertType.usagePatternConcern,
          message: 'Usage pattern concern',
          severity: NRTSafetyAlertSeverity.medium,
          createdAt: DateTime.now(),
        );

        smartNRTService.safetyAlerts.add(alert);

        // Act
        await smartNRTService.acknowledgeSafetyAlert(alertId, userResponse);

        // Assert
        final acknowledgedAlert = smartNRTService.safetyAlerts
            .firstWhere((a) => a.id == alertId);
        expect(acknowledgedAlert.acknowledged, isTrue);
        expect(acknowledgedAlert.userResponse, equals(userResponse));
        expect(acknowledgedAlert.acknowledgedAt, isNotNull);
      });
    });

    group('getMedicalEvidence', () {
      test('should retrieve medical evidence', () async {
        // Arrange
        const query = 'nrt_effectiveness';
        final mockResponse = MCPResponse(
          id: 'test-id',
          serverId: 'smart-nrt-server',
          responseType: MCPResponseType.health,
          data: {
            'evidence': [
              {
                'title': 'NRT Effectiveness Study',
                'source': 'Medical Journal',
                'summary': 'NRT is effective for cessation',
                'relevanceScore': 0.9,
                'publishedDate': '2023-01-01',
                'doi': '10.1000/test',
                'url': 'https://example.com',
              }
            ]
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.sendRequest(any))
            .thenAnswer((_) async => mockResponse);

        // Act
        final evidence = await smartNRTService.getMedicalEvidence(query);

        // Assert
        expect(evidence.length, equals(1));
        expect(evidence.first.title, equals('NRT Effectiveness Study'));
        expect(evidence.first.relevanceScore, equals(0.9));
        verify(mockMCPManager.sendRequest(any)).called(1);
      });
    });
  });
}