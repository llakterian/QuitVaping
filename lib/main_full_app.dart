import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/services/storage_service.dart';
import 'data/services/user_service.dart';
import 'data/services/ai_service.dart';
import 'data/services/nrt_service.dart';
import 'data/services/subscription_service.dart';
import 'data/services/mcp_client_service.dart';
import 'data/services/mcp_cache_service.dart';
import 'data/services/mcp_manager_service.dart';
import 'data/services/mcp_error_handling_service.dart';
import 'data/services/mcp_user_feedback_service.dart';
import 'data/services/battery_optimization_service.dart';
import 'data/services/mcp_performance_optimizer.dart';
import 'data/services/smart_nrt_service.dart';
import 'features/tracker/screens/home_screen.dart';
import 'features/onboarding/screens/welcome_screen.dart';
import 'shared/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive for local storage
  await Hive.initFlutter();
  await StorageService.init();
  await NRTService.init();
  
  // Initialize core services
  final storageService = StorageService();
  final userService = UserService(storageService);
  final aiService = AIService(storageService);
  final nrtService = NRTService(storageService);
  final subscriptionService = SubscriptionService();
  
  // Initialize SmartNRTService
  final smartNRTService = SmartNRTService();
  
  // Initialize MCP services
  final mcpClientService = MCPClientService();
  final mcpCacheService = MCPCacheService();
  final batteryOptimizationService = BatteryOptimizationService();
  final mcpPerformanceOptimizer = MCPPerformanceOptimizer();
  final mcpErrorHandlingService = MCPErrorHandlingService();
  final mcpUserFeedbackService = MCPUserFeedbackService();
  
  // Create MCP manager service
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
  }
  
  // Initialize MCP services
  try {
    await mcpCacheService.initialize();
    await batteryOptimizationService.initialize();
    await mcpUserFeedbackService.initialize();
    await mcpPerformanceOptimizer.initialize();
    await mcpClientService.initialize();
    if (mcpManagerService != null) {
      await mcpManagerService.initialize();
    }
  } catch (e) {
    debugPrint('MCP services initialization failed: $e');
  }
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserService>(create: (_) => userService),
        ChangeNotifierProvider<AIService>(create: (_) => aiService),
        ChangeNotifierProvider<NRTService>(create: (_) => nrtService),
        ChangeNotifierProvider<SubscriptionService>(create: (_) => subscriptionService),
        ChangeNotifierProvider<SmartNRTService>(create: (_) => smartNRTService),
        Provider<StorageService>(create: (_) => storageService),
        Provider<MCPClientService>(create: (_) => mcpClientService),
        Provider<MCPCacheService>(create: (_) => mcpCacheService),
        Provider<BatteryOptimizationService>(create: (_) => batteryOptimizationService),
        Provider<MCPErrorHandlingService>(create: (_) => mcpErrorHandlingService),
        Provider<MCPUserFeedbackService>(create: (_) => mcpUserFeedbackService),
        if (mcpManagerService != null)
          Provider<MCPManagerService>(create: (_) => mcpManagerService!),
      ],
      child: const QuitVapingFullApp(),
    ),
  );
}

class QuitVapingFullApp extends StatelessWidget {
  const QuitVapingFullApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuitVaping',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const AppInitializer(),
    );
  }
}

class AppInitializer extends StatefulWidget {
  const AppInitializer({Key? key}) : super(key: key);

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  bool _showWelcome = true;

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    
    // If user is loading, show loading screen
    if (userService.isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'Loading QuitVaping...',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              const Text('MCP Performance Optimizations Active'),
            ],
          ),
        ),
      );
    }
    
    // Show welcome screen or home screen based on user status
    if (!userService.isLoggedIn) {
      return const WelcomeScreen();
    }
    
    // Show home screen (your main app with all features)
    return const HomeScreen();
  }
}