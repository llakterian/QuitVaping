import 'package:flutter_test/flutter_test.dart';
import 'package:quit_vaping/data/models/mcp_error_models.dart';
import 'package:quit_vaping/data/services/mcp_error_handling_service.dart';

void main() {
  group('MCP Error Handling Service', () {
    late MCPErrorHandlingService errorHandlingService;

    setUp(() {
      errorHandlingService = MCPErrorHandlingService();
    });

    tearDown(() async {
      await errorHandlingService.dispose();
    });

    test('should handle connection failed error correctly', () async {
      final error = Exception('Connection failed');
      
      final result = await errorHandlingService.handleError(
        error,
        serverId: 'test-server',
        operation: 'test-operation',
      );

      expect(result.error.errorType, MCPErrorType.connectionFailed);
      expect(result.error.isRetryable, true);
      expect(result.shouldRetry, true);
      expect(result.recoveryOptions.isNotEmpty, true);
      expect(result.notification.type, MCPNotificationType.degradation);
    });

    test('should handle timeout error with exponential backoff', () async {
      final error = Exception('Request timeout');
      
      final result = await errorHandlingService.handleError(
        error,
        serverId: 'test-server',
        operation: 'test-operation',
      );

      expect(result.error.errorType, MCPErrorType.timeout);
      expect(result.shouldRetry, true);
      expect(result.retryDelay, isNotNull);
      expect(result.retryDelay!.inSeconds, greaterThan(0));
    });

    test('should not retry authentication errors', () async {
      final error = Exception('Authentication failed');
      
      final result = await errorHandlingService.handleError(
        error,
        serverId: 'test-server',
        operation: 'test-operation',
      );

      expect(result.error.errorType, MCPErrorType.authenticationFailed);
      expect(result.error.isRetryable, false);
      expect(result.shouldRetry, false);
      expect(result.error.severity, MCPErrorSeverity.critical);
    });

    test('should execute operation with retry on transient failures', () async {
      var attemptCount = 0;
      
      final result = await errorHandlingService.executeWithRetry(
        () async {
          attemptCount++;
          if (attemptCount < 3) {
            throw Exception('Connection failed');
          }
          return 'Success';
        },
        serverId: 'test-server',
        operationName: 'test-operation',
      );

      expect(result, 'Success');
      expect(attemptCount, 3);
    });

    test('should fail after max retries exceeded', () async {
      var attemptCount = 0;
      
      expect(
        () => errorHandlingService.executeWithRetry(
          () async {
            attemptCount++;
            throw Exception('Connection failed');
          },
          serverId: 'test-server',
          operationName: 'test-operation',
        ),
        throwsException,
      );
    });

    test('should create appropriate recovery options for different error types', () async {
      // Test connection failed error
      final connectionError = Exception('Connection failed');
      final connectionResult = await errorHandlingService.handleError(
        connectionError,
        serverId: 'test-server',
      );

      expect(
        connectionResult.recoveryOptions.any(
          (option) => option.actionType == MCPRecoveryActionType.checkConnection,
        ),
        true,
      );
      expect(
        connectionResult.recoveryOptions.any(
          (option) => option.actionType == MCPRecoveryActionType.useOfflineContent,
        ),
        true,
      );

      // Test server unavailable error
      final serverError = Exception('Server unavailable');
      final serverResult = await errorHandlingService.handleError(
        serverError,
        serverId: 'test-server',
      );

      expect(
        serverResult.recoveryOptions.any(
          (option) => option.actionType == MCPRecoveryActionType.retry,
        ),
        true,
      );
    });

    test('should create user-friendly error messages', () async {
      final error = Exception('Connection failed');
      
      final result = await errorHandlingService.handleError(
        error,
        serverId: 'health-data-server',
        operation: 'get-health-data',
      );

      expect(result.error.userFriendlyMessage, contains('Health Insights'));
      expect(result.error.userFriendlyMessage, contains('internet connection'));
      expect(result.notification.title, isNotEmpty);
      expect(result.notification.message, isNotEmpty);
    });

    test('should track service degradation levels', () async {
      final offlineError = Exception('You are offline');
      
      final result = await errorHandlingService.handleError(
        offlineError,
        serverId: 'ai-workflow-server',
        operation: 'generate-content',
      );

      expect(result.degradationLevel, MCPDegradationLevel.major);
      expect(result.error.severity, MCPErrorSeverity.high);
    });

    test('should clear degradation when service recovers', () {
      errorHandlingService.clearDegradation('test-server');
      
      final degradations = errorHandlingService.getCurrentDegradations();
      expect(degradations.containsKey('test-server'), false);
    });
  });
}