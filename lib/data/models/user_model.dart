import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';
part 'user_model.freezed.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String name,
    required int age,
    required String gender,
    String? email,
    required DateTime createdAt,
    required DateTime updatedAt,
    required VapingHistoryModel vapingHistory,
    required List<String> motivationFactors,
    DateTime? quitDate,
    @Default({}) Map<String, dynamic> preferences,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

@freezed
class VapingHistoryModel with _$VapingHistoryModel {
  const VapingHistoryModel._();
  
  const factory VapingHistoryModel({
    required int dailyFrequency,
    required int nicotineStrength, // in mg
    required double yearsVaping,
    required String deviceType,
    required List<String> commonTriggers,
    required List<String> previousQuitAttempts,
    int? longestQuitDuration, // in days
  }) = _VapingHistoryModel;

  factory VapingHistoryModel.fromJson(Map<String, dynamic> json) => _$VapingHistoryModelFromJson(json);
  
  // Calculate dependency score based on usage patterns
  double calculateDependencyScore() {
    // Weight factors for each component
    const frequencyWeight = 0.4;
    const strengthWeight = 0.3;
    const yearsWeight = 0.2;
    const attemptsWeight = 0.1;
    
    // Normalize values to 0-10 scale
    final frequencyScore = (dailyFrequency / 30) * 10; // Assuming max 30 times per day
    final strengthScore = (nicotineStrength / 50) * 10; // Assuming max 50mg
    final yearsScore = (yearsVaping / 10) * 10; // Assuming max 10 years
    
    // Previous attempts factor (more attempts might indicate stronger addiction)
    final attemptsScore = (previousQuitAttempts.length / 5) * 10; // Assuming max 5 attempts
    
    // Calculate weighted score
    return (frequencyScore * frequencyWeight) +
           (strengthScore * strengthWeight) +
           (yearsScore * yearsWeight) +
           (attemptsScore * attemptsWeight);
  }
}

// Extension methods for UserModel
extension UserModelExtension on UserModel {
  // Calculate dependency level based on vaping history
  String get dependencyLevel {
    final score = vapingHistory.calculateDependencyScore();
    
    if (score < 5) {
      return 'Mild';
    } else if (score < 10) {
      return 'Moderate';
    } else {
      return 'Severe';
    }
  }

  // Calculate days since quitting
  int get daysSinceQuitting {
    if (quitDate == null) return 0;
    return DateTime.now().difference(quitDate!).inDays;
  }

  // Calculate hours since quitting
  int get hoursSinceQuitting {
    if (quitDate == null) return 0;
    return DateTime.now().difference(quitDate!).inHours;
  }

  // Calculate minutes since quitting
  int get minutesSinceQuitting {
    if (quitDate == null) return 0;
    return DateTime.now().difference(quitDate!).inMinutes;
  }
}