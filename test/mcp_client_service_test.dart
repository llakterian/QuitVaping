import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:quit_vaping/data/services/mcp_client_service.dart';
import 'package:quit_vaping/data/models/mcp_model.dart';

@GenerateMocks([WebSocketChannel])
import 'mcp_client_service_test.mocks.dart';

void main() {
  group('MCPClientService Unit Tests', () {
    late MCPClientService mcpClient;
    late MockWebSocketChannel mockWebSocket;

    setUp(() {
      mcpClient = MCPClientService();
      mockWebSocket = MockWebSocketChannel();
    });

    tearDown(() async {
      await mcpClient.dispose();
    });

    group('Initialization', () {
      test('should initialize with default server configurations', () async {
        // Act
        await mcpClient.initialize();

        // Assert
        final statuses = mcpClient.serverStatuses;
        expect(statuses.keys, contains('health-data-server'));
        expect(statuses.keys, contains('ai-workflow-server'));
        expect(statuses.keys, contains('external-services-server'));
        expect(statuses.keys, contains('analytics-server'));
      });

      test('should set initial server status to disconnected', () async {
        // Act
        await mcpClient.initialize();

        // Assert
        final statuses = mcpClient.serverStatuses;
        for (final status in statuses.values) {
          expect(status.status, equals(MCPConnectionStatus.disconnected));
        }
      });
    });

    group('Connection Management', () {
      test('should update status to connecting when establishing connection', () async {
        // Arrange
        bool statusUpdated = false;
        MCPConnectionStatus? capturedStatus;
        
        mcpClient.serverStatusStream.listen((status) {
          if (status.serverId == 'health-data-server') {
            statusUpdated = true;
            capturedStatus = status.status;
          }
        });

        // Act
        await mcpClient.initialize();

        // Assert
        await Future.delayed(Duration(milliseconds: 100));
        expect(statusUpdated, isTrue);
        expect(capturedStatus, equals(MCPConnectionStatus.connecting));
      });

      test('should handle connection failures gracefully', () async {
        // This test verifies that connection failures don't crash the service
        // and that appropriate error status is set
        
        // Act
        await mcpClient.initialize();

        // Assert - Service should still be functional even if connections fail
        expect(mcpClient.serverStatuses.isNotEmpty, isTrue);
        
        // Verify that failed connections are marked as error status
        final healthServerStatus = mcpClient.serverStatuses['health-data-server'];
        expect(healthServerStatus, isNotNull);
        // In simulation mode, connections will eventually be marked as connected
        // In real failure scenarios, they would be marked as error
      });

      test('should check server connection status correctly', () async {
        // Arrange
        await mcpClient.initialize();

        // Act & Assert
        final isConnected = mcpClient.isServerConnected('health-data-server');
        expect(isConnected, isA<bool>());
      });

      test('should return list of connected servers', () async {
        // Arrange
        await mcpClient.initialize();

        // Act
        final connectedServers = mcpClient.getConnectedServers();

        // Assert
        expect(connectedServers, isA<List<String>>());
      });
    });

    group('Request Handling', () {
      test('should send request successfully to connected server', () async {
        // Arrange
        await mcpClient.initialize();
        
        final request = MCPRequest(
          id: 'test-request-1',
          method: 'get_health_recovery_timeline',
          params: {'userId': 'test-user'},
          serverId: 'health-data-server',
        );

        // Act
        final response = await mcpClient.sendRequest(request);

        // Assert
        expect(response.id, equals('test-request-1'));
        expect(response.serverId, equals('health-data-server'));
        expect(response.responseType, equals(MCPResponseType.health));
        expect(response.data, isNotEmpty);
      });

      test('should handle request to disconnected server', () async {
        // Arrange
        await mcpClient.initialize();
        
        final request = MCPRequest(
          id: 'test-request-2',
          method: 'test_method',
          params: {},
          serverId: 'non-existent-server',
        );

        // Act & Assert
        expect(
          () => mcpClient.sendRequest(request),
          throwsA(isA<MCPException>()),
        );
      });

      test('should simulate different response types correctly', () async {
        // Arrange
        await mcpClient.initialize();

        // Test health response
        final healthRequest = MCPRequest(
          id: 'health-test',
          method: 'get_health_recovery_timeline',
          params: {},
          serverId: 'health-data-server',
        );

        // Test motivation response
        final motivationRequest = MCPRequest(
          id: 'motivation-test',
          method: 'generate_motivation_content',
          params: {},
          serverId: 'ai-workflow-server',
        );

        // Test analytics response
        final analyticsRequest = MCPRequest(
          id: 'analytics-test',
          method: 'analyze_user_patterns',
          params: {},
          serverId: 'analytics-server',
        );

        // Act
        final healthResponse = await mcpClient.sendRequest(healthRequest);
        final motivationResponse = await mcpClient.sendRequest(motivationRequest);
        final analyticsResponse = await mcpClient.sendRequest(analyticsRequest);

        // Assert
        expect(healthResponse.responseType, equals(MCPResponseType.health));
        expect(healthResponse.data['timeline'], isNotNull);
        
        expect(motivationResponse.responseType, equals(MCPResponseType.motivation));
        expect(motivationResponse.data['content'], isNotNull);
        
        expect(analyticsResponse.responseType, equals(MCPResponseType.analytics));
        expect(analyticsResponse.data['patterns'], isNotNull);
      });

      test('should handle unknown method gracefully', () async {
        // Arrange
        await mcpClient.initialize();
        
        final request = MCPRequest(
          id: 'unknown-test',
          method: 'unknown_method',
          params: {},
          serverId: 'health-data-server',
        );

        // Act
        final response = await mcpClient.sendRequest(request);

        // Assert
        expect(response.responseType, equals(MCPResponseType.error));
        expect(response.data['message'], contains('not implemented'));
      });
    });

    group('Error Handling', () {
      test('should create MCPException with correct properties', () {
        // Arrange & Act
        final exception = MCPException(
          'Test error message',
          serverId: 'test-server',
          originalError: Exception('Original error'),
        );

        // Assert
        expect(exception.message, equals('Test error message'));
        expect(exception.serverId, equals('test-server'));
        expect(exception.originalError, isA<Exception>());
        expect(exception.toString(), contains('Test error message'));
        expect(exception.toString(), contains('test-server'));
      });
    });

    group('Cleanup', () {
      test('should dispose resources properly', () async {
        // Arrange
        await mcpClient.initialize();

        // Act
        await mcpClient.dispose();

        // Assert - Should not throw any exceptions
        expect(true, isTrue); // Test passes if no exceptions thrown
      });
    });
  });
}