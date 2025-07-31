import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/services/subscription_service.dart';
import '../../../shared/theme/app_colors.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final subscriptionService = Provider.of<SubscriptionService>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Subscription'),
        elevation: 0,
      ),
      body: subscriptionService.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildSubscriptionContent(context, subscriptionService),
    );
  }

  Widget _buildSubscriptionContent(
    BuildContext context,
    SubscriptionService subscriptionService,
  ) {
    final isPremium = subscriptionService.isPremium;
    
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            const Icon(
              Icons.star,
              size: 64,
              color: Colors.amber,
            ),
            const SizedBox(height: 16),
            Text(
              isPremium ? 'You\'re a Premium Member!' : 'Upgrade to Premium',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              isPremium
                  ? 'Enjoy all premium features until ${subscriptionService.subscriptionExpiry?.toString().split(' ')[0]}'
                  : 'Unlock all features and remove ads',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            
            // Features list
            _buildFeatureItem(
              context,
              'Advanced AI Coach',
              'Get personalized support from our advanced AI coach',
              Icons.psychology,
            ),
            _buildFeatureItem(
              context,
              'Ad-Free Experience',
              'Enjoy the app without any advertisements',
              Icons.block,
            ),
            _buildFeatureItem(
              context,
              'Detailed Analytics',
              'Access in-depth insights about your progress',
              Icons.analytics,
            ),
            _buildFeatureItem(
              context,
              'Unlimited Check-ins',
              'Track your cravings and moods without limits',
              Icons.check_circle,
            ),
            
            const SizedBox(height: 32),
            
            // Subscription options
            if (!isPremium) ...[
              // Monthly subscription
              if (subscriptionService.monthlySubscription != null)
                _buildSubscriptionOption(
                  context,
                  'Monthly Premium',
                  subscriptionService.monthlySubscription!.price,
                  'Billed monthly, cancel anytime',
                  () => _purchaseSubscription(
                    context,
                    subscriptionService,
                    subscriptionService.monthlySubscription!,
                  ),
                ),
              
              const SizedBox(height: 16),
              
              // Yearly subscription
              if (subscriptionService.yearlySubscription != null)
                _buildSubscriptionOption(
                  context,
                  'Yearly Premium',
                  subscriptionService.yearlySubscription!.price,
                  'Save 50% compared to monthly',
                  () => _purchaseSubscription(
                    context,
                    subscriptionService,
                    subscriptionService.yearlySubscription!,
                  ),
                  isPrimary: true,
                ),
              
              const SizedBox(height: 16),
              
              // Remove ads only
              if (subscriptionService.removeAdsProduct != null)
                _buildSubscriptionOption(
                  context,
                  'Remove Ads',
                  subscriptionService.removeAdsProduct!.price,
                  'One-time purchase, no subscription',
                  () => _purchaseSubscription(
                    context,
                    subscriptionService,
                    subscriptionService.removeAdsProduct!,
                  ),
                  isPrimary: false,
                ),
              
              const SizedBox(height: 24),
              
              // Restore purchases button
              TextButton(
                onPressed: _isLoading
                    ? null
                    : () async {
                        setState(() {
                          _isLoading = true;
                        });
                        
                        await subscriptionService.restorePurchases();
                        
                        setState(() {
                          _isLoading = false;
                        });
                        
                        if (!mounted) return;
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Purchases restored successfully'),
                          ),
                        );
                      },
                child: const Text('Restore Purchases'),
              ),
              
              const SizedBox(height: 16),
              
              // Terms and privacy
              const Text(
                'By subscribing, you agree to our Terms of Service and Privacy Policy. '
                'Subscriptions will automatically renew unless canceled at least 24 hours before the end of the current period. '
                'You can cancel anytime in your App Store or Google Play account settings.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ] else ...[
              // Already premium
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Continue Enjoying Premium'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context,
    String title,
    String description,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionOption(
    BuildContext context,
    String title,
    String price,
    String description,
    VoidCallback onTap, {
    bool isPrimary = false,
  }) {
    return Card(
      elevation: isPrimary ? 4 : 1,
      color: isPrimary ? AppColors.primary : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isPrimary
            ? BorderSide.none
            : BorderSide(color: Colors.grey[300]!),
      ),
      child: InkWell(
        onTap: _isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isPrimary ? Colors.white : null,
                      ),
                    ),
                  ),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isPrimary ? Colors.white : AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: isPrimary ? Colors.white70 : Colors.grey[600],
                      ),
                    ),
                  ),
                  if (isPrimary)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'BEST VALUE',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _purchaseSubscription(
    BuildContext context,
    SubscriptionService subscriptionService,
    ProductDetails product,
  ) async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final success = await subscriptionService.purchaseSubscription(product);
      
      if (!mounted) return;
      
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Thank you for your purchase!'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Purchase was not completed.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}