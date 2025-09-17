import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:quit_vaping/data/services/mcp_cache_service.dart';
import 'package:quit_vaping/data/models/mcp_model.dart';
import 'package:quit_vaping/data/models/mcp_cache_models.dart';

@GenerateMocks([Box, Connectivity])
import 'mcp_cache_service_test.mocks.dart';

void main() {
  group('MCPCacheService', () {
    late MCPCacheService cacheService;
    late MockBox mockCacheBox;
    late MockBox mockOfflineBox;
    late MockBox mockSyncBox;
    late MockConnectivity mockConnectivity;

    setUp(() {
      mockCacheBox = MockBox();
      mockOfflineBox = MockBox();
      mockSyncBox = MockBox();
      mockConnectivity = MockConnectivity();
      
      // Mock Hive.openBox to return our mock boxes
      when(mockCacheBox.keys).thenReturn([]);
      when(mockOfflineBox.keys).thenReturn([]);
      when(mockSyncBox.keys).thenReturn([]);
      when(mockCacheBox.length).thenReturn(0);
      when(mockOfflineBox.length).thenReturn(0);
      when(mockSyncBox.length).thenReturn(0);
      
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.wifi);
      when(mockConnectivity.onConnectivityChanged)
          .thenAnswer((_) => Stream.value(ConnectivityResult.wifi));
    });

    group('cacheResponse', () {
      test('should cache MCP response successfully', () async {
        // Arrange
        final response = MCPResponse(
          id: 'test-id',
          serverId: 'test-server',
          responseType: MCPResponseType.motivation,
          data: {'content': 'Test motivation'},
          timestamp: DateTime.now(),
        );

        when(mockCacheBox.put(any, any)).thenAnswer((_) async => {});
        when(mockCacheBox.length).thenReturn(1);

        // Act
        await cacheService.cacheResponse('test-key', response);

        // Assert
        verify(mockCacheBox.put('test-key', any)).called(1);
      });

      test('should manage cache size when limit exceeded', () async {
        // Arrange
        when(mockCacheBox.length).thenReturn(1001); // Exceeds limit
        when(mockCacheBox.keys).thenReturn(List.generate(1001, (i) => 'key$i'));
        
        // Mock cache entries with different priorities
        for (int i = 0; i < 1001; i++) {
          final cacheEntry = MCPCacheEntry(
            key: 'key$i',
            response: MCPResponse(
              id: 'id$i',
              serverId: 'server',
              responseType: MCPResponseType.motivation,
              data: {},
              timestamp: DateTime.now(),
            ),
            cachedAt: DateTime.now(),
            expiresAt: DateTime.now().add(Duration(hours: 1)),
            priority: i % 6 + 1, // Vary priorities
            accessCount: 1,
            lastAccessed: DateTime.now().subtract(Duration(minutes: i)),
          );
          
          when(mockCacheBox.get('key$i')).thenReturn(jsonEncode(cacheEntry.toJson()));
        }

        when(mockCacheBox.delete(any)).thenAnswer((_) async => {});

        final response = MCPResponse(
          id: 'new-id',
          serverId: 'test-server',
          responseType: MCPResponseType.motivation,
          data: {'content': 'New content'},
          timestamp: DateTime.now(),
        );

        // Act
        await cacheService.cacheResponse('new-key', response);

        // Assert
        verify(mockCacheBox.delete(any)).called(greaterThan(0));
      });
    });

    group('getCachedResponse', () {
      test('should return cached response when valid', () async {
        // Arrange
        final response = MCPResponse(
          id: 'test-id',
          serverId: 'test-server',
          responseType: MCPResponseType.motivation,
          data: {'content': 'Cached content'},
          timestamp: DateTime.now(),
        );

        final cacheEntry = MCPCacheEntry(
          key: 'test-key',
          response: response,
          cachedAt: DateTime.now(),
          expiresAt: DateTime.now().add(Duration(hours: 1)),
          priority: 1,
          accessCount: 1,
          lastAccessed: DateTime.now(),
        );

        when(mockCacheBox.get('test-key')).thenReturn(jsonEncode(cacheEntry.toJson()));
        when(mockCacheBox.put(any, any)).thenAnswer((_) async => {});

        // Act
        final result = await cacheService.getCachedResponse('test-key');

        // Assert
        expect(result, isNotNull);
        expect(result!.id, equals('test-id'));
        expect(result.data['content'], equals('Cached content'));
        
        // Verify access count was updated
        verify(mockCacheBox.put('test-key', any)).called(1);
      });

      test('should return null for expired cache entry', () async {
        // Arrange
        final response = MCPResponse(
          id: 'test-id',
          serverId: 'test-server',
          responseType: MCPResponseType.motivation,
          data: {'content': 'Expired content'},
          timestamp: DateTime.now(),
        );

        final expiredCacheEntry = MCPCacheEntry(
          key: 'test-key',
          response: response,
          cachedAt: DateTime.now().subtract(Duration(hours: 2)),
          expiresAt: DateTime.now().subtract(Duration(hours: 1)), // Expired
          priority: 1,
          accessCount: 1,
          lastAccessed: DateTime.now().subtract(Duration(hours: 1)),
        );

        when(mockCacheBox.get('test-key')).thenReturn(jsonEncode(expiredCacheEntry.toJson()));
        when(mockCacheBox.delete('test-key')).thenAnswer((_) async => {});

        // Act
        final result = await cacheService.getCachedResponse('test-key');

        // Assert
        expect(result, isNull);
        verify(mockCacheBox.delete('test-key')).called(1);
      });
    });

    group('getOfflineFallback', () {
      test('should return offline fallback content when available', () async {
        // Arrange
        final fallbackContent = OfflineFallbackContent(
          responseType: MCPResponseType.motivation,
          content: {'content': 'Offline motivation message'},
          context: 'general',
          createdAt: DateTime.now(),
        );

        when(mockOfflineBox.get('motivation_general'))
            .thenReturn(jsonEncode(fallbackContent.toJson()));

        // Act
        final result = await cacheService.getOfflineFallback(
          MCPResponseType.motivation,
          'general',
        );

        // Assert
        expect(result, isNotNull);
        expect(result!.responseType, equals(MCPResponseType.motivation));
        expect(result.data['content'], equals('Offline motivation message'));
        expect(result.confidence, equals(0.7)); // Lower confidence for offline
      });

      test('should return null when no offline content available', () async {
        // Arrange
        when(mockOfflineBox.get('motivation_unknown')).thenReturn(null);

        // Act
        final result = await cacheService.getOfflineFallback(
          MCPResponseType.motivation,
          'unknown',
        );

        // Assert
        expect(result, isNull);
      });
    });

    group('queueForSync', () {
      test('should queue operation for sync when offline', () async {
        // Arrange
        when(mockSyncBox.put(any, any)).thenAnswer((_) async => {});

        // Act
        await cacheService.queueForSync('test_operation', {'key': 'value'});

        // Assert
        verify(mockSyncBox.put(any, any)).called(1);
      });
    });

    group('getCacheStats', () {
      test('should return accurate cache statistics', () async {
        // Arrange
        when(mockCacheBox.length).thenReturn(50);
        when(mockOfflineBox.length).thenReturn(20);
        when(mockSyncBox.length).thenReturn(5);

        // Act
        final stats = await cacheService.getCacheStats();

        // Assert
        expect(stats.totalEntries, equals(50));
        expect(stats.offlineContentEntries, equals(20));
        expect(stats.syncQueueEntries, equals(5));
        expect(stats.isOnline, isTrue);
      });
    });

    group('clearCache', () {
      test('should clear all cached data', () async {
        // Arrange
        when(mockCacheBox.clear()).thenAnswer((_) async => {});

        // Act
        await cacheService.clearCache();

        // Assert
        verify(mockCacheBox.clear()).called(1);
      });
    });
  });
}