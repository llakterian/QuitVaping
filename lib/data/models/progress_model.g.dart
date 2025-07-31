// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProgressModelImpl _$$ProgressModelImplFromJson(Map<String, dynamic> json) =>
    _$ProgressModelImpl(
      userId: json['userId'] as String,
      quitDate: DateTime.parse(json['quitDate'] as String),
      dailySavings: (json['dailySavings'] as num).toDouble(),
      achievedMilestones:
          Map<String, bool>.from(json['achievedMilestones'] as Map),
      currentStreak: (json['currentStreak'] as num).toInt(),
      longestStreak: (json['longestStreak'] as num).toInt(),
      relapses: (json['relapses'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
      withdrawalSymptoms: json['withdrawalSymptoms'] as Map<String, dynamic>?,
      achievements: (json['achievements'] as List<dynamic>)
          .map((e) => AchievementModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      aiRecommendations: json['aiRecommendations'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ProgressModelImplToJson(_$ProgressModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'quitDate': instance.quitDate.toIso8601String(),
      'dailySavings': instance.dailySavings,
      'achievedMilestones': instance.achievedMilestones,
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'relapses': instance.relapses?.map((e) => e.toIso8601String()).toList(),
      'withdrawalSymptoms': instance.withdrawalSymptoms,
      'achievements': instance.achievements,
      'aiRecommendations': instance.aiRecommendations,
    };

_$AchievementModelImpl _$$AchievementModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AchievementModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      unlockedAt: DateTime.parse(json['unlockedAt'] as String),
      iconPath: json['iconPath'] as String,
      pointValue: (json['pointValue'] as num).toInt(),
    );

Map<String, dynamic> _$$AchievementModelImplToJson(
        _$AchievementModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'unlockedAt': instance.unlockedAt.toIso8601String(),
      'iconPath': instance.iconPath,
      'pointValue': instance.pointValue,
    };
