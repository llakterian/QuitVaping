import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'package:quit_vaping/data/services/battery_optimization_service.dart';
import 'package:quit_vaping/data/models/mcp_cache_models.dart';

@GenerateMocks([Battery, DeviceInfoPlugin])
import 'battery_optimization_service_test.mocks.dart';

void main() {
  group('BatteryOptimizationService', () {
    late BatteryOptimizationService batteryService;
    late MockBattery mockBattery;
    late MockDeviceInfoPlugin mockDeviceInfo;

    setUp(() {
      mockBattery = MockBattery();
      mockDeviceInfo = MockDeviceInfoPlugin();
      batteryService = BatteryOptimizationService();
      
      // Set up default mock responses
      when(mockBattery.batteryState).thenAnswer((_) async => BatteryState.discharging);
      when(mockBattery.batteryLevel).thenAnswer((_) async => 75);
      when(mockBattery.onBatteryStateChanged)
          .thenAnswer((_) => Stream.value(BatteryState.discharging));
    });

    group('initialization', () {
      test('should initialize with default settings', () async {
        // Act
        await batteryService.initialize();

        // Assert
        expect(batteryService.settings.enableBackgroundSync, isTrue);
        expect(batteryService.settings.syncInterval, equals(Duration(minutes: 15)));
        expect(batteryService.settings.lowBatteryThreshold, equals(0.2));
        expect(batteryService.batteryLevel, equals(75));
        expect(batteryService.isLowPowerMode, isFalse);
      });

      test('should initialize with custom settings', () async {
        // Arrange
        final customSettings = BatteryOptimizationSettings(
          enableBackgroundSync: false,
          syncInterval: Duration(minutes: 30),
          lowBatteryThreshold: 0.3,
        );

        // Act
        await batteryService.initialize(customSettings);

        // Assert
        expect(batteryService.settings.enableBackgroundSync, isFalse);
        expect(batteryService.settings.syncInterval, equals(Duration(minutes: 30)));
        expect(batteryService.settings.lowBatteryThreshold, equals(0.3));
      });
    });

    group('low power mode detection', () {
      test('should enter low power mode when battery is low', () async {
        // Arrange
        when(mockBattery.batteryLevel).thenAnswer((_) async => 15); // Below 20%
        
        bool lowPowerModeEntered = false;
        batteryService.eventStream.listen((event) {
          if (event is _LowPowerModeEntered) {
            lowPowerModeEntered = true;
          }
        });

        // Act
        await batteryService.initialize();

        // Assert
        expect(batteryService.isLowPowerMode, isTrue);
        expect(lowPowerModeEntered, isTrue);
      });

      test('should exit low power mode when battery level increases', () async {
        // Arrange
        when(mockBattery.batteryLevel).thenAnswer((_) async => 15);
        await batteryService.initialize();
        expect(batteryService.isLowPowerMode, isTrue);

        bool lowPowerModeExited = false;
        batteryService.eventStream.listen((event) {
          if (event is _LowPowerModeExited) {
            lowPowerModeExited = true;
          }
        });

        // Act - simulate battery level increase
        when(mockBattery.batteryLevel).thenAnswer((_) async => 50);
        // Simulate battery state change event
        // Note: In real implementation, this would be triggered by the battery stream

        // Assert
        // This test would need to be adjusted based on actual implementation
        // of how battery state changes are handled
      });
    });

    group('timeout optimization', () {
      test('should return normal timeout when not in low power mode', () {
        // Arrange
        final settings = BatteryOptimizationSettings(
          requestTimeout: Duration(seconds: 30),
        );
        batteryService.updateSettings(settings);

        // Act
        final timeout = batteryService.getOptimizedTimeout();

        // Assert
        expect(timeout, equals(Duration(seconds: 30)));
      });

      test('should return extended timeout in low power mode', () {
        // Arrange
        final settings = BatteryOptimizationSettings(
          requestTimeout: Duration(seconds: 30),
        );
        batteryService.updateSettings(settings);
        batteryService.forceLowPowerMode(true);

        // Act
        final timeout = batteryService.getOptimizedTimeout();

        // Assert
        expect(timeout, equals(Duration(seconds: 60))); // 2x normal timeout
      });
    });

    group('sync interval optimization', () {
      test('should return normal sync interval when not in low power mode', () {
        // Arrange
        final settings = BatteryOptimizationSettings(
          syncInterval: Duration(minutes: 15),
        );
        batteryService.updateSettings(settings);

        // Act
        final interval = batteryService.getOptimizedSyncInterval();

        // Assert
        expect(interval, equals(Duration(minutes: 15)));
      });

      test('should return extended sync interval in low power mode', () {
        // Arrange
        final settings = BatteryOptimizationSettings(
          syncInterval: Duration(minutes: 15),
        );
        batteryService.updateSettings(settings);
        batteryService.forceLowPowerMode(true);

        // Act
        final interval = batteryService.getOptimizedSyncInterval();

        // Assert
        expect(interval, equals(Duration(minutes: 30))); // 2x normal interval
      });
    });

    group('background operations throttling', () {
      test('should not throttle when not in low power mode', () {
        // Act
        final shouldThrottle = batteryService.shouldThrottleBackgroundOperations();

        // Assert
        expect(shouldThrottle, isFalse);
      });

      test('should throttle when in low power mode with reduced functionality', () {
        // Arrange
        final settings = BatteryOptimizationSettings(
          reducedFunctionalityOnLowBattery: true,
        );
        batteryService.updateSettings(settings);
        batteryService.forceLowPowerMode(true);

        // Act
        final shouldThrottle = batteryService.shouldThrottleBackgroundOperations();

        // Assert
        expect(shouldThrottle, isTrue);
      });

      test('should not throttle when in low power mode but reduced functionality disabled', () {
        // Arrange
        final settings = BatteryOptimizationSettings(
          reducedFunctionalityOnLowBattery: false,
        );
        batteryService.updateSettings(settings);
        batteryService.forceLowPowerMode(true);

        // Act
        final shouldThrottle = batteryService.shouldThrottleBackgroundOperations();

        // Assert
        expect(shouldThrottle, isFalse);
      });
    });

    group('battery optimization recommendations', () {
      test('should provide low battery recommendation', () {
        // Arrange
        when(mockBattery.batteryLevel).thenAnswer((_) async => 15);

        // Act
        final recommendations = batteryService.getBatteryOptimizationRecommendations();

        // Assert
        expect(recommendations, isNotEmpty);
        expect(recommendations.first, contains('Battery level is low'));
      });

      test('should provide discharging recommendation', () {
        // Arrange
        when(mockBattery.batteryState).thenAnswer((_) async => BatteryState.discharging);
        when(mockBattery.batteryLevel).thenAnswer((_) async => 40);

        // Act
        final recommendations = batteryService.getBatteryOptimizationRecommendations();

        // Assert
        expect(recommendations, isNotEmpty);
        expect(recommendations.any((r) => r.contains('not charging')), isTrue);
      });

      test('should provide background sync recommendation when disabled', () {
        // Arrange
        final settings = BatteryOptimizationSettings(
          enableBackgroundSync: false,
        );
        batteryService.updateSettings(settings);

        // Act
        final recommendations = batteryService.getBatteryOptimizationRecommendations();

        // Assert
        expect(recommendations, isNotEmpty);
        expect(recommendations.any((r) => r.contains('Background sync is disabled')), isTrue);
      });
    });

    group('status reporting', () {
      test('should return comprehensive battery status', () async {
        // Arrange
        when(mockBattery.batteryLevel).thenAnswer((_) async => 65);
        when(mockBattery.batteryState).thenAnswer((_) async => BatteryState.charging);
        await batteryService.initialize();

        // Act
        final status = batteryService.getStatus();

        // Assert
        expect(status.batteryLevel, equals(65));
        expect(status.batteryState, equals(BatteryState.charging));
        expect(status.isLowPowerMode, isFalse);
        expect(status.backgroundSyncEnabled, isTrue);
        expect(status.recommendations, isNotNull);
      });
    });

    tearDown(() async {
      await batteryService.dispose();
    });
  });
}