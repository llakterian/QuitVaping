// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubscriptionFeatureImpl _$$SubscriptionFeatureImplFromJson(
        Map<String, dynamic> json) =>
    _$SubscriptionFeatureImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      isPremiumOnly: json['isPremiumOnly'] as bool,
    );

Map<String, dynamic> _$$SubscriptionFeatureImplToJson(
        _$SubscriptionFeatureImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'isPremiumOnly': instance.isPremiumOnly,
    };

_$SubscriptionPlanImpl _$$SubscriptionPlanImplFromJson(
        Map<String, dynamic> json) =>
    _$SubscriptionPlanImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      monthlyPrice: (json['monthlyPrice'] as num).toDouble(),
      yearlyPrice: (json['yearlyPrice'] as num).toDouble(),
      features:
          (json['features'] as List<dynamic>).map((e) => e as String).toList(),
      isMostPopular: json['isMostPopular'] as bool? ?? false,
    );

Map<String, dynamic> _$$SubscriptionPlanImplToJson(
        _$SubscriptionPlanImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'monthlyPrice': instance.monthlyPrice,
      'yearlyPrice': instance.yearlyPrice,
      'features': instance.features,
      'isMostPopular': instance.isMostPopular,
    };
