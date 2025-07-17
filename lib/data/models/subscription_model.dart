import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subscription_model.freezed.dart';
part 'subscription_model.g.dart';

@freezed
class SubscriptionFeature with _$SubscriptionFeature {
  const factory SubscriptionFeature({
    required String id,
    required String name,
    required String description,
    required bool isPremiumOnly,
  }) = _SubscriptionFeature;

  factory SubscriptionFeature.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFeatureFromJson(json);
}

@freezed
class SubscriptionPlan with _$SubscriptionPlan {
  const factory SubscriptionPlan({
    required String id,
    required String name,
    required String description,
    required double monthlyPrice,
    required double yearlyPrice,
    required List<String> features,
    @Default(false) bool isMostPopular,
  }) = _SubscriptionPlan;

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPlanFromJson(json);
}

// Define available subscription plans
final List<SubscriptionPlan> subscriptionPlans = [
  SubscriptionPlan(
    id: 'free',
    name: 'Free',
    description: 'Basic features to help you start your quit journey',
    monthlyPrice: 0,
    yearlyPrice: 0,
    features: [
      'basic_tracking',
      'health_milestones',
      'basic_tips',
      'puff_counter',
    ],
  ),
  SubscriptionPlan(
    id: 'premium',
    name: 'Premium',
    description: 'Complete toolkit for your quit journey with personalized support',
    monthlyPrice: 5.99,
    yearlyPrice: 39.99,
    features: [
      'basic_tracking',
      'health_milestones',
      'basic_tips',
      'puff_counter',
      'personalized_plan',
      'advanced_analytics',
      'unlimited_ai_chat',
      'guided_meditation',
      'ad_free',
      'craving_management',
      'community_access',
    ],
    isMostPopular: true,
  ),
];

// Define all available features
final List<SubscriptionFeature> subscriptionFeatures = [
  SubscriptionFeature(
    id: 'basic_tracking',
    name: 'Basic Tracking',
    description: 'Track your quit date and money saved',
    isPremiumOnly: false,
  ),
  SubscriptionFeature(
    id: 'health_milestones',
    name: 'Health Milestones',
    description: 'See how your body recovers over time',
    isPremiumOnly: false,
  ),
  SubscriptionFeature(
    id: 'basic_tips',
    name: 'Basic Tips',
    description: 'Get general tips to help you quit',
    isPremiumOnly: false,
  ),
  SubscriptionFeature(
    id: 'puff_counter',
    name: 'Puff Counter',
    description: 'Track your daily vaping habits',
    isPremiumOnly: false,
  ),
  SubscriptionFeature(
    id: 'personalized_plan',
    name: 'Personalized Quit Plan',
    description: 'Get a customized plan based on your habits',
    isPremiumOnly: true,
  ),
  SubscriptionFeature(
    id: 'advanced_analytics',
    name: 'Advanced Analytics',
    description: 'Detailed insights into your progress',
    isPremiumOnly: true,
  ),
  SubscriptionFeature(
    id: 'unlimited_ai_chat',
    name: 'Unlimited AI Support',
    description: 'Chat with our AI coach anytime',
    isPremiumOnly: true,
  ),
  SubscriptionFeature(
    id: 'guided_meditation',
    name: 'Guided Meditation',
    description: 'Access to stress-relief meditation sessions',
    isPremiumOnly: true,
  ),
  SubscriptionFeature(
    id: 'ad_free',
    name: 'Ad-Free Experience',
    description: 'Enjoy the app without advertisements',
    isPremiumOnly: true,
  ),
  SubscriptionFeature(
    id: 'craving_management',
    name: 'Advanced Craving Management',
    description: 'Tools to manage and overcome cravings',
    isPremiumOnly: true,
  ),
  SubscriptionFeature(
    id: 'community_access',
    name: 'Community Access',
    description: 'Connect with others on their quit journey',
    isPremiumOnly: true,
  ),
];