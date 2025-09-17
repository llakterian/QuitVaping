import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:quit_vaping/data/models/mcp_model.dart';
import 'package:quit_vaping/data/models/health_models.dart';
import 'package:quit_vaping/data/services/mcp_manager_service.dart';
import 'package:quit_vaping/data/services/health_insights_service.dart';

import 'health_data_mcp_server_test.mocks.dart';

@GenerateMocks([MCPManagerService])
void main() {
  group('Health Data MCP Server Tests', () {
    late MockMCPManagerService mockMCPManager;
    late HealthInsightsService healthInsightsService;

    setUp(() {
      mockMCPManager = MockMCPManagerService();
      healthInsightsService = HealthInsightsService(mockMCPManager);
    });

    tearDown(() {
      healthInsightsService.dispose();
    });

    group('Health Recovery Timeline', () {
      test('should get personalized health recovery timeline', () async {
        // Arrange
        const userId = 'test_user_123';
        final mockResponse = MCPResponse(
          id: 'test_id',
          serverId: 'health-data-server',
          responseType: MCPResponseType.health,
          data: {
            'timeline': [
              {
                'timeDescription': '20 minutes',
                'benefitDescription': 'Heart rate and blood pressure begin to normalize',
                'stage': 'immediate',
                'confidenceLevel': 0.95,
                'personalizationFactors': ['age', 'fitness_level'],
                'achieved': true,
                'personalizedMessage': 'Your young age gives you excellent recovery potential'
              },
              {
                'timeDescription': '12 hours',
                'benefitDescription': 'Carbon monoxide levels normalize, oxygen levels increase',
                'stage': 'immediate',
                'confidenceLevel': 0.92,
                'personalizationFactors': ['daily_usage_level'],
                'achieved': true,
                'personalizedMessage': null
              }
            ],
            'user_id': userId,
            'generated_at': DateTime.now().toIso8601String(),
            'personalized': true
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.getHealthRecoveryTimeline(userId))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result = await healthInsightsService.getHealthRecoveryTimeline(userId);

        // Assert
        expect(result.userId, equals(userId));
        expect(result.benefits.length, equals(2));
        expect(result.benefits[0].timeDescription, equals('20 minutes'));
        expect(result.benefits[0].stage, equals(HealthBenefitStage.immediate));
        expect(result.benefits[0].achieved, isTrue);
        expect(result.personalized, isTrue);

        verify(mockMCPManager.getHealthRecoveryTimeline(userId)).called(1);
      });

      test('should handle MCP server error gracefully', () async {
        // Arrange
        const userId = 'test_user_123';
        final mockResponse = MCPResponse(
          id: 'test_id',
          serverId: 'health-data-server',
          responseType: MCPResponseType.error,
          data: {},
          timestamp: DateTime.now(),
          error: 'Server unavailable',
        );

        when(mockMCPManager.getHealthRecoveryTimeline(userId))
            .thenAnswer((_) async => mockResponse);

        // Act & Assert
        expect(
          () => healthInsightsService.getHealthRecoveryTimeline(userId),
          throwsA(isA<HealthInsightsException>()),
        );
      });

      test('should use cached data when available', () async {
        // Arrange
        const userId = 'test_user_123';
        final mockResponse = MCPResponse(
          id: 'test_id',
          serverId: 'health-data-server',
          responseType: MCPResponseType.health,
          data: {
            'timeline': [
              {
                'timeDescription': '20 minutes',
                'benefitDescription': 'Heart rate normalizes',
                'stage': 'immediate',
                'confidenceLevel': 0.95,
                'personalizationFactors': [],
                'achieved': true,
                'personalizedMessage': null
              }
            ],
            'user_id': userId,
            'generated_at': DateTime.now().toIso8601String(),
            'personalized': false
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.getHealthRecoveryTimeline(userId))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result1 = await healthInsightsService.getHealthRecoveryTimeline(userId);
        final result2 = await healthInsightsService.getHealthRecoveryTimeline(userId);

        // Assert
        expect(result1.userId, equals(result2.userId));
        expect(result1.benefits.length, equals(result2.benefits.length));

        // Should only call MCP manager once due to caching
        verify(mockMCPManager.getHealthRecoveryTimeline(userId)).called(1);
      });
    });

    group('NRT Protocols', () {
      test('should get personalized NRT protocols', () async {
        // Arrange
        const userId = 'test_user_123';
        final userProfile = UserHealthProfile(
          userId: userId,
          quitDate: DateTime.now().subtract(const Duration(days: 30)),
          age: 28,
          vapingDurationMonths: 24,
          dailyUsageLevel: 'medium',
          healthConditions: [],
          fitnessLevel: 'good',
        );

        final mockResponse = MCPResponse(
          id: 'test_id',
          serverId: 'health-data-server',
          responseType: MCPResponseType.health,
          data: {
            'protocols': {
              'recommendedNrtType': 'nicotine_patch',
              'dosageSchedule': [
                {
                  'week': '1-4',
                  'dosage': '14mg patch daily',
                  'additional': null
                },
                {
                  'week': '5-6',
                  'dosage': '7mg patch daily',
                  'additional': null
                }
              ],
              'durationWeeks': 8,
              'monitoringSchedule': [
                'Daily craving intensity (1-10 scale)',
                'Weekly weight monitoring'
              ],
              'successIndicators': [
                'Reduced cravings within 3-7 days',
                'Improved sleep quality within 1-2 weeks'
              ],
              'safetyWarnings': []
            }
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.getNRTProtocols(userId, userProfile.toJson()))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result = await healthInsightsService.getNRTProtocols(userId, userProfile);

        // Assert
        expect(result.recommendedNrtType, equals('nicotine_patch'));
        expect(result.dosageSchedule.length, equals(2));
        expect(result.durationWeeks, equals(8));
        expect(result.monitoringSchedule.length, equals(2));
        expect(result.successIndicators.length, equals(2));
        expect(result.safetyWarnings.isEmpty, isTrue);

        verify(mockMCPManager.getNRTProtocols(userId, userProfile.toJson())).called(1);
      });

      test('should include safety warnings for high-risk users', () async {
        // Arrange
        const userId = 'test_user_123';
        final userProfile = UserHealthProfile(
          userId: userId,
          quitDate: DateTime.now().subtract(const Duration(days: 30)),
          age: 55,
          vapingDurationMonths: 60,
          dailyUsageLevel: 'high',
          healthConditions: ['heart_disease'],
          fitnessLevel: 'poor',
        );

        final mockResponse = MCPResponse(
          id: 'test_id',
          serverId: 'health-data-server',
          responseType: MCPResponseType.health,
          data: {
            'protocols': {
              'recommendedNrtType': 'combination_therapy',
              'dosageSchedule': [
                {
                  'week': '1-6',
                  'dosage': '21mg patch daily',
                  'additional': '2mg gum as needed'
                }
              ],
              'durationWeeks': 12,
              'monitoringSchedule': [
                'Daily craving intensity (1-10 scale)',
                'Weekly weight monitoring',
                'Monthly healthcare provider check-in'
              ],
              'successIndicators': [
                'Reduced cravings within 3-7 days'
              ],
              'safetyWarnings': [
                'Consult healthcare provider before using nicotine patches due to heart condition',
                'High usage history may require extended NRT duration'
              ]
            }
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.getNRTProtocols(userId, userProfile.toJson()))
            .thenAnswer((_) async => mockResponse);

        // Act
        final result = await healthInsightsService.getNRTProtocols(userId, userProfile);

        // Assert
        expect(result.recommendedNrtType, equals('combination_therapy'));
        expect(result.durationWeeks, equals(12));
        expect(result.safetyWarnings.length, equals(2));
        expect(result.safetyWarnings[0], contains('heart condition'));
        expect(result.safetyWarnings[1], contains('High usage history'));
      });
    });

    group('Health Improvements Calculations', () {
      test('should calculate health improvements correctly', () async {
        // Arrange
        const userId = 'test_user_123';
        final quitDate = DateTime.now().subtract(const Duration(days: 30));

        // Act
        final result = await healthInsightsService.calculateHealthImprovements(userId, quitDate);

        // Assert
        expect(result.lungCapacityImprovement, equals(15.0)); // 30 days * 0.5, clamped to 30
        expect(result.circulationImprovement, equals(60.0)); // 30 days * 2.0, clamped to 100
        expect(result.tasteSmellRecovery, equals(90.0)); // 30 days * 3.0, clamped to 100
        expect(result.energyLevelIncrease, equals(45.0)); // 30 days * 1.5, clamped to 50
        expect(result.heartRateImprovement, equals(46.5)); // Complex calculation
        expect(result.bloodPressureImprovement, equals(46.8)); // Complex calculation
      });

      test('should clamp improvements to maximum values', () async {
        // Arrange
        const userId = 'test_user_123';
        final quitDate = DateTime.now().subtract(const Duration(days: 365)); // 1 year

        // Act
        final result = await healthInsightsService.calculateHealthImprovements(userId, quitDate);

        // Assert
        expect(result.lungCapacityImprovement, equals(30.0)); // Clamped to max
        expect(result.circulationImprovement, equals(100.0)); // Clamped to max
        expect(result.tasteSmellRecovery, equals(100.0)); // Clamped to max
        expect(result.energyLevelIncrease, equals(50.0)); // Clamped to max
      });
    });

    group('Financial Savings Calculations', () {
      test('should calculate financial savings correctly', () async {
        // Arrange
        const userId = 'test_user_123';
        final quitDate = DateTime.now().subtract(const Duration(days: 30));
        const dailyCost = 10.0;

        // Act
        final result = await healthInsightsService.calculateFinancialSavings(userId, quitDate, dailyCost);

        // Assert
        expect(result.totalSaved, equals(300.0)); // 30 days * $10
        expect(result.dailySavings, equals(10.0));
        expect(result.weeklySavings, equals(70.0)); // $10 * 7
        expect(result.monthlySavings, equals(300.0)); // $10 * 30
        expect(result.yearlySavings, equals(3650.0)); // $10 * 365
        expect(result.daysQuit, equals(30));
      });
    });

    group('Health Milestones', () {
      test('should get next unachieved milestone', () async {
        // Arrange
        const userId = 'test_user_123';
        final quitDate = DateTime.now().subtract(const Duration(days: 5)); // 5 days quit

        // Act
        final result = await healthInsightsService.getNextHealthMilestone(userId, quitDate);

        // Assert
        expect(result.days, equals(7)); // Next milestone is 1 week
        expect(result.title, equals("1 Week Milestone"));
        expect(result.achieved, isFalse);
        expect(result.daysRemaining, equals(2)); // 7 - 5 = 2 days remaining
      });

      test('should return achievement message when all milestones completed', () async {
        // Arrange
        const userId = 'test_user_123';
        final quitDate = DateTime.now().subtract(const Duration(days: 400)); // Over 1 year

        // Act
        final result = await healthInsightsService.getNextHealthMilestone(userId, quitDate);

        // Assert
        expect(result.title, equals("All Major Milestones Achieved!"));
        expect(result.achieved, isTrue);
        expect(result.daysRemaining, equals(0));
      });
    });

    group('Server Status', () {
      test('should check if health server is available', () {
        // Arrange
        when(mockMCPManager.areServersAvailable(['health-data-server']))
            .thenReturn(true);

        // Act
        final result = healthInsightsService.isHealthServerAvailable();

        // Assert
        expect(result, isTrue);
        verify(mockMCPManager.areServersAvailable(['health-data-server'])).called(1);
      });

      test('should get health server status', () {
        // Arrange
        final mockStatus = MCPServerStatus(
          serverId: 'health-data-server',
          status: MCPConnectionStatus.connected,
          lastConnected: DateTime.now(),
        );

        when(mockMCPManager.getServerStatuses())
            .thenReturn({'health-data-server': mockStatus});

        // Act
        final result = healthInsightsService.getHealthServerStatus();

        // Assert
        expect(result, isNotNull);
        expect(result!.serverId, equals('health-data-server'));
        expect(result.status, equals(MCPConnectionStatus.connected));
      });
    });

    group('Cache Management', () {
      test('should clear cache when requested', () async {
        // Arrange
        const userId = 'test_user_123';
        final mockResponse = MCPResponse(
          id: 'test_id',
          serverId: 'health-data-server',
          responseType: MCPResponseType.health,
          data: {
            'timeline': [],
            'user_id': userId,
            'generated_at': DateTime.now().toIso8601String(),
            'personalized': false
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.getHealthRecoveryTimeline(userId))
            .thenAnswer((_) async => mockResponse);

        // Act
        await healthInsightsService.getHealthRecoveryTimeline(userId);
        healthInsightsService.clearCache();
        await healthInsightsService.getHealthRecoveryTimeline(userId);

        // Assert
        // Should call MCP manager twice due to cache clear
        verify(mockMCPManager.getHealthRecoveryTimeline(userId)).called(2);
      });
    });
  });
}