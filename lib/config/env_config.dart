import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static Future<void> init() async {
    try {
      await dotenv.load(fileName: '.env');
    } catch (e) {
      debugPrint('Error loading .env file: $e');
      debugPrint('Using default configuration');
    }
  }

  static String get openAiApiKey => dotenv.env['OPENAI_API_KEY'] ?? '';
  
  static String get firebaseApiKey => dotenv.env['FIREBASE_API_KEY'] ?? '';
  
  static String get firebaseProjectId => dotenv.env['FIREBASE_PROJECT_ID'] ?? '';
  
  static String get firebaseAppId => dotenv.env['FIREBASE_APP_ID'] ?? '';
  
  static String get firebaseMessagingSenderId => 
      dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '';
  
  static String get firebaseStorageBucket => 
      dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? '';
  
  static bool get analyticsEnabled => 
      dotenv.env['ANALYTICS_ENABLED']?.toLowerCase() == 'true';
  
  static bool get enableCommunityFeatures => 
      dotenv.env['ENABLE_COMMUNITY_FEATURES']?.toLowerCase() == 'true';
  
  static bool get enableAdvancedAi => 
      dotenv.env['ENABLE_ADVANCED_AI']?.toLowerCase() == 'true';
}