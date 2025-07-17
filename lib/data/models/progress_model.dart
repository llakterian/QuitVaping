import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress_model.g.dart';
part 'progress_model.freezed.dart';

@freezed
class ProgressModel with _$ProgressModel {
  const ProgressModel._();
  
  const factory ProgressModel({
    required String userId,
    required DateTime quitDate,
    required double dailySavings, // Money saved per day
    required Map<String, bool> achievedMilestones,
    required int currentStreak, // Days
    required int longestStreak, // Days
    List<DateTime>? relapses,
    Map<String, dynamic>? withdrawalSymptoms,
    required List<AchievementModel> achievements,
    Map<String, dynamic>? aiRecommendations,
  }) = _ProgressModel;

  factory ProgressModel.fromJson(Map<String, dynamic> json) => _$ProgressModelFromJson(json);
  
  // Calculate days since quitting
  int get daysSinceQuitting {
    return DateTime.now().difference(quitDate).inDays;
  }

  // Calculate hours since quitting
  int get hoursSinceQuitting {
    return DateTime.now().difference(quitDate).inHours;
  }

  // Calculate minutes since quitting
  int get minutesSinceQuitting {
    return DateTime.now().difference(quitDate).inMinutes;
  }

  // Calculate total money saved
  double get totalMoneySaved {
    return daysSinceQuitting * dailySavings;
  }

  // Get next health milestone
  Map<String, dynamic> getNextMilestone(Map<int, String> healthMilestones) {
    final hoursQuit = hoursSinceQuitting;
    
    // Find the next milestone
    int? nextMilestoneHours;
    String? nextMilestoneDescription;
    
    for (final entry in healthMilestones.entries) {
      if (entry.key > hoursQuit) {
        nextMilestoneHours = entry.key;
        nextMilestoneDescription = entry.value;
        break;
      }
    }
    
    if (nextMilestoneHours == null) {
      return {
        'completed': true,
        'message': 'You\'ve reached all tracked health milestones! Your body continues to heal.'
      };
    }
    
    final hoursRemaining = nextMilestoneHours - hoursQuit;
    final daysRemaining = hoursRemaining ~/ 24;
    final remainingHours = hoursRemaining % 24;
    
    return {
      'completed': false,
      'hours_remaining': hoursRemaining,
      'days_remaining': daysRemaining,
      'remaining_hours': remainingHours,
      'description': nextMilestoneDescription,
      'total_hours': nextMilestoneHours,
    };
  }
}

@freezed
class AchievementModel with _$AchievementModel {
  const factory AchievementModel({
    required String id,
    required String title,
    required String description,
    required String category, // health, streak, financial, etc.
    required DateTime unlockedAt,
    required String iconPath,
    required int pointValue,
  }) = _AchievementModel;

  factory AchievementModel.fromJson(Map<String, dynamic> json) => _$AchievementModelFromJson(json);
}