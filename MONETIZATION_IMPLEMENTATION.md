# QuitVaping App Monetization Implementation

This document provides an overview of how the monetization strategy has been implemented in the QuitVaping app.

## Monetization Model

The QuitVaping app uses a freemium model with the following components:

1. **Free Tier**: Basic features with limited functionality
2. **Premium Subscription**: Enhanced features and unlimited access
3. **Ad-Free Purchase**: One-time purchase to remove ads while keeping the free tier features

## Implementation Details

### 1. Subscription Service

The `SubscriptionService` class (`lib/data/services/subscription_service.dart`) handles all subscription-related functionality:

- Manages subscription state (free vs premium)
- Handles in-app purchase transactions
- Stores subscription status locally
- Provides subscription status to the app
- Handles subscription restoration

### 2. Ad Service

The `AdService` class (`lib/data/services/ad_service.dart`) manages all ad-related functionality:

- Initializes Google Mobile Ads
- Loads and displays banner ads
- Manages interstitial and rewarded ads
- Provides ad unit IDs based on platform

### 3. Premium Feature Overlay

The `PremiumFeatureOverlay` widget (`lib/features/subscription/widgets/premium_feature_overlay.dart`) is used to restrict access to premium features:

- Displays a blurred version of the premium feature
- Shows an upgrade prompt
- Provides a button to navigate to the subscription screen

### 4. Subscription Screen

The `SubscriptionScreen` (`lib/features/subscription/screens/subscription_screen.dart`) allows users to:

- View subscription options (monthly/yearly)
- Compare features between free and premium tiers
- Purchase subscriptions
- Restore previous purchases
- Remove ads with a one-time purchase

### 5. Banner Ad Widget

The `BannerAdWidget` (`lib/features/subscription/widgets/banner_ad_widget.dart`) displays banner ads to free users:

- Automatically hides for premium users
- Shows a placeholder while loading
- Handles ad loading errors

## Premium Features

The following features are restricted to premium users:

1. **AI Coach**: Unlimited conversations with the AI coach
   - Free users see a premium overlay on the AI Chat screen

2. **Advanced Breathing Exercises**: Premium breathing techniques
   - 4-7-8 Breathing and Diaphragmatic Breathing are premium-only
   - Free users can still access Box Breathing and Pursed Lip Breathing

3. **NRT Analytics**: Advanced analytics and insights for NRT usage
   - Free users see a premium overlay on the Analytics tab
   - Premium users get personalized recommendations and detailed charts

4. **Advanced Panic Mode Techniques**: Premium distraction techniques for cravings
   - Progressive Muscle Relaxation, Guided Imagery, Mindful Body Scan, and Personalized Craving Analysis
   - Free users can still access basic techniques like 5-4-3-2-1 Grounding and Quick Physical Activity
   - Premium techniques are clearly marked and locked for free users

5. **Craving Analytics**: Advanced analytics and insights for craving patterns
   - Free users see a premium overlay on the Analytics tab of the check-in screen
   - Premium users get detailed charts showing trigger distribution, intensity trends, and time-of-day patterns
   - Includes personalized recommendations based on the user's craving data

6. **Personalized Insights**: Advanced analytics and predictions on the home screen
   - Free users see a premium upgrade prompt
   - Premium users get detailed insights including financial projections, health improvement metrics, and personalized recommendations
   - Provides data-driven guidance based on the user's quit journey progress

## Configuration Files

1. **Android Manifest**: Updated with necessary permissions and AdMob configuration
   - Added internet permission
   - Added billing permission
   - Added AdMob app ID

2. **build.gradle**: Updated with required dependencies
   - Added Google Play Billing Library
   - Added Google Mobile Ads SDK

3. **pubspec.yaml**: Added required packages
   - in_app_purchase: For handling in-app purchases
   - google_mobile_ads: For displaying ads
   - purchases_flutter: For subscription management

## Settings Integration

The Settings screen (`lib/features/settings/screens/settings_screen.dart`) includes:

- Subscription status display
- Option to upgrade to premium
- Option to restore purchases

## Home Screen Integration

The Home screen (`lib/features/tracker/screens/home_screen.dart`) includes:

- Premium upgrade banner for free users
- Banner ads at the bottom for free users

## Testing Instructions

1. **Testing In-App Purchases**:
   - Use test accounts in Google Play Console
   - Use test payment methods
   - Verify subscription state persistence

2. **Testing Ads**:
   - Test ads are implemented using test ad unit IDs
   - Verify ads are hidden for premium users
   - Test ad loading and display

## Next Steps

1. **Analytics**: Implement analytics to track conversion rates and user behavior
2. **A/B Testing**: Set up experiments to optimize pricing and feature bundling
3. **Promotions**: Implement limited-time offers and promotional codes
4. **Referral Program**: Add a referral system to incentivize user acquisition

## Resources

- Detailed setup instructions: See `MONETIZATION_SETUP.md`
- Google Play Billing Library documentation: https://developer.android.com/google/play/billing
- Google AdMob documentation: https://developers.google.com/admob