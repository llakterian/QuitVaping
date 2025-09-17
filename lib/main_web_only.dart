import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'app_web.dart';
import 'config/env_config.dart';
import 'data/services/storage_service.dart';
import 'data/services/user_service.dart';
import 'data/services/ai_service.dart';
import 'data/services/notification_service_web.dart' as notification_service_web;
import 'data/services/nrt_service.dart';
import 'data/services/subscription_service_web.dart' as subscription_service_web;
import 'data/services/ad_service_web.dart' as ad_service_web;

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
  
  // Skip Firebase initialization for web-only version
  debugPrint('Running web-only version without Firebase');
  
  // Initialize Hive for local storage
  await Hive.initFlutter();
  await StorageService.init();
  await NRTService.init();
  
  // Initialize services
  final storageService = StorageService();
  final userService = UserService(storageService);
  final aiService = AIService(storageService);
  final notificationService = notification_service_web.NotificationService();
  final nrtService = NRTService(storageService);
  final subscriptionService = subscription_service_web.SubscriptionService();
  final adService = ad_service_web.AdService();
  
  // Initialize services (skip notification and ad services for web)
  try {
    await notificationService.init();
  } catch (e) {
    debugPrint('Notification service not available on web: $e');
  }
  
  try {
    await adService.initialize();
  } catch (e) {
    debugPrint('Ad service not available on web: $e');
  }
  
  // Run the app with providers
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserService>(create: (_) => userService),
        ChangeNotifierProvider<AIService>(create: (_) => aiService),
        ChangeNotifierProvider<NRTService>(create: (_) => nrtService),
        ChangeNotifierProvider<subscription_service_web.SubscriptionService>(create: (_) => subscriptionService),
        Provider<StorageService>(create: (_) => storageService),
        Provider<notification_service_web.NotificationService>(create: (_) => notificationService),
        Provider<ad_service_web.AdService>(create: (_) => adService),
      ],
      child: const QuitVapingApp(),
    ),
  );
}