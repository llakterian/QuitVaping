import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'config/env_config.dart';
import 'data/services/storage_service.dart';
import 'data/services/user_service.dart';
import 'data/services/ai_service.dart';
import 'data/services/nrt_service.dart';
import 'data/services/mcp_manager_service_web.dart';
import 'shared/theme/app_theme.dart';
import 'features/onboarding/screens/welcome_screen.dart';
import 'features/tracker/screens/home_screen_minimal.dart';

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
  
  // Initialize Hive for local storage
  await Hive.initFlutter();
  await StorageService.init();
  await NRTService.init();
  
  // Initialize core services only
  final storageService = StorageService();
  final userService = UserService(storageService);
  final aiService = AIService(storageService);
  final nrtService = NRTService(storageService);
  final mcpManagerService = MCPManagerService();
  
  // Initialize MCP service
  await mcpManagerService.initialize();
  
  // Run the app with minimal providers
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserService>(create: (_) => userService),
        ChangeNotifierProvider<AIService>(create: (_) => aiService),
        ChangeNotifierProvider<NRTService>(create: (_) => nrtService),
        ChangeNotifierProvider<MCPManagerService>(create: (_) => mcpManagerService),
        Provider<StorageService>(create: (_) => storageService),
      ],
      child: const QuitVapingMinimalApp(),
    ),
  );
}

class QuitVapingMinimalApp extends StatelessWidget {
  const QuitVapingMinimalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuitVaping',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: _buildInitialScreen(context),
    );
  }

  Widget _buildInitialScreen(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    
    // Show loading indicator while checking user status
    if (userService.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    
    // If user is logged in and has completed onboarding, show home screen
    if (userService.isLoggedIn) {
      return const HomeScreenMinimal();
    }
    
    // Otherwise, show welcome/onboarding screen
    return const WelcomeScreen();
  }
}