// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
      gender: json['gender'] as String,
      email: json['email'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      vapingHistory: VapingHistoryModel.fromJson(
          json['vapingHistory'] as Map<String, dynamic>),
      motivationFactors: (json['motivationFactors'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      quitDate: json['quitDate'] == null
          ? null
          : DateTime.parse(json['quitDate'] as String),
      preferences: json['preferences'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'age': instance.age,
      'gender': instance.gender,
      'email': instance.email,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'vapingHistory': instance.vapingHistory,
      'motivationFactors': instance.motivationFactors,
      'quitDate': instance.quitDate?.toIso8601String(),
      'preferences': instance.preferences,
    };

_$VapingHistoryModelImpl _$$VapingHistoryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$VapingHistoryModelImpl(
      dailyFrequency: (json['dailyFrequency'] as num).toInt(),
      nicotineStrength: (json['nicotineStrength'] as num).toInt(),
      yearsVaping: (json['yearsVaping'] as num).toDouble(),
      deviceType: json['deviceType'] as String,
      commonTriggers: (json['commonTriggers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      previousQuitAttempts: (json['previousQuitAttempts'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      longestQuitDuration: (json['longestQuitDuration'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$VapingHistoryModelImplToJson(
        _$VapingHistoryModelImpl instance) =>
    <String, dynamic>{
      'dailyFrequency': instance.dailyFrequency,
      'nicotineStrength': instance.nicotineStrength,
      'yearsVaping': instance.yearsVaping,
      'deviceType': instance.deviceType,
      'commonTriggers': instance.commonTriggers,
      'previousQuitAttempts': instance.previousQuitAttempts,
      'longestQuitDuration': instance.longestQuitDuration,
    };
