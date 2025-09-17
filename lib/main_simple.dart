import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'config/env_config.dart';
import 'data/services/storage_service.dart';
import 'data/services/user_service.dart';
import 'data/services/ai_service.dart';
import 'data/services/notification_service.dart';
import 'data/services/nrt_service.dart';
import 'data/services/subscription_service.dart';
import 'data/services/ad_service.dart';

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
  
  // Initialize services
  await notificationService.init();
  await adService.initialize();
  
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
      ],
      child: const QuitVapingApp(),
    ),
  );
}