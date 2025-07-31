import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionService {
  static final SubscriptionService _instance = SubscriptionService._internal();
  factory SubscriptionService() => _instance;
  SubscriptionService._internal();

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  
  // Product IDs - these should match your Google Play Console setup
  static const String premiumMonthlyId = 'premium_monthly';
  static const String premiumYearlyId = 'premium_yearly';
  static const String nrtTrialId = 'nrt_trial';
  static const String nrtPremiumId = 'nrt_premium';
  
  static const Set<String> _productIds = {
    premiumMonthlyId,
    premiumYearlyId,
    nrtTrialId,
    nrtPremiumId,
  };

  List<ProductDetails> _products = [];
  bool _isAvailable = false;
  bool _isPremiumUser = false;
  bool _hasNrtTrial = false;
  bool _hasNrtPremium = false;

  // Getters
  bool get isAvailable => _isAvailable;
  bool get isPremiumUser => _isPremiumUser;
  bool get hasNrtTrial => _hasNrtTrial;
  bool get hasNrtPremium => _hasNrtPremium;
  List<ProductDetails> get products => _products;

  Future<void> initialize() async {
    _isAvailable = await _inAppPurchase.isAvailable();
    
    if (_isAvailable) {
      await _loadProducts();
      await _loadPurchaseStatus();
      _listenToPurchaseUpdated();
    }
  }

  Future<void> _loadProducts() async {
    final ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(_productIds);
    
    if (response.notFoundIDs.isNotEmpty) {
      print('Products not found: ${response.notFoundIDs}');
    }
    
    _products = response.productDetails;
  }

  Future<void> _loadPurchaseStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isPremiumUser = prefs.getBool('isPremiumUser') ?? false;
    _hasNrtTrial = prefs.getBool('hasNrtTrial') ?? false;
    _hasNrtPremium = prefs.getBool('hasNrtPremium') ?? false;
  }

  void _listenToPurchaseUpdated() {
    _subscription = _inAppPurchase.purchaseStream.listen(
      (List<PurchaseDetails> purchaseDetailsList) {
        _handlePurchaseUpdates(purchaseDetailsList);
      },
      onDone: () {
        _subscription.cancel();
      },
      onError: (error) {
        print('Purchase stream error: $error');
      },
    );
  }

  Future<void> _handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // Handle pending purchase
        print('Purchase pending: ${purchaseDetails.productID}');
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        // Handle error
        print('Purchase error: ${purchaseDetails.error}');
      } else if (purchaseDetails.status == PurchaseStatus.purchased ||
                 purchaseDetails.status == PurchaseStatus.restored) {
        // Handle successful purchase
        await _handleSuccessfulPurchase(purchaseDetails);
      }

      if (purchaseDetails.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchaseDetails);
      }
    }
  }

  Future<void> _handleSuccessfulPurchase(PurchaseDetails purchaseDetails) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    switch (purchaseDetails.productID) {
      case premiumMonthlyId:
      case premiumYearlyId:
        _isPremiumUser = true;
        await prefs.setBool('isPremiumUser', true);
        await prefs.setString('premiumPurchaseDate', DateTime.now().toIso8601String());
        break;
      case nrtTrialId:
        _hasNrtTrial = true;
        await prefs.setBool('hasNrtTrial', true);
        await prefs.setString('nrtTrialPurchaseDate', DateTime.now().toIso8601String());
        break;
      case nrtPremiumId:
        _hasNrtPremium = true;
        await prefs.setBool('hasNrtPremium', true);
        await prefs.setString('nrtPremiumPurchaseDate', DateTime.now().toIso8601String());
        break;
    }
    
    print('Purchase successful: ${purchaseDetails.productID}');
  }

  Future<bool> purchaseProduct(String productId) async {
    if (!_isAvailable) return false;
    
    final ProductDetails? productDetails = _products.firstWhere(
      (product) => product.id == productId,
      orElse: () => throw Exception('Product not found: $productId'),
    );
    
    if (productDetails == null) return false;

    final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
    
    try {
      final bool success = await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
      return success;
    } catch (e) {
      print('Purchase failed: $e');
      return false;
    }
  }

  Future<void> restorePurchases() async {
    if (!_isAvailable) return;
    
    try {
      await _inAppPurchase.restorePurchases();
    } catch (e) {
      print('Restore purchases failed: $e');
    }
  }

  ProductDetails? getProduct(String productId) {
    try {
      return _products.firstWhere((product) => product.id == productId);
    } catch (e) {
      return null;
    }
  }

  void dispose() {
    _subscription.cancel();
  }

  // Helper methods for UI
  String getProductPrice(String productId) {
    final product = getProduct(productId);
    if (product?.price != null) {
      return product!.price;
    }
    
    // Fallback prices when Play Store products aren't loaded (for development/testing)
    switch (productId) {
      case premiumMonthlyId:
        return '\$4.99';
      case premiumYearlyId:
        return '\$29.99';
      case nrtTrialId:
        return '\$0.99';
      case nrtPremiumId:
        return '\$4.99';
      default:
        return 'N/A';
    }
  }

  String getProductTitle(String productId) {
    final product = getProduct(productId);
    return product?.title ?? 'Premium Feature';
  }

  String getProductDescription(String productId) {
    final product = getProduct(productId);
    return product?.description ?? 'Unlock premium features';
  }
}