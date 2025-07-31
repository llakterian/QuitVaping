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
  
  // Monetization Configuration
  static String get admobAppIdAndroid => dotenv.env['ADMOB_APP_ID_ANDROID'] ?? '';
  static String get admobAppIdIos => dotenv.env['ADMOB_APP_ID_IOS'] ?? '';
  
  static String get admobBannerAdUnitIdAndroid => 
      dotenv.env['ADMOB_BANNER_AD_UNIT_ID_ANDROID'] ?? '';
  static String get admobBannerAdUnitIdIos => 
      dotenv.env['ADMOB_BANNER_AD_UNIT_ID_IOS'] ?? '';
  
  static String get admobInterstitialAdUnitIdAndroid => 
      dotenv.env['ADMOB_INTERSTITIAL_AD_UNIT_ID_ANDROID'] ?? '';
  static String get admobInterstitialAdUnitIdIos => 
      dotenv.env['ADMOB_INTERSTITIAL_AD_UNIT_ID_IOS'] ?? '';
  
  static String get admobRewardedAdUnitIdAndroid => 
      dotenv.env['ADMOB_REWARDED_AD_UNIT_ID_ANDROID'] ?? '';
  static String get admobRewardedAdUnitIdIos => 
      dotenv.env['ADMOB_REWARDED_AD_UNIT_ID_IOS'] ?? '';
  
  // In-App Purchase Configuration
  static String get iapMonthlySubscriptionId => 
      dotenv.env['IAP_MONTHLY_SUBSCRIPTION_ID'] ?? 'quit_vaping_premium_monthly';
  static String get iapYearlySubscriptionId => 
      dotenv.env['IAP_YEARLY_SUBSCRIPTION_ID'] ?? 'quit_vaping_premium_yearly';
  static String get iapRemoveAdsId => 
      dotenv.env['IAP_REMOVE_ADS_ID'] ?? 'quit_vaping_remove_ads';
  
  // Monetization Settings
  static bool get useTestAds => 
      dotenv.env['USE_TEST_ADS']?.toLowerCase() == 'true';
  static bool get useTestIap => 
      dotenv.env['USE_TEST_IAP']?.toLowerCase() == 'true';
  static bool get enableMonetization => 
      dotenv.env['ENABLE_MONETIZATION']?.toLowerCase() == 'true';
  static bool get enableAds => 
      dotenv.env['ENABLE_ADS']?.toLowerCase() == 'true';
  static bool get enableSubscriptions => 
      dotenv.env['ENABLE_SUBSCRIPTIONS']?.toLowerCase() == 'true';
}