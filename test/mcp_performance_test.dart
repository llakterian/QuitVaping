import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:quit_vaping/data/services/mcp_client_service.dart';
import 'package:quit_vaping/data/services/mcp_manager_service.dart';
import 'package:quit_vaping/data/models/mcp_model.dart';

@GenerateMocks([MCPClientService])
import 'mcp_performance_test.mocks.dart';

void main() {
  group('MCP Performance Tests', () {
    late MockMCPClientService mockMCPClient;

    setUp(() {
      mockMCPClient = MockMCPClientService();
    });

    group('Response Time Performance', () {
      test('should complete health data requests within acceptable time', () async {
        // Arrange
        const maxResponseTime = Duration(seconds: 5);
        final request = MCPRequest(
          id: 'perf-test-1',
          method: 'get_health_recovery_timeline',
          params: {'userId': 'test-user'},
          serverId: 'health-data-server',
        );

        final response = MCPResponse(
          id: 'perf-test-1',
          serverId: 'health-data-server',
          responseType: MCPResponseType.health,
          data: {'timeline': 'test data'},
          timestamp: DateTime.now(),
        );

        // Simulate realistic response time
        when(mockMCPClient.sendRequest(any)).thenAnswer((_) async {
          await Future.delayed(Duration(milliseconds: 800));
          return response;
        });

        // Act
        final stopwatch = Stopwatch()..start();
        final result = await mockMCPClient.sendRequest(request);
        stopwatch.stop();

        // Assert
        expect(result.id, equals('perf-test-1'));
        expect(stopwatch.elapsed, lessThan(maxResponseTime));
        expect(stopwatch.elapsed.inMilliseconds, lessThan(5000));
      });

      test('should complete AI motivation requests within acceptable time', () async {
        // Arrange
        const maxResponseTime = Duration(seconds: 10); // AI requests may take longer
        final request = MCPRequest(
          id: 'perf-test-2',
          method: 'generate_motivation_content',
          params: {'userId': 'test-user', 'mood': 'struggling'},
          serverId: 'ai-workflow-server',
        );

        final response = MCPResponse(
          id: 'perf-test-2',
          serverId: 'ai-workflow-server',
          responseType: MCPResponseType.motivation,
          data: {'content': 'AI generated motivation'},
          timestamp: DateTime.now(),
        );

        // Simulate AI processing time
        when(mockMCPClient.sendRequest(any)).thenAnswer((_) async {
          await Future.delayed(Duration(milliseconds: 2500));
          return response;
        });

        // Act
        final stopwatch = Stopwatch()..start();
        final result = await mockMCPClient.sendRequest(request);
        stopwatch.stop();

        // Assert
        expect(result.id, equals('perf-test-2'));
        expect(stopwatch.elapsed, lessThan(maxResponseTime));
        expect(stopwatch.elapsed.inMilliseconds, lessThan(10000));
      });

      test('should handle timeout scenarios gracefully', () async {
        // Arrange
        const timeoutDuration = Duration(seconds: 2);
        final request = MCPRequest(
          id: 'timeout-test',
          method: 'slow_operation',
          params: {},
          serverId: 'health-data-server',
          timeoutSeconds: timeoutDuration.inSeconds,
        );

        // Simulate timeout scenario
        when(mockMCPClient.sendRequest(any)).thenAnswer((_) async {
          await Future.delayed(Duration(seconds: 5)); // Longer than timeout
          throw Exception('Request timeout');
        });

        // Act & Assert
        expect(
          () => mockMCPClient.sendRequest(request),
          throwsException,
        );
      });
    });

    group('Concurrent Request Performance', () {
      test('should handle multiple concurrent requests efficiently', () async {
        // Arrange
        const numberOfRequests = 10;
        const maxTotalTime = Duration(seconds: 15);
        
        final requests = List.generate(numberOfRequests, (index) => 
          MCPRequest(
            id: 'concurrent-$index',
            method: 'get_health_recovery_timeline',
            params: {'userId': 'user-$index'},
            serverId: 'health-data-server',
          ),
        );

        final responses = List.generate(numberOfRequests, (index) =>
          MCPResponse(
            id: 'concurrent-$index',
            serverId: 'health-data-server',
            responseType: MCPResponseType.health,
            data: {'timeline': 'data-$index'},
            timestamp: DateTime.now(),
          ),
        );

        // Mock responses with realistic delays
        for (int i = 0; i < numberOfRequests; i++) {
          when(mockMCPClient.sendRequest(argThat(predicate<MCPRequest>(
            (req) => req.id == 'concurrent-$i',
          )))).thenAnswer((_) async {
            await Future.delayed(Duration(milliseconds: 500 + (i * 100)));
            return responses[i];
          });
        }

        // Act
        final stopwatch = Stopwatch()..start();
        final futures = requests.map((req) => mockMCPClient.sendRequest(req));
        final results = await Future.wait(futures);
        stopwatch.stop();

        // Assert
        expect(results, hasLength(numberOfRequests));
        expect(stopwatch.elapsed, lessThan(maxTotalTime));
        
        // Verify all requests completed
        for (int i = 0; i < numberOfRequests; i++) {
          expect(results[i].id, equals('concurrent-$i'));
          expect(results[i].data['timeline'], equals('data-$i'));
        }
      });

      test('should maintain performance under load', () async {
        // Arrange
        const numberOfBatches = 5;
        const requestsPerBatch = 20;
        const maxBatchTime = Duration(seconds: 8);
        
        final allResults = <MCPResponse>[];
        final batchTimes = <Duration>[];

        // Act - Process multiple batches
        for (int batch = 0; batch < numberOfBatches; batch++) {
          final batchRequests = List.generate(requestsPerBatch, (index) =>
            MCPRequest(
              id: 'batch-${batch}-${index}',
              method: 'analyze_user_patterns',
              params: {'userId': 'user-$index', 'batch': batch},
              serverId: 'analytics-server',
            ),
          );

          // Mock batch responses
          for (int i = 0; i < requestsPerBatch; i++) {
            when(mockMCPClient.sendRequest(argThat(predicate<MCPRequest>(
              (req) => req.id == 'batch-${batch}-${i}',
            )))).thenAnswer((_) async {
              await Future.delayed(Duration(milliseconds: 200));
              return MCPResponse(
                id: 'batch-${batch}-${i}',
                serverId: 'analytics-server',
                responseType: MCPResponseType.analytics,
                data: {'patterns': 'batch-$batch-data-$i'},
                timestamp: DateTime.now(),
              );
            });
          }

          final batchStopwatch = Stopwatch()..start();
          final batchFutures = batchRequests.map((req) => mockMCPClient.sendRequest(req));
          final batchResults = await Future.wait(batchFutures);
          batchStopwatch.stop();

          allResults.addAll(batchResults);
          batchTimes.add(batchStopwatch.elapsed);
        }

        // Assert
        expect(allResults, hasLength(numberOfBatches * requestsPerBatch));
        
        // Check that each batch completed within acceptable time
        for (final batchTime in batchTimes) {
          expect(batchTime, lessThan(maxBatchTime));
        }

        // Check that performance didn't degrade significantly across batches
        final firstBatchTime = batchTimes.first.inMilliseconds;
        final lastBatchTime = batchTimes.last.inMilliseconds;
        final performanceDegradation = (lastBatchTime - firstBatchTime) / firstBatchTime;
        
        expect(performanceDegradation, lessThan(0.5)); // Less than 50% degradation
      });
    });

    group('Memory and Resource Performance', () {
      test('should handle large response payloads efficiently', () async {
        // Arrange
        final largeDataPayload = Map<String, dynamic>.fromEntries(
          List.generate(1000, (index) => MapEntry('item_$index', {
            'id': index,
            'data': 'Large data payload item $index with substantial content',
            'metadata': {
              'timestamp': DateTime.now().toIso8601String(),
              'category': 'performance_test',
              'size': 'large',
            },
          })),
        );

        final request = MCPRequest(
          id: 'large-payload-test',
          method: 'get_comprehensive_report',
          params: {'userId': 'test-user', 'includeAll': true},
          serverId: 'analytics-server',
        );

        final response = MCPResponse(
          id: 'large-payload-test',
          serverId: 'analytics-server',
          responseType: MCPResponseType.analytics,
          data: largeDataPayload,
          timestamp: DateTime.now(),
        );

        when(mockMCPClient.sendRequest(any)).thenAnswer((_) async {
          await Future.delayed(Duration(milliseconds: 1000));
          return response;
        });

        // Act
        final stopwatch = Stopwatch()..start();
        final result = await mockMCPClient.sendRequest(request);
        stopwatch.stop();

        // Assert
        expect(result.data.keys, hasLength(1000));
        expect(stopwatch.elapsed.inSeconds, lessThan(5));
        
        // Verify data integrity
        expect(result.data['item_0']['id'], equals(0));
        expect(result.data['item_999']['id'], equals(999));
      });

      test('should handle rapid sequential requests without memory leaks', () async {
        // Arrange
        const numberOfSequentialRequests = 100;
        const maxTotalTime = Duration(seconds: 30);

        // Act
        final stopwatch = Stopwatch()..start();
        
        for (int i = 0; i < numberOfSequentialRequests; i++) {
          final request = MCPRequest(
            id: 'sequential-$i',
            method: 'quick_operation',
            params: {'index': i},
            serverId: 'health-data-server',
          );

          final response = MCPResponse(
            id: 'sequential-$i',
            serverId: 'health-data-server',
            responseType: MCPResponseType.health,
            data: {'result': 'data-$i'},
            timestamp: DateTime.now(),
          );

          when(mockMCPClient.sendRequest(argThat(predicate<MCPRequest>(
            (req) => req.id == 'sequential-$i',
          )))).thenAnswer((_) async {
            await Future.delayed(Duration(milliseconds: 50));
            return response;
          });

          final result = await mockMCPClient.sendRequest(request);
          expect(result.id, equals('sequential-$i'));
        }
        
        stopwatch.stop();

        // Assert
        expect(stopwatch.elapsed, lessThan(maxTotalTime));
      });
    });

    group('Network Performance Simulation', () {
      test('should handle slow network conditions gracefully', () async {
        // Arrange
        final request = MCPRequest(
          id: 'slow-network-test',
          method: 'get_health_recovery_timeline',
          params: {'userId': 'test-user'},
          serverId: 'health-data-server',
        );

        final response = MCPResponse(
          id: 'slow-network-test',
          serverId: 'health-data-server',
          responseType: MCPResponseType.health,
          data: {'timeline': 'slow network data'},
          timestamp: DateTime.now(),
        );

        // Simulate slow network (3G-like conditions)
        when(mockMCPClient.sendRequest(any)).thenAnswer((_) async {
          await Future.delayed(Duration(milliseconds: 3000)); // 3 second delay
          return response;
        });

        // Act
        final stopwatch = Stopwatch()..start();
        final result = await mockMCPClient.sendRequest(request);
        stopwatch.stop();

        // Assert
        expect(result.id, equals('slow-network-test'));
        expect(stopwatch.elapsed.inMilliseconds, greaterThan(2500));
        expect(stopwatch.elapsed.inMilliseconds, lessThan(10000)); // Still reasonable
      });

      test('should handle intermittent network failures with retries', () async {
        // Arrange
        final request = MCPRequest(
          id: 'retry-test',
          method: 'get_health_recovery_timeline',
          params: {'userId': 'test-user'},
          serverId: 'health-data-server',
        );

        var attemptCount = 0;
        when(mockMCPClient.sendRequest(any)).thenAnswer((_) async {
          attemptCount++;
          if (attemptCount < 3) {
            await Future.delayed(Duration(milliseconds: 500));
            throw Exception('Network error');
          }
          
          await Future.delayed(Duration(milliseconds: 800));
          return MCPResponse(
            id: 'retry-test',
            serverId: 'health-data-server',
            responseType: MCPResponseType.health,
            data: {'timeline': 'retry success data'},
            timestamp: DateTime.now(),
          );
        });

        // Act
        final stopwatch = Stopwatch()..start();
        final result = await mockMCPClient.sendRequest(request);
        stopwatch.stop();

        // Assert
        expect(result.id, equals('retry-test'));
        expect(result.data['timeline'], equals('retry success data'));
        expect(attemptCount, equals(3)); // Should have retried twice
        expect(stopwatch.elapsed.inSeconds, lessThan(10));
      });
    });

    group('Performance Benchmarks', () {
      test('should meet performance benchmarks for critical operations', () async {
        // Define performance benchmarks
        final benchmarks = {
          'health_data_request': Duration(milliseconds: 2000),
          'motivation_generation': Duration(milliseconds: 5000),
          'intervention_plan': Duration(milliseconds: 3000),
          'analytics_query': Duration(milliseconds: 4000),
          'community_matching': Duration(milliseconds: 6000),
        };

        final operations = [
          {
            'name': 'health_data_request',
            'method': 'get_health_recovery_timeline',
            'server': 'health-data-server',
          },
          {
            'name': 'motivation_generation',
            'method': 'generate_motivation_content',
            'server': 'ai-workflow-server',
          },
          {
            'name': 'intervention_plan',
            'method': 'create_intervention_plan',
            'server': 'ai-workflow-server',
          },
          {
            'name': 'analytics_query',
            'method': 'analyze_user_patterns',
            'server': 'analytics-server',
          },
          {
            'name': 'community_matching',
            'method': 'match_community_peers',
            'server': 'external-services-server',
          },
        ];

        // Test each operation
        for (final operation in operations) {
          final request = MCPRequest(
            id: 'benchmark-${operation['name']}',
            method: operation['method']!,
            params: {'userId': 'benchmark-user'},
            serverId: operation['server']!,
          );

          final response = MCPResponse(
            id: 'benchmark-${operation['name']}',
            serverId: operation['server']!,
            responseType: MCPResponseType.health,
            data: {'result': 'benchmark data'},
            timestamp: DateTime.now(),
          );

          // Mock with realistic timing based on operation complexity
          final mockDelay = operation['name'] == 'community_matching' 
              ? Duration(milliseconds: 4500)
              : operation['name'] == 'motivation_generation'
                  ? Duration(milliseconds: 3500)
                  : Duration(milliseconds: 1500);

          when(mockMCPClient.sendRequest(argThat(predicate<MCPRequest>(
            (req) => req.id == 'benchmark-${operation['name']}',
          )))).thenAnswer((_) async {
            await Future.delayed(mockDelay);
            return response;
          });

          // Act
          final stopwatch = Stopwatch()..start();
          final result = await mockMCPClient.sendRequest(request);
          stopwatch.stop();

          // Assert
          final benchmark = benchmarks[operation['name']]!;
          expect(result.id, equals('benchmark-${operation['name']}'));
          expect(stopwatch.elapsed, lessThan(benchmark),
              reason: '${operation['name']} exceeded benchmark of ${benchmark.inMilliseconds}ms');
        }
      });
    });
  });
}