import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
// Remove Riverpod as we're using Provider

import 'app.dart';
import 'config/env_config.dart';
import 'data/services/storage_service.dart';
import 'data/services/user_service.dart';
import 'data/services/ai_service.dart';
import 'data/services/notification_service.dart';
import 'data/services/nrt_service.dart';
import 'data/services/subscription_service.dart';
import 'data/services/ad_service.dart';
import 'data/services/mcp_client_service.dart';
import 'data/services/mcp_manager_service.dart';
import 'data/services/mcp_cache_service.dart';
import 'data/services/battery_optimization_service.dart';
import 'data/services/mcp_error_handling_service.dart';
import 'data/services/mcp_user_feedback_service.dart';
import 'data/services/mcp_performance_optimizer.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables
  await EnvConfig.init();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Initialize Firebase
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
    // Continue without Firebase if it fails
  }
  
  // Initialize Hive for local storage
  await Hive.initFlutter();
  await StorageService.init();
  await NRTService.init();
  
  // Initialize services
  final storageService = StorageService();
  final userService = UserService(storageService);
  final aiService = AIService(storageService);
  final notificationService = NotificationService();
  final nrtService = NRTService(storageService);
  final subscriptionService = SubscriptionService();
  final adService = AdService();
  
  // Initialize MCP services with error handling
  final mcpClientService = MCPClientService();
  final mcpCacheService = MCPCacheService();
  final batteryOptimizationService = BatteryOptimizationService();
  final mcpPerformanceOptimizer = MCPPerformanceOptimizer();
  
  // Initialize MCP error handling and user feedback services
  final mcpErrorHandlingService = MCPErrorHandlingService();
  final mcpUserFeedbackService = MCPUserFeedbackService();
  
  // Create MCP manager service with all dependencies
  MCPManagerService? mcpManagerService;
  try {
    mcpManagerService = MCPManagerService(
      mcpClientService,
      mcpCacheService,
      mcpErrorHandlingService,
      mcpUserFeedbackService,
      batteryOptimizationService,
      mcpPerformanceOptimizer,
    );
  } catch (e) {
    debugPrint('MCP Manager Service initialization failed: $e');
    // Continue without MCP manager service
  }
  
  // Initialize services with error handling
  try {
    await notificationService.init();
  } catch (e) {
    debugPrint('Notification service initialization failed: $e');
  }
  
  try {
    await adService.initialize();
  } catch (e) {
    debugPrint('Ad service initialization failed: $e');
  }
  
  // Initialize MCP services if available
  try {
    await mcpCacheService.initialize();
    await batteryOptimizationService.initialize();
    if (mcpManagerService != null) {
      await mcpManagerService.initialize();
    }
  } catch (e) {
    debugPrint('MCP services initialization failed: $e');
  }
  
  // Run the app with providers
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserService>(create: (_) => userService),
        ChangeNotifierProvider<AIService>(create: (_) => aiService),
        ChangeNotifierProvider<NRTService>(create: (_) => nrtService),
        ChangeNotifierProvider<SubscriptionService>(create: (_) => subscriptionService),
        Provider<StorageService>(create: (_) => storageService),
        Provider<NotificationService>(create: (_) => notificationService),
        Provider<AdService>(create: (_) => adService),
        Provider<MCPClientService>(create: (_) => mcpClientService),
        Provider<MCPCacheService>(create: (_) => mcpCacheService),
        Provider<BatteryOptimizationService>(create: (_) => batteryOptimizationService),
        Provider<MCPErrorHandlingService>(create: (_) => mcpErrorHandlingService),
        Provider<MCPUserFeedbackService>(create: (_) => mcpUserFeedbackService),
        if (mcpManagerService != null)
          Provider<MCPManagerService>(create: (_) => mcpManagerService!),
      ],
      child: const QuitVapingApp(),
    ),
  );
}