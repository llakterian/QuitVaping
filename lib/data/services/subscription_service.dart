import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/env_config.dart';

enum SubscriptionTier {
  free,
  premium,
}

class SubscriptionService with ChangeNotifier {
  static const String _subscriptionStatusKey = 'subscription_status';
  static const String _subscriptionExpiryKey = 'subscription_expiry';
  
  // Product IDs from environment configuration
  String get _monthlySubscriptionId => EnvConfig.iapMonthlySubscriptionId;
  String get _yearlySubscriptionId => EnvConfig.iapYearlySubscriptionId;
  String get _removeAdsId => EnvConfig.iapRemoveAdsId;
  
  // Use test products based on environment configuration
  bool get _useTestProducts => EnvConfig.useTestIap;
  
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
    try {
      // Load saved subscription status
      await _loadSavedStatus();
      
      // Initialize in-app purchase
      final isAvailable = await _inAppPurchase.isAvailable();
      if (!isAvailable) {
        debugPrint('In-app purchases not available on this device');
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Set up purchase stream listener
      _subscription = _inAppPurchase.purchaseStream.listen(
        _handlePurchaseUpdates,
        onDone: () => _subscription?.cancel(),
        onError: (error) {
          debugPrint('Purchase stream error: $error');
          // Continue with the app even if there's an error with the purchase stream
        },
      );

      // Load product details
      await _loadProducts();
      
      // Restore purchases to ensure user has access to what they've already bought
      // This is required by app store policies
      await restorePurchases();
      
      debugPrint('SubscriptionService initialized successfully');
    } catch (e) {
      debugPrint('Error initializing SubscriptionService: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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
      // Keep track of the purchase status for analytics and debugging
      debugPrint('Purchase status for ${purchaseDetails.productID}: ${purchaseDetails.status}');
      
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // Purchase is pending - could add UI indicator here if needed
        debugPrint('Purchase pending for ${purchaseDetails.productID}');
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        // Handle error - important for compliance to properly handle errors
        debugPrint('Purchase error for ${purchaseDetails.productID}: ${purchaseDetails.error?.message}');
        
        // You could show an error message to the user here
        // This is important for transparency required by app stores
      } else if (purchaseDetails.status == PurchaseStatus.purchased || 
                purchaseDetails.status == PurchaseStatus.restored) {
        // Verify the purchase - this is required by app store policies
        // In a production app, you should verify receipts with your backend
        
        // For testing, we'll assume all purchases are valid
        // In production, you should implement server-side validation
        bool valid = true;
        if (_useTestProducts) {
          debugPrint('Test purchase - skipping validation for ${purchaseDetails.productID}');
        } else {
          // Here you would validate the purchase with your backend
          // valid = await _validatePurchase(purchaseDetails);
          debugPrint('Production purchase - validation would happen here for ${purchaseDetails.productID}');
        }
        
        if (valid) {
          // Grant entitlement for the purchased product
          await _handleSuccessfulPurchase(purchaseDetails);
        } else {
          debugPrint('Invalid purchase detected for ${purchaseDetails.productID}');
          // In a real app, you might want to report this to your backend
        }
      }
      
      // This is required by the in_app_purchase plugin to complete the transaction
      // Failing to call this can result in app store compliance issues
      if (purchaseDetails.pendingCompletePurchase) {
        try {
          await _inAppPurchase.completePurchase(purchaseDetails);
          debugPrint('Purchase completed for ${purchaseDetails.productID}');
        } catch (e) {
          debugPrint('Error completing purchase for ${purchaseDetails.productID}: $e');
        }
      }
    }
  }

  Future<void> _handleSuccessfulPurchase(PurchaseDetails purchase) async {
    debugPrint('Handling successful purchase for ${purchase.productID}');
    
    try {
      // Handle subscription products
      if (purchase.productID == _monthlySubscriptionId || 
          purchase.productID == _yearlySubscriptionId) {
        _currentTier = SubscriptionTier.premium;
        
        // Set expiry date based on subscription type
        // In a production app, you should extract the actual expiry date from the purchase receipt
        // This is just a placeholder implementation
        final now = DateTime.now();
        if (purchase.productID == _monthlySubscriptionId) {
          _subscriptionExpiry = DateTime(now.year, now.month + 1, now.day);
          debugPrint('Monthly subscription activated until ${_subscriptionExpiry.toString()}');
        } else {
          _subscriptionExpiry = DateTime(now.year + 1, now.month, now.day);
          debugPrint('Yearly subscription activated until ${_subscriptionExpiry.toString()}');
        }
        
        await _saveSubscriptionStatus();
      }
      
      // Handle remove ads product
      if (purchase.productID == _removeAdsId) {
        _adsRemoved = true;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('ads_removed', true);
        debugPrint('Ads removed permanently');
      }
      
      // Store purchase receipt for verification
      // In a production app, you should send this to your backend for validation
      if (purchase.verificationData.serverVerificationData.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
          'purchase_receipt_${purchase.productID}', 
          purchase.verificationData.serverVerificationData
        );
        debugPrint('Purchase receipt stored for ${purchase.productID}');
      }
      
      notifyListeners();
    } catch (e) {
      debugPrint('Error handling successful purchase: $e');
    }
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