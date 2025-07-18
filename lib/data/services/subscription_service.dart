import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SubscriptionTier {
  free,
  premium,
}

class SubscriptionService with ChangeNotifier {
  static const String _subscriptionStatusKey = 'subscription_status';
  static const String _subscriptionExpiryKey = 'subscription_expiry';
  
  // Product IDs
  static const String _monthlySubscriptionId = 'quit_vaping_premium_monthly';
  static const String _yearlySubscriptionId = 'quit_vaping_premium_yearly';
  static const String _removeAdsId = 'quit_vaping_remove_ads';
  
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  List<ProductDetails> _products = [];
  SubscriptionTier _currentTier = SubscriptionTier.free;
  bool _isLoading = true;
  bool _adsRemoved = false;
  DateTime? _subscriptionExpiry;

  SubscriptionService() {
    _initialize();
  }

  // Getters
  bool get isLoading => _isLoading;
  bool get isPremium => _currentTier == SubscriptionTier.premium;
  bool get adsRemoved => _adsRemoved || isPremium;
  List<ProductDetails> get products => _products;
  DateTime? get subscriptionExpiry => _subscriptionExpiry;
  
  ProductDetails? get monthlySubscription {
    try {
      return _products.firstWhere((product) => product.id == _monthlySubscriptionId);
    } catch (e) {
      return null;
    }
  }
                         
  ProductDetails? get yearlySubscription {
    try {
      return _products.firstWhere((product) => product.id == _yearlySubscriptionId);
    } catch (e) {
      return null;
    }
  }
                         
  ProductDetails? get removeAdsProduct {
    try {
      return _products.firstWhere((product) => product.id == _removeAdsId);
    } catch (e) {
      return null;
    }
  }

  Future<void> _initialize() async {
    // Load saved subscription status
    await _loadSavedStatus();
    
    // Initialize in-app purchase
    final isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    // Set up purchase stream listener
    _subscription = _inAppPurchase.purchaseStream.listen(
      _handlePurchaseUpdates,
      onDone: () => _subscription?.cancel(),
      onError: (error) => debugPrint('Purchase error: $error'),
    );

    // Load product details
    await _loadProducts();
    
    // Restore purchases
    await restorePurchases();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _loadSavedStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final statusString = prefs.getString(_subscriptionStatusKey) ?? '';
    final expiryTimestamp = prefs.getInt(_subscriptionExpiryKey);
    
    if (statusString == SubscriptionTier.premium.toString()) {
      _currentTier = SubscriptionTier.premium;
    }
    
    if (expiryTimestamp != null) {
      _subscriptionExpiry = DateTime.fromMillisecondsSinceEpoch(expiryTimestamp);
      
      // Check if subscription has expired
      if (_subscriptionExpiry!.isBefore(DateTime.now())) {
        _currentTier = SubscriptionTier.free;
        _subscriptionExpiry = null;
        await _saveSubscriptionStatus();
      }
    }
  }

  Future<void> _loadProducts() async {
    final productIds = <String>{
      _monthlySubscriptionId,
      _yearlySubscriptionId,
      _removeAdsId,
    };
    
    final response = await _inAppPurchase.queryProductDetails(productIds);
    
    if (response.error != null) {
      debugPrint('Error loading products: ${response.error}');
      return;
    }
    
    _products = response.productDetails;
    notifyListeners();
  }

  Future<void> _handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) async {
    for (final purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // Show pending UI
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        // Handle error
        debugPrint('Purchase error: ${purchaseDetails.error}');
      } else if (purchaseDetails.status == PurchaseStatus.purchased || 
                purchaseDetails.status == PurchaseStatus.restored) {
        // Grant entitlement for the purchased product
        await _handleSuccessfulPurchase(purchaseDetails);
      }
      
      if (purchaseDetails.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchaseDetails);
      }
    }
  }

  Future<void> _handleSuccessfulPurchase(PurchaseDetails purchase) async {
    // Handle subscription products
    if (purchase.productID == _monthlySubscriptionId || 
        purchase.productID == _yearlySubscriptionId) {
      _currentTier = SubscriptionTier.premium;
      
      // Set expiry date based on subscription type
      final now = DateTime.now();
      if (purchase.productID == _monthlySubscriptionId) {
        _subscriptionExpiry = DateTime(now.year, now.month + 1, now.day);
      } else {
        _subscriptionExpiry = DateTime(now.year + 1, now.month, now.day);
      }
      
      await _saveSubscriptionStatus();
    }
    
    // Handle remove ads product
    if (purchase.productID == _removeAdsId) {
      _adsRemoved = true;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('ads_removed', true);
    }
    
    notifyListeners();
  }

  Future<void> _saveSubscriptionStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_subscriptionStatusKey, _currentTier.toString());
    
    if (_subscriptionExpiry != null) {
      await prefs.setInt(_subscriptionExpiryKey, _subscriptionExpiry!.millisecondsSinceEpoch);
    } else {
      await prefs.remove(_subscriptionExpiryKey);
    }
  }

  Future<bool> purchaseSubscription(ProductDetails product) async {
    try {
      final purchaseParam = PurchaseParam(productDetails: product);
      return await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      debugPrint('Error purchasing subscription: $e');
      return false;
    }
  }

  Future<void> restorePurchases() async {
    try {
      await _inAppPurchase.restorePurchases();
    } catch (e) {
      debugPrint('Error restoring purchases: $e');
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}