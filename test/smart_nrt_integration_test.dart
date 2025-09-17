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
import 'smart_nrt_integration_test.mocks.dart';

void main() {
  group('Smart NRT Integration Tests', () {
    late SmartNRTService smartNRTService;
    late MockMCPManagerService mockMCPManager;
    late MockNRTService mockNRTService;

    setUp(() {
      mockMCPManager = MockMCPManagerService();
      mockNRTService = MockNRTService();
      smartNRTService = SmartNRTService(mockMCPManager, mockNRTService);
    });

    group('End-to-End Protocol Management', () {
      test('should complete full protocol lifecycle', () async {
        // Arrange
        const userId = 'test-user-id';
        
        // Mock protocol generation
        final protocolResponse = MCPResponse(
          id: 'protocol-id',
          serverId: 'health-data-server',
          responseType: MCPResponseType.health,
          data: {
            'recommendedNrtType': 'patch',
            'dosageSchedule': [
              {'week': 1, 'strength': 21, 'frequency': 1},
              {'week': 7, 'strength': 14, 'frequency': 1},
              {'week': 9, 'strength': 7, 'frequency': 1},
            ],
            'durationWeeks': 12,
            'monitoringSchedule': ['Weekly assessment'],
            'successIndicators': ['Reduced symptoms'],
            'safetyWarnings': ['Do not smoke while using NRT'],
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.getNRTProtocols(any, any))
            .thenAnswer((_) async => protocolResponse);

        // Mock dosage calculation
        final dosageResponse = MCPResponse(
          id: 'dosage-id',
          serverId: 'smart-nrt-server',
          responseType: MCPResponseType.health,
          data: {
            'recommendedDosage': '14mg',
            'adjustment': 'decrease',
            'confidence': 0.85,
            'reasoning': 'Low symptoms and consistent usage',
            'nextReviewDate': DateTime.now().add(const Duration(days: 7)).toIso8601String(),
          },
          timestamp: DateTime.now(),
        );

        when(mockMCPManager.sendRequest(any))
            .thenAnswer((_) async => dosageResponse);

        // Mock NRT usage data
        when(mockNRTService.nrtUsage).thenReturn([
          NRTModel(
            id: 'usage-1',
            userId: userId,
            type: NRTType.patch,
            nicotineStrength: 21.0,
            timestamp: DateTime.now().subtract(const Duration(days: 1)),
            notes: null,
          ),
        ]);

        // Act - Initialize and generate protocol
        await smartNRTService.initialize(userId);
        
        // Assert protocol was created
        expect(smartNRTService.currentProtocol, isNotNull);
        expect(smartNRTService.currentProtocol!.recommendedNrtType, equals('patch'));
        
        // Act - Track symptoms
        await smartNRTService.trackWithdrawalSymptom(
          userId,
          WithdrawalSymptomType.craving,
          3,
          'Mild craving after coffee',
        );
        
        // Assert symptom was tracked
        expect(smartNRTService.withdrawalSymptoms.length, equals(1));
        expect(smartNRTService.withdrawalSymptoms.first.severity, equals(3));
        
        // Act - Calculate personalized dosage
        final dosageRecommendation = await smartNRTService.calculatePersonalizedDosage(
          userId,
          smartNRTService.withdrawalSymptoms,
        );
        
        // Assert dosage recommendation
        expect(dosageRecommendation.adjustment, equals('decrease'));
        expect(dosageRecommendation.confidence, equals(0.85));
        
        // Verify all MCP calls were made
        verify(mockMCPManager.getNRTProtocols(userId, any)).called(1);
        verify(mockMCPManager.sendRequest(any)).called(greaterThan(0));
      });
    });

    tearDown(() {
      smartNRTService.dispose();
    });
  });
}