# QuitVaping App Monetization Setup

This document outlines the monetization strategy and setup instructions for the QuitVaping app.

## Monetization Strategy

The QuitVaping app uses a freemium model with the following components:

1. **Free Tier**: Basic features including puff tracking, quit date tracking, health milestones, and limited access to features
2. **Premium Subscription**: Enhanced features and unlimited access
3. **Ad-Free Purchase**: One-time purchase to remove ads while keeping the free tier features

### Pricing Structure

- **Monthly Subscription**: $5.99/month
- **Annual Subscription**: $39.99/year (Save 44%)
- **Remove Ads Only**: $3.99 (one-time purchase)

## Setup Instructions

### 1. Google Play Console Setup

1. Log in to your [Google Play Console](https://play.google.com/console)
2. Navigate to your app > Monetize > Products > In-app products
3. Create the following in-app products:

#### Subscription Products
- **Product ID**: `quit_vaping_premium_monthly`
  - **Name**: Monthly Premium
  - **Description**: Unlimited access to all premium features
  - **Price**: $5.99 USD (adjust for other currencies)
  - **Subscription Type**: Auto-renewing
  - **Billing Period**: Monthly

- **Product ID**: `quit_vaping_premium_yearly`
  - **Name**: Annual Premium
  - **Description**: Unlimited access to all premium features (save 44%)
  - **Price**: $39.99 USD (adjust for other currencies)
  - **Subscription Type**: Auto-renewing
  - **Billing Period**: Annual
  - **Free Trial**: 7 days

#### One-time Purchase
- **Product ID**: `quit_vaping_remove_ads`
  - **Name**: Remove Ads
  - **Description**: Remove all advertisements from the app
  - **Price**: $3.99 USD (adjust for other currencies)
  - **Type**: Managed product

### 2. AdMob Setup

1. Create an account on [Google AdMob](https://admob.google.com)
2. Create a new app and get your AdMob App ID
3. Replace the test AdMob ID in `android/app/src/main/AndroidManifest.xml` with your actual AdMob App ID:

```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="YOUR-ADMOB-APP-ID"/>
```

4. Create ad units for:
   - Banner ads
   - Interstitial ads
   - Rewarded ads

5. Replace the test ad unit IDs in `lib/data/services/ad_service.dart` with your actual ad unit IDs:

```dart
static const String _bannerAdUnitIdAndroid = 'YOUR-BANNER-AD-UNIT-ID';
static const String _bannerAdUnitIdiOS = 'YOUR-IOS-BANNER-AD-UNIT-ID';
static const String _interstitialAdUnitIdAndroid = 'YOUR-INTERSTITIAL-AD-UNIT-ID';
static const String _interstitialAdUnitIdiOS = 'YOUR-IOS-INTERSTITIAL-AD-UNIT-ID';
static const String _rewardedAdUnitIdAndroid = 'YOUR-REWARDED-AD-UNIT-ID';
static const String _rewardedAdUnitIdiOS = 'YOUR-IOS-REWARDED-AD-UNIT-ID';
```

### 3. Testing In-App Purchases

1. Add test accounts in Google Play Console > Settings > Developer account > Account details > License testing
2. Use the test accounts to verify the purchase flow without being charged
3. For testing subscriptions, use shorter test durations in the Play Console

### 4. Ad Placement Guidelines

- **Banner Ads**: Place at the bottom of screens for free users
- **Interstitial Ads**: Show after completing certain actions (e.g., completing a breathing exercise)
- **Rewarded Ads**: Offer as an option to unlock premium features temporarily

### 5. Premium Features

The following features are restricted to premium users:

- Unlimited AI Coach conversations
- Advanced breathing exercises (4-7-8 and Diaphragmatic)
- Personalized quit plans
- Advanced analytics and insights
- Ad-free experience
- Community access

## Implementation Notes

- The `SubscriptionService` class handles all subscription logic
- The `AdService` class manages ad loading and display
- The `PremiumFeatureOverlay` widget is used to restrict premium features
- Premium status is stored locally and verified on app startup

## Best Practices

1. **Transparency**: Clearly communicate what features are premium
2. **Value Proposition**: Ensure premium features provide clear value
3. **Free Trial**: Offer a 7-day free trial to increase conversion
4. **Ad Frequency**: Limit ad frequency to avoid user frustration
5. **Restore Purchases**: Always provide an option to restore purchases

## Compliance Requirements

- Include a privacy policy that discloses data collection for ads
- Ensure all in-app purchases use Google Play Billing
- Comply with Google Play's subscription cancellation policies
- Include terms of service for subscriptions

## Analytics and Optimization

Track the following metrics to optimize monetization:

- Conversion rate from free to premium
- Subscription renewal rate
- Ad click-through rate
- Most popular premium features
- User retention by tier (free vs premium)

Use A/B testing to optimize:
- Subscription pricing
- Free trial duration
- Premium feature bundles
- Ad placement and frequency