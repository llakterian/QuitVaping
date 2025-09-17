import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Web-compatible ad service (stub implementation)
class AdService {
  bool _initialized = false;

  bool get isInitialized => _initialized;

  Future<void> initialize() async {
    if (kIsWeb) {
      debugPrint('AdService: Web version - ads not supported');
      _initialized = true;
      return;
    }
    
    // For non-web platforms, this would initialize actual ads
    _initialized = true;
  }

  void loadInterstitialAd() {
    if (kIsWeb) {
      debugPrint('AdService: Web version - interstitial ad not supported');
      return;
    }
    
    // For non-web platforms, this would load actual interstitial ads
  }

  void showInterstitialAd() {
    if (kIsWeb) {
      debugPrint('AdService: Web version - showing simulated interstitial ad');
      return;
    }
    
    // For non-web platforms, this would show actual interstitial ads
  }

  void loadRewardedAd() {
    if (kIsWeb) {
      debugPrint('AdService: Web version - rewarded ad not supported');
      return;
    }
    
    // For non-web platforms, this would load actual rewarded ads
  }

  void showRewardedAd({Function? onUserEarnedReward}) {
    if (kIsWeb) {
      debugPrint('AdService: Web version - showing simulated rewarded ad');
      // Simulate reward for demo purposes
      onUserEarnedReward?.call();
      return;
    }
    
    // For non-web platforms, this would show actual rewarded ads
  }

  /// Creates a banner ad widget (web-compatible)
  Widget createBannerAd() {
    if (kIsWeb) {
      return Container(
        height: 50,
        color: Colors.grey[200],
        child: const Center(
          child: Text(
            'Ad Space (Web Demo)',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }
    
    // For non-web platforms, this would return actual banner ads
    return const SizedBox.shrink();
  }

  void dispose() {
    if (kIsWeb) {
      debugPrint('AdService: Web version - disposing');
      return;
    }
    
    // For non-web platforms, this would dispose actual ads
  }
}