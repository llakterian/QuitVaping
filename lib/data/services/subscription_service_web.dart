import 'package:flutter/foundation.dart';

/// Web-compatible subscription service (stub implementation)
class SubscriptionService extends ChangeNotifier {
  bool _isPremium = false;
  bool _hasRemovedAds = false;
  bool _isLoading = false;
  DateTime? _subscriptionExpiry;

  // Additional getters for compatibility
  bool get adsRemoved => _hasRemovedAds;
  DateTime? get subscriptionExpiry => _subscriptionExpiry;

  // Getters
  bool get isPremium => _isPremium;
  bool get hasRemovedAds => _hasRemovedAds;
  bool get isLoading => _isLoading;
  
  // For web, we'll simulate products
  List<Map<String, dynamic>> get products => [
    {
      'id': 'monthly_subscription',
      'title': 'QuitVaping Premium Monthly',
      'description': 'Unlimited AI chat, advanced analytics, and more',
      'price': '\$4.99',
    },
    {
      'id': 'yearly_subscription', 
      'title': 'QuitVaping Premium Yearly',
      'description': 'Unlimited AI chat, advanced analytics, and more',
      'price': '\$39.99',
    },
    {
      'id': 'remove_ads',
      'title': 'Remove Ads',
      'description': 'Remove all advertisements',
      'price': '\$2.99',
    },
  ];

  Map<String, dynamic>? get monthlySubscription {
    return products.firstWhere(
      (product) => product['id'] == 'monthly_subscription',
      orElse: () => {},
    );
  }

  Map<String, dynamic>? get yearlySubscription {
    return products.firstWhere(
      (product) => product['id'] == 'yearly_subscription', 
      orElse: () => {},
    );
  }

  Map<String, dynamic>? get removeAdsProduct {
    return products.firstWhere(
      (product) => product['id'] == 'remove_ads',
      orElse: () => {},
    );
  }

  Future<void> initialize() async {
    if (kIsWeb) {
      debugPrint('SubscriptionService: Web version - in-app purchases not supported');
      return;
    }
    
    // For non-web platforms, this would initialize actual in-app purchases
  }

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();
    
    if (kIsWeb) {
      debugPrint('SubscriptionService: Web version - simulating product load');
      await Future.delayed(const Duration(milliseconds: 500));
    }
    
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> purchaseSubscription(Map<String, dynamic> product) async {
    if (kIsWeb) {
      debugPrint('SubscriptionService: Web version - simulating purchase of ${product['id']}');
      
      // Simulate purchase success for demo purposes
      if (product['id'] == 'monthly_subscription' || product['id'] == 'yearly_subscription') {
        _isPremium = true;
      } else if (product['id'] == 'remove_ads') {
        _hasRemovedAds = true;
      }
      
      notifyListeners();
      return true;
    }
    
    // For non-web platforms, this would handle actual purchases
    return false;
  }

  Future<void> restorePurchases() async {
    if (kIsWeb) {
      debugPrint('SubscriptionService: Web version - restore purchases not needed');
      return;
    }
    
    // For non-web platforms, this would restore actual purchases
  }

  void dispose() {
    super.dispose();
  }
}