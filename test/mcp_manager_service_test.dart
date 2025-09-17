import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:quit_vaping/data/services/mcp_manager_service.dart';
import 'package:quit_vaping/data/services/mcp_client_service.dart';
import 'package:quit_vaping/data/services/mcp_cache_service.dart';
import 'package:quit_vaping/data/services/mcp_error_handling_service.dart';
import 'package:quit_vaping/data/services/mcp_user_feedback_service.dart';
import 'package:quit_vaping/data/services/battery_optimization_service.dart';
import 'package:quit_vaping/data/models/mcp_model.dart';
import 'package:quit_vaping/data/models/mcp_cache_models.dart';
import 'package:quit_vaping/data/models/mcp_error_models.dart';
import 'package:quit_vaping/data/models/mcp_feedback_models.dart';

@GenerateMocks([
  MCPClientService,
  MCPCacheService,
  MCPErrorHandlingService,
  MCPUserFeedbackService,
  BatteryOptimizationService,
])
import 'mcp_manager_service_test.mocks.dart';

void main() {
  group('MCPManagerService Unit Tests', () {
    late MCPManagerService mcpManager;
    late MockMCPClientService mockMCPClient;
    late MockMCPCacheService mockCacheService;
    late MockMCPErrorHandlingService mockErrorHandling;
    late MockMCPUserFeedbackService mockUserFeedback;
    late MockBatteryOptimizationService mockBatteryService;

    setUp(() {
      mockMCPClient = MockMCPClientService();
      mockCacheService = MockMCPCacheService();
      mockErrorHandling = MockMCPErrorHandlingService();
      mockUserFeedback = MockMCPUserFeedbackService();
      mockBatteryService = MockBatteryOptimizationService();

      mcpManager = MCPManagerService(
        mockMCPClient,
        mockCacheService,
        mockErrorHandling,
        mockUserFeedback,
        mockBatteryService,
      );

      // Setup default mock behaviors
      when(mockCacheService.initialize()).thenAnswer((_) async => {});
      when(mockBatteryService.initialize()).thenAnswer((_) async => {});
      when(mockUserFeedback.initialize()).thenAnswer((_) async => {});
      when(mockMCPClient.initialize()).thenAnswer((_) async => {});
      
      when(mockMCPClient.serverStatusStream).thenAnswer(
        (_) => Stream<MCPServerStatus>.empty(),
      );
      when(mockCacheService.connectivityStream).thenAnswer(
        (_) => Stream<bool>.empty(),
      );
      when(mockBatteryService.eventStream).thenAnswer(
        (_) => Stream<BatteryOptimizationEvent>.empty(),
      );
      when(mockCacheService.syncStream).thenAnswer(
        (_) => Stream<MCPResponse>.empty(),
      );
      when(mockErrorHandling.degradationStream).thenAnswer(
        (_) => Stream<MCPServiceDegradation>.empty(),
      );
    });

    tearDown(() async {
      await mcpManager.dispose();
    });

    group('Initialization', () {
      test('should initialize all services in correct order', () async {
        // Act
        await mcpManager.initialize();

        // Assert
        verify(mockCacheService.initialize()).called(1);
        verify(mockBatteryService.initialize()).called(1);
        verify(mockUserFeedback.initialize()).called(1);
        verify(mockMCPClient.initialize()).called(1);
      });

      test('should set up stream listeners', () async {
        // Act
        await mcpManager.initialize();

        // Assert
        verify(mockMCPClient.serverStatusStream).called(1);
        verify(mockCacheService.connectivityStream).called(1);
        verify(mockBatteryService.eventStream).called(1);
        verify(mockCacheService.syncStream).called(1);
        verify(mockErrorHandling.degradationStream).called(1);
      });
    });

    group('Health Recovery Timeline', () {
      test('should return cached response when available', () async {
        // Arrange
        const userId = 'test-user';
        final cachedResponse = MCPResponse(
          id: 'cached-id',
          serverId: 'health-data-server',
          responseType: MCPResponseType.health,
          data: {'timeline': 'cached timeline'},
          timestamp: DateTime.now(),
        );

        when(mockCacheService.getCachedResponse(any))
            .thenAnswer((_) async => cachedResponse);

        // Act
        final result = await mcpManager.getHealthRecoveryTimeline(userId);

        // Assert
        expect(result.id, equals('cached-id'));
        expect(result.data['timeline'], equals('cached timeline'));
        verify(mockCacheService.getCachedResponse('health_recovery_timeline_$userId')).called(1);
      });

      test('should use offline fallback when service unavailable', () async {
        // Arrange
        const userId = 'test-user';
        
        when(mockCacheService.getCachedResponse(any))
            .thenAnswer((_) async => null);
        when(mockCacheService.isOnline).thenReturn(false);
        when(mockMCPClient.isServerConnected(any)).thenReturn(false);
        
        final fallbackResponse = MCPResponse(
          id: 'fallback-id',
          serverId: 'health-data-server',
          responseType: MCPResponseType.health,
          data: {'timeline': 'offline timeline'},
          timestamp: DateTime.now(),
        );
        
        when(mockCacheService.getOfflineFallback(any, any))
            .thenAnswer((_) async => fallbackResponse);

        // Act
        final result = await mcpManager.getHealthRecoveryTimeline(userId);

        // Assert
        expect(result.id, equals('fallback-id'));
        expect(result.data['timeline'], equals('offline timeline'));
        verify(mockCacheService.getOfflineFallback(
          MCPResponseType.health,
          'recovery_timeline',
        )).called(1);
      });

      test('should make MCP request when online and cache result', () async {
        // Arrange
        const userId = 'test-user';
        
        when(mockCacheService.getCachedResponse(any))
            .thenAnswer((_) async => null);
        when(mockCacheService.isOnline).thenReturn(true);
        when(mockMCPClient.isServerConnected('health-data-server')).thenReturn(true);
        when(mockBatteryService.getOptimizedTimeout())
            .thenReturn(Duration(seconds: 30));
        
        final mcpResponse = MCPResponse(
          id: 'mcp-id',
          serverId: 'health-data-server',
          responseType: MCPResponseType.health,
          data: {'timeline': 'fresh timeline'},
          timestamp: DateTime.now(),
        );
        
        when(mockErrorHandling.executeWithRetry(any, 
            serverId: anyNamed('serverId'),
            operationName: anyNamed('operationName'),
            context: anyNamed('context')))
            .thenAnswer((_) async => mcpResponse);
        
        when(mockCacheService.cacheResponse(any, any))
            .thenAnswer((_) async => {});

        // Act
        final result = await mcpManager.getHealthRecoveryTimeline(userId);

        // Assert
        expect(result.id, equals('mcp-id'));
        expect(result.data['timeline'], equals('fresh timeline'));
        verify(mockCacheService.cacheResponse(
          'health_recovery_timeline_$userId',
          mcpResponse,
        )).called(1);
      });
    });

    group('Motivation Content Generation', () {
      test('should use offline fallback when battery optimization active', () async {
        // Arrange
        final context = AIWorkflowContext(
          userId: 'test-user',
          currentMood: MoodState.struggling,
          recentActivity: [],
          externalFactors: ExternalFactors(
            weather: 'sunny',
            timeOfDay: 'morning',
            location: 'home',
          ),
          availableInterventions: [],
          learningData: UserLearningProfile(
            userId: 'test-user',
            preferredInterventions: [],
            successfulStrategies: [],
            triggerPatterns: [],
            lastUpdated: DateTime.now(),
          ),
        );

        when(mockBatteryService.shouldThrottleBackgroundOperations())
            .thenReturn(true);
        
        final fallbackResponse = MCPResponse(
          id: 'fallback-motivation',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.motivation,
          data: {'content': 'offline motivation'},
          timestamp: DateTime.now(),
        );
        
        when(mockCacheService.getOfflineFallback(any, any))
            .thenAnswer((_) async => fallbackResponse);

        // Act
        final result = await mcpManager.generateMotivationContent(context);

        // Assert
        expect(result.id, equals('fallback-motivation'));
        expect(result.data['content'], equals('offline motivation'));
        verify(mockCacheService.getOfflineFallback(
          MCPResponseType.motivation,
          'craving',
        )).called(1);
      });

      test('should queue for sync when offline', () async {
        // Arrange
        final context = AIWorkflowContext(
          userId: 'test-user',
          currentMood: MoodState.motivated,
          recentActivity: [],
          externalFactors: ExternalFactors(
            weather: 'sunny',
            timeOfDay: 'morning',
            location: 'home',
          ),
          availableInterventions: [],
          learningData: UserLearningProfile(
            userId: 'test-user',
            preferredInterventions: [],
            successfulStrategies: [],
            triggerPatterns: [],
            lastUpdated: DateTime.now(),
          ),
        );

        when(mockBatteryService.shouldThrottleBackgroundOperations())
            .thenReturn(false);
        when(mockCacheService.isOnline).thenReturn(false);
        when(mockMCPClient.isServerConnected(any)).thenReturn(false);
        
        when(mockCacheService.queueForSync(any, any))
            .thenAnswer((_) async => {});
        
        final fallbackResponse = MCPResponse(
          id: 'queued-motivation',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.motivation,
          data: {'content': 'queued motivation'},
          timestamp: DateTime.now(),
        );
        
        when(mockCacheService.getOfflineFallback(any, any))
            .thenAnswer((_) async => fallbackResponse);

        // Act
        final result = await mcpManager.generateMotivationContent(context);

        // Assert
        verify(mockCacheService.queueForSync('generate_motivation_content', any)).called(1);
        expect(result.data['content'], equals('queued motivation'));
      });
    });

    group('Intervention Plan Creation', () {
      test('should prioritize offline fallback for urgent interventions', () async {
        // Arrange
        final urgentContext = AIWorkflowContext(
          userId: 'test-user',
          currentMood: MoodState.struggling,
          recentActivity: [],
          externalFactors: ExternalFactors(
            weather: 'stormy',
            timeOfDay: 'night',
            location: 'work',
          ),
          availableInterventions: [InterventionType.breathing],
          learningData: UserLearningProfile(
            userId: 'test-user',
            preferredInterventions: [],
            successfulStrategies: [],
            triggerPatterns: [],
            lastUpdated: DateTime.now(),
          ),
        );

        final fallbackResponse = MCPResponse(
          id: 'urgent-intervention',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.intervention,
          data: {'plan': 'immediate breathing exercise'},
          timestamp: DateTime.now(),
        );
        
        when(mockCacheService.getOfflineFallback(any, any))
            .thenAnswer((_) async => fallbackResponse);

        // Act
        final result = await mcpManager.createInterventionPlan(urgentContext);

        // Assert
        expect(result.id, equals('urgent-intervention'));
        expect(result.data['plan'], equals('immediate breathing exercise'));
        verify(mockCacheService.getOfflineFallback(
          MCPResponseType.intervention,
          'panic_mode',
        )).called(1);
      });
    });

    group('System Health and Status', () {
      test('should return current service statuses', () {
        // Arrange
        final mockStatuses = <String, MCPServiceStatus>{
          'health-data-server': MCPServiceStatus(
            serverId: 'health-data-server',
            status: MCPServiceStatusType.operational,
            lastChecked: DateTime.now(),
          ),
        };
        
        when(mockUserFeedback.getCurrentStatuses()).thenReturn(mockStatuses);

        // Act
        final result = mcpManager.getCurrentServiceStatuses();

        // Assert
        expect(result, equals(mockStatuses));
        verify(mockUserFeedback.getCurrentStatuses()).called(1);
      });

      test('should return system health', () {
        // Arrange
        final mockHealth = MCPSystemHealth(
          overallStatus: MCPSystemHealthStatus.healthy,
          serviceStatuses: {},
          lastUpdated: DateTime.now(),
          recommendations: [],
        );
        
        when(mockUserFeedback.getSystemHealth()).thenReturn(mockHealth);

        // Act
        final result = mcpManager.getSystemHealth();

        // Assert
        expect(result.overallStatus, equals(MCPSystemHealthStatus.healthy));
        verify(mockUserFeedback.getSystemHealth()).called(1);
      });

      test('should handle recovery actions', () async {
        // Arrange
        when(mockMCPClient.initialize()).thenAnswer((_) async => {});

        // Act
        await mcpManager.handleRecoveryAction(
          MCPRecoveryActionType.retry,
          {'serverId': 'health-data-server'},
        );

        // Assert
        verify(mockMCPClient.initialize()).called(1);
      });
    });

    group('Cache and Battery Management', () {
      test('should return cache statistics', () async {
        // Arrange
        final mockStats = MCPCacheStats(
          totalEntries: 100,
          offlineContentEntries: 20,
          syncQueueEntries: 5,
          cacheHitRate: 0.85,
          isOnline: true,
          lastSyncTime: DateTime.now(),
        );
        
        when(mockCacheService.getCacheStats()).thenAnswer((_) async => mockStats);

        // Act
        final result = await mcpManager.getCacheStats();

        // Assert
        expect(result.totalEntries, equals(100));
        expect(result.cacheHitRate, equals(0.85));
        verify(mockCacheService.getCacheStats()).called(1);
      });

      test('should clear cache', () async {
        // Arrange
        when(mockCacheService.clearCache()).thenAnswer((_) async => {});

        // Act
        await mcpManager.clearCache();

        // Assert
        verify(mockCacheService.clearCache()).called(1);
      });

      test('should return battery optimization status', () {
        // Arrange
        final mockStatus = BatteryOptimizationStatus(
          isLowPowerMode: false,
          batteryLevel: 0.75,
          isCharging: true,
          optimizationLevel: BatteryOptimizationLevel.normal,
        );
        
        when(mockBatteryService.getStatus()).thenReturn(mockStatus);

        // Act
        final result = mcpManager.getBatteryStatus();

        // Assert
        expect(result.batteryLevel, equals(0.75));
        expect(result.isCharging, isTrue);
        verify(mockBatteryService.getStatus()).called(1);
      });
    });
  });
}