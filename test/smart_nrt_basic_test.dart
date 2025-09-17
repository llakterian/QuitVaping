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
import 'smart_nrt_basic_test.mocks.dart';

void main() {
  group('Smart NRT Service Basic Tests', () {
    late SmartNRTService smartNRTService;
    late MockMCPManagerService mockMCPManager;
    late MockNRTService mockNRTService;

    setUp(() {
      mockMCPManager = MockMCPManagerService();
      mockNRTService = MockNRTService();
      smartNRTService = SmartNRTService(mockMCPManager, mockNRTService);
    });

    test('should initialize service correctly', () {
      expect(smartNRTService.currentProtocol, isNull);
      expect(smartNRTService.activeReminders, isEmpty);
      expect(smartNRTService.withdrawalSymptoms, isEmpty);
      expect(smartNRTService.safetyAlerts, isEmpty);
      expect(smartNRTService.isLoading, isFalse);
    });

    test('should track withdrawal symptoms', () async {
      // Arrange
      const userId = 'test-user-id';
      const symptomType = WithdrawalSymptomType.craving;
      const severity = 5;
      const notes = 'Mild craving';

      // Mock empty response for symptom response generation
      final mockResponse = MCPResponse(
        id: 'test-id',
        serverId: 'smart-nrt-server',
        responseType: MCPResponseType.health,
        data: {},
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
      expect(trackedSymptom.userId, equals(userId));
    });

    test('should acknowledge safety alerts', () async {
      // Arrange
      const userId = 'test-user-id';
      const alertId = 'alert-1';
      const userResponse = 'I understand';

      final alert = NRTSafetyAlert(
        id: alertId,
        userId: userId,
        type: NRTSafetyAlertType.usagePatternConcern,
        message: 'Test alert',
        severity: NRTSafetyAlertSeverity.medium,
        createdAt: DateTime.now(),
      );

      // Add alert to service
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

    test('should get recent symptoms correctly', () async {
      // Arrange
      const userId = 'test-user-id';
      
      // Add symptoms with different timestamps
      await smartNRTService.trackWithdrawalSymptom(
        userId, 
        WithdrawalSymptomType.craving, 
        5, 
        'Recent symptom'
      );
      
      // Mock old symptom (more than 7 days ago)
      final oldSymptom = WithdrawalSymptom(
        id: 'old-symptom',
        userId: userId,
        type: WithdrawalSymptomType.anxiety,
        severity: 3,
        timestamp: DateTime.now().subtract(const Duration(days: 10)),
        notes: 'Old symptom',
      );
      smartNRTService.withdrawalSymptoms.add(oldSymptom);

      // Mock empty response for symptom response generation
      final mockResponse = MCPResponse(
        id: 'test-id',
        serverId: 'smart-nrt-server',
        responseType: MCPResponseType.health,
        data: {},
        timestamp: DateTime.now(),
      );

      when(mockMCPManager.sendRequest(any))
          .thenAnswer((_) async => mockResponse);

      // Act
      final recentSymptoms = smartNRTService.getRecentSymptoms();

      // Assert
      expect(recentSymptoms.length, equals(1));
      expect(recentSymptoms.first.notes, equals('Recent symptom'));
    });

    test('should get unacknowledged alerts correctly', () {
      // Arrange
      const userId = 'test-user-id';
      
      final acknowledgedAlert = NRTSafetyAlert(
        id: 'alert-1',
        userId: userId,
        type: NRTSafetyAlertType.usagePatternConcern,
        message: 'Acknowledged alert',
        severity: NRTSafetyAlertSeverity.low,
        createdAt: DateTime.now(),
        acknowledged: true,
      );

      final unacknowledgedAlert = NRTSafetyAlert(
        id: 'alert-2',
        userId: userId,
        type: NRTSafetyAlertType.overdoseRisk,
        message: 'Unacknowledged alert',
        severity: NRTSafetyAlertSeverity.high,
        createdAt: DateTime.now(),
        acknowledged: false,
      );

      smartNRTService.safetyAlerts.addAll([acknowledgedAlert, unacknowledgedAlert]);

      // Act
      final unacknowledgedAlerts = smartNRTService.getUnacknowledgedAlerts();

      // Assert
      expect(unacknowledgedAlerts.length, equals(1));
      expect(unacknowledgedAlerts.first.id, equals('alert-2'));
      expect(unacknowledgedAlerts.first.acknowledged, isFalse);
    });

    test('should calculate adherence statistics', () {
      // Arrange
      const userId = 'test-user-id';
      
      // Mock NRT usage data
      final mockUsage = List.generate(20, (index) => NRTModel(
        id: 'usage-$index',
        userId: userId,
        type: NRTType.patch,
        nicotineStrength: 14.0,
        timestamp: DateTime.now().subtract(Duration(days: index)),
        notes: null,
      ));

      when(mockNRTService.nrtUsage).thenReturn(mockUsage);

      // Act
      final adherenceStats = smartNRTService.getAdherenceStats();

      // Assert
      expect(adherenceStats['adherenceRate'], isA<double>());
      expect(adherenceStats['actualDays'], equals(20));
      expect(adherenceStats['expectedDays'], equals(30));
      expect(adherenceStats['streak'], isA<int>());
      expect(adherenceStats['longestStreak'], isA<int>());
    });

    test('should get symptom trends', () {
      // Arrange
      const userId = 'test-user-id';
      
      // Add symptoms with varying severity
      final symptoms = [
        WithdrawalSymptom(
          id: 'symptom-1',
          userId: userId,
          type: WithdrawalSymptomType.craving,
          severity: 7,
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
        ),
        WithdrawalSymptom(
          id: 'symptom-2',
          userId: userId,
          type: WithdrawalSymptomType.craving,
          severity: 5,
          timestamp: DateTime.now().subtract(const Duration(days: 5)),
        ),
        WithdrawalSymptom(
          id: 'symptom-3',
          userId: userId,
          type: WithdrawalSymptomType.anxiety,
          severity: 3,
          timestamp: DateTime.now().subtract(const Duration(days: 10)),
        ),
      ];

      smartNRTService.withdrawalSymptoms.addAll(symptoms);

      // Act
      final symptomTrends = smartNRTService.getSymptomTrends();

      // Assert
      expect(symptomTrends['averageSeverity'], isA<double>());
      expect(symptomTrends['trend'], isA<String>());
      expect(symptomTrends['mostCommonSymptom'], isA<WithdrawalSymptomType>());
      expect(symptomTrends['totalSymptoms'], isA<int>());
    });

    tearDown(() {
      smartNRTService.dispose();
    });
  });
}