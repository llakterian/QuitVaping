import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quit_vaping/data/models/subscription_model.dart';
import 'package:quit_vaping/data/services/subscription_service.dart';
import 'package:quit_vaping/shared/theme/app_colors.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool _yearlySelected = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final subscriptionService = Provider.of<SubscriptionService>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Subscription'),
        actions: [
          TextButton(
            onPressed: () async {
              setState(() => _isLoading = true);
              await subscriptionService.restorePurchases();
              setState(() => _isLoading = false);
              
              if (!mounted) return;
              
              if (subscriptionService.isPremium) {
      if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Subscription restored successfully!')),
                );
              } else {
      if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No previous subscription found')),
                );
              }
            },
            child: const Text('Restore'),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : subscriptionService.isLoading
              ? const Center(child: CircularProgressIndicator())
              : _buildSubscriptionContent(context, subscriptionService),
    );
  }

  Widget _buildSubscriptionContent(BuildContext context, SubscriptionService subscriptionService) {
    final premiumPlan = subscriptionPlans.firstWhere((plan) => plan.id == 'premium');
    final freePlan = subscriptionPlans.firstWhere((plan) => plan.id == 'free');
    
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Text(
              'Upgrade to Premium',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Get access to all features and support your quit journey',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            
            // Billing toggle
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _yearlySelected = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: !_yearlySelected ? AppColors.primary : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          'Monthly',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: !_yearlySelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _yearlySelected = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _yearlySelected ? AppColors.primary : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              'Yearly',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _yearlySelected ? Colors.white : Colors.black,
                              ),
                            ),
                            Positioned(
                              right: 10,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  'SAVE 44%',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Price display
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 26),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    _yearlySelected
                        ? '\$${premiumPlan.yearlyPrice.toStringAsFixed(2)}/year'
                        : '\$${premiumPlan.monthlyPrice.toStringAsFixed(2)}/month',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                  ),
                  if (_yearlySelected)
                    Text(
                      'Just \$${(premiumPlan.yearlyPrice / 12).toStringAsFixed(2)} per month',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  const SizedBox(height: 8),
                  Text(
                    '7-day free trial',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Cancel anytime',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Feature comparison
            Text(
              'Premium Features',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            
            // Feature list
            ...subscriptionFeatures.map((feature) {
              final isPremiumFeature = feature.isPremiumOnly;
              final _ = freePlan.features.contains(feature.id);
              
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Icon(
                      isPremiumFeature ? Icons.check_circle : Icons.check_circle_outline,
                      color: isPremiumFeature ? AppColors.primary : Colors.grey,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            feature.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isPremiumFeature ? Colors.black : Colors.grey,
                            ),
                          ),
                          Text(
                            feature.description,
                            style: TextStyle(
                              fontSize: 12,
                              color: isPremiumFeature ? Colors.black87 : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isPremiumFeature)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'PREMIUM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
            
            const SizedBox(height: 32),
            
            // Subscribe button
            ElevatedButton(
              onPressed: subscriptionService.isPremium
                  ? null
                  : () async {
                      final productDetails = _yearlySelected
                          ? subscriptionService.yearlySubscription
                          : subscriptionService.monthlySubscription;
                          
                      if (productDetails != null) {
                        setState(() => _isLoading = true);
                        final success = await subscriptionService.purchaseSubscription(productDetails);
                        setState(() => _isLoading = false);
                        
                        if (!mounted) return;
                        
                        if (!success) {
      if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Purchase could not be completed')),
                          );
                        }
                      } else {
      if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Product not available')),
                        );
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                subscriptionService.isPremium
                    ? 'You are a Premium Member'
                    : 'Start 7-Day Free Trial',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Remove ads only button
            if (!subscriptionService.adsRemoved && !subscriptionService.isPremium)
              OutlinedButton(
                onPressed: () async {
                  final removeAdsProduct = subscriptionService.removeAdsProduct;
                  
                  if (removeAdsProduct != null) {
                    setState(() => _isLoading = true);
                    final success = await subscriptionService.purchaseSubscription(removeAdsProduct);
                    setState(() => _isLoading = false);
                    
                    if (!mounted) return;
                    
                    if (!success) {
      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Purchase could not be completed')),
                      );
                    }
                  } else {
      if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Product not available')),
                    );
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Remove Ads Only (\$3.99)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              
            const SizedBox(height: 24),
            
            // Terms and privacy
            const Text(
              'By subscribing, you agree to our Terms of Service and Privacy Policy. '
              'Subscriptions will automatically renew unless canceled at least 24 hours before the end of the current period. '
              'You can cancel anytime in your Google Play account settings.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}