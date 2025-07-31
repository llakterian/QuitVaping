import 'dart:developer' as dev;
import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../config/env_config.dart';

class AdService {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  bool _initialized = false;

  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  int _interstitialLoadAttempts = 0;
  int _rewardedLoadAttempts = 0;
  static const int maxFailedLoadAttempts = 3;

  String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return EnvConfig.admobBannerAdUnitIdAndroid;
    } else if (Platform.isIOS) {
      return EnvConfig.admobBannerAdUnitIdIos;
    }
    return '';
  }

  String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return EnvConfig.admobInterstitialAdUnitIdAndroid;
    } else if (Platform.isIOS) {
      return EnvConfig.admobInterstitialAdUnitIdIos;
    }
    return '';
  }

  String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return EnvConfig.admobRewardedAdUnitIdAndroid;
    } else if (Platform.isIOS) {
      return EnvConfig.admobRewardedAdUnitIdIos;
    }
    return '';
  }

  bool get isEnabled => EnvConfig.enableAds && EnvConfig.enableMonetization;

  Future<void> initialize() async {
    if (_initialized) return;
    
    try {
      // Initialize MobileAds with request configuration for GDPR compliance
      await MobileAds.instance.initialize();
      
      // Set up request configuration for GDPR compliance
      // This is important for app store compliance with privacy regulations
      MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(
          tagForChildDirectedTreatment: TagForChildDirectedTreatment.unspecified,
          tagForUnderAgeOfConsent: TagForUnderAgeOfConsent.unspecified,
          maxAdContentRating: MaxAdContentRating.pg,
        ),
      );
      
      _initialized = true;
      
      // Load initial ads
      _createInterstitialAd();
      _createRewardedAd();
      
      dev.log('AdService initialized successfully');
    } catch (e) {
      dev.log('Error initializing AdService: $e');
      // Even if initialization fails, mark as initialized to prevent repeated attempts
      _initialized = true;
    }
  }

  void _createInterstitialAd() {
    // Create a non-personalized ad request for GDPR compliance
    final AdRequest request = AdRequest(
      nonPersonalizedAds: true, // Important for GDPR compliance
      keywords: ['health', 'wellness', 'quit smoking', 'quit vaping'],
      contentUrl: 'https://quitvaping.app',
    );
    
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: request,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialLoadAttempts = 0;
          dev.log('Interstitial ad loaded successfully');
        },
        onAdFailedToLoad: (LoadAdError error) {
          _interstitialLoadAttempts += 1;
          _interstitialAd = null;
          dev.log('Interstitial ad failed to load: ${error.message}. Error code: ${error.code}');
          
          // Implement exponential backoff for retries to avoid excessive ad requests
          // This is important for app store compliance
          if (_interstitialLoadAttempts <= maxFailedLoadAttempts) {
            Future.delayed(
              Duration(seconds: 1 << _interstitialLoadAttempts), // Exponential backoff: 2, 4, 8 seconds
              _createInterstitialAd,
            );
          }
        },
      ),
    );
  }

  void _createRewardedAd() {
    // Create a non-personalized ad request for GDPR compliance
    final AdRequest request = AdRequest(
      nonPersonalizedAds: true, // Important for GDPR compliance
      keywords: ['health', 'wellness', 'quit smoking', 'quit vaping'],
      contentUrl: 'https://quitvaping.app',
    );
    
    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: request,
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
          _rewardedLoadAttempts = 0;
          dev.log('Rewarded ad loaded successfully');
        },
        onAdFailedToLoad: (LoadAdError error) {
          _rewardedLoadAttempts += 1;
          _rewardedAd = null;
          dev.log('Rewarded ad failed to load: ${error.message}. Error code: ${error.code}');
          
          // Implement exponential backoff for retries to avoid excessive ad requests
          // This is important for app store compliance
          if (_rewardedLoadAttempts <= maxFailedLoadAttempts) {
            Future.delayed(
              Duration(seconds: 1 << _rewardedLoadAttempts), // Exponential backoff: 2, 4, 8 seconds
              _createRewardedAd,
            );
          }
        },
      ),
    );
  }

  Future<void> showInterstitialAd() async {
    if (_interstitialAd == null) {
      dev.log('Warning: attempt to show interstitial before loaded.');
      return;
    }
    
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        _createInterstitialAd();
      },
    );
    
    await _interstitialAd!.show();
    _interstitialAd = null;
  }

  Future<void> showRewardedAd({required Function onRewarded}) async {
    if (_rewardedAd == null) {
      dev.log('Warning: attempt to show rewarded ad before loaded.');
      return;
    }
    
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        ad.dispose();
        _createRewardedAd();
      },
    );
    
    await _rewardedAd!.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        onRewarded();
      },
    );
    _rewardedAd = null;
  }

  BannerAd createBannerAd() {
    // Create a non-personalized ad request for GDPR compliance
    final AdRequest request = AdRequest(
      nonPersonalizedAds: true, // Important for GDPR compliance
      keywords: ['health', 'wellness', 'quit smoking', 'quit vaping'],
      contentUrl: 'https://quitvaping.app',
    );
    
    return BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: request,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => dev.log('Banner ad loaded successfully'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          dev.log('Banner ad failed to load: ${error.message}. Error code: ${error.code}');
        },
        onAdOpened: (Ad ad) => dev.log('Banner ad opened'),
        onAdClosed: (Ad ad) => dev.log('Banner ad closed'),
        onAdImpression: (Ad ad) => dev.log('Banner ad impression recorded'),
        onAdClicked: (Ad ad) => dev.log('Banner ad clicked'),
      ),
    );
  }

  void dispose() {
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
  }
}