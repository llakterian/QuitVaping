import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'package:flutter/material.dart';
import '../../../data/models/breathing_exercise_model.dart';
import '../../../shared/theme/app_colors.dart';
import '../utils/breathing_accessibility_utils.dart';

/// A card widget for displaying a breathing exercise in a list view
class BreathingExerciseCard extends StatelessWidget {
  /// The breathing exercise to display
  final BreathingExerciseModel exercise;
  
  /// Callback when the card is tapped
  final VoidCallback onTap;
  
  /// Callback when the start button is pressed
  final VoidCallback onStartPressed;
  
  /// Optional callback when the favorite button is pressed
  final Function(bool isFavorite)? onFavoriteToggled;
  
  /// Whether the exercise is marked as favorite
  final bool isFavorite;

  const BreathingExerciseCard({
    Key? key,
    required this.exercise,
    required this.onTap,
    required this.onStartPressed,
    this.onFavoriteToggled,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine the color based on the first tag if available
    Color cardColor = _getColorForTag();
    
    // Generate semantic label for screen readers
    final semanticLabel = BreathingAccessibilityUtils.getExerciseCardSemanticLabel(exercise, isFavorite);
    
    return Semantics(
      label: semanticLabel,
      button: true,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with icon and favorite button
              _buildHeader(cardColor),
              
              // Content with description and pattern
              _buildContent(),
              
              // Footer with duration and start button
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the header section with icon and favorite button
  Widget _buildHeader(Color cardColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 8, 8),
      child: Row(
        children: [
          // Exercise icon in a colored circle
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: cardColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getIconForExercise(),
              color: cardColor,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          
          // Exercise name
          Expanded(
            child: Text(
              exercise.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          // Favorite button if callback is provided
          if (onFavoriteToggled != null)
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () => onFavoriteToggled?.call(!isFavorite),
            ),
        ],
      ),
    );
  }

  /// Builds the content section with description and pattern
  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exercise description
          Text(
            exercise.description,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          
          // Breathing pattern visualization
          _buildPatternIndicator(),
          
          // Tags row
          if (exercise.tags.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildTagsRow(),
          ],
        ],
      ),
    );
  }

  /// Builds the footer section with duration and start button
  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        children: [
          // Duration indicator
          Row(
            children: [
              Icon(
                Icons.timer,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                _formatDuration(exercise.recommendedDuration),
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const Spacer(),
          
          // Start button
          ElevatedButton(
            onPressed: onStartPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text('Start'),
          ),
        ],
      ),
    );
  }

  /// Builds a visual representation of the breathing pattern
  Widget _buildPatternIndicator() {
    final pattern = exercise.defaultPattern;
    final totalDuration = pattern.inhaleSeconds + 
                         pattern.inhaleHoldSeconds + 
                         pattern.exhaleSeconds + 
                         pattern.exhaleHoldSeconds;
    
    return Row(
      children: [
        _buildPatternSegment('Inhale', pattern.inhaleSeconds, totalDuration, AppColors.primary),
        if (pattern.inhaleHoldSeconds > 0)
          _buildPatternSegment('Hold', pattern.inhaleHoldSeconds, totalDuration, AppColors.secondary),
        _buildPatternSegment('Exhale', pattern.exhaleSeconds, totalDuration, AppColors.tertiary),
        if (pattern.exhaleHoldSeconds > 0)
          _buildPatternSegment('Hold', pattern.exhaleHoldSeconds, totalDuration, AppColors.info),
      ],
    );
  }

  /// Builds a segment of the pattern indicator
  Widget _buildPatternSegment(String label, int seconds, int totalDuration, Color color) {
    // Calculate the flex based on the proportion of time
    final flex = (seconds * 100 ~/ totalDuration).clamp(10, 100);
    
    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$seconds s',
            style: TextStyle(
              fontSize: 10,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a row of tags for the exercise
  Widget _buildTagsRow() {
    return SizedBox(
      height: 24,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: exercise.tags.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: _getColorForTag(index: index).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _getColorForTag(index: index).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Text(
              exercise.tags[index],
              style: TextStyle(
                fontSize: 12,
                color: _getColorForTag(index: index),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Returns an appropriate icon for the exercise based on its name or first tag
  IconData _getIconForExercise() {
    final name = exercise.name.toLowerCase();
    
    if (name.contains('box') || name.contains('square')) {
      return Icons.crop_square_outlined;
    } else if (name.contains('4-7-8')) {
      return Icons.looks_4_outlined;
    } else if (name.contains('diaphragm') || name.contains('belly')) {
      return Icons.air;
    } else if (name.contains('nostril')) {
      return Icons.face;
    } else if (name.contains('pursed') || name.contains('lip')) {
      return Icons.sentiment_satisfied_alt;
    } else if (name.contains('coherent')) {
      return Icons.waves;
    } else if (exercise.tags.isNotEmpty) {
      // Fallback to tag-based icons
      final tag = exercise.tags[0].toLowerCase();
      if (tag.contains('stress') || tag.contains('calm')) {
        return Icons.spa;
      } else if (tag.contains('sleep')) {
        return Icons.nightlight_round;
      } else if (tag.contains('focus')) {
        return Icons.center_focus_strong;
      } else if (tag.contains('energy')) {
        return Icons.bolt;
      }
    }
    
    // Default icon
    return Icons.self_improvement;
  }

  /// Returns a color based on the exercise tag
  Color _getColorForTag({int index = 0}) {
    if (exercise.tags.isEmpty) {
      return AppColors.primary;
    }
    
    final tag = exercise.tags[index % exercise.tags.length].toLowerCase();
    
    if (tag.contains('stress') || tag.contains('calm')) {
      return AppColors.primary;
    } else if (tag.contains('sleep')) {
      return AppColors.tertiary;
    } else if (tag.contains('focus')) {
      return AppColors.secondary;
    } else if (tag.contains('energy')) {
      return AppColors.warning;
    } else if (tag.contains('craving')) {
      return AppColors.error;
    }
    
    // Use a color from a predefined list based on the index
    final colors = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.tertiary,
      AppColors.info,
      AppColors.success,
    ];
    
    return colors[index % colors.length];
  }

  /// Formats the duration in seconds to a readable string
  String _formatDuration(int seconds) {
    if (seconds < 60) {
      return '$seconds sec';
    } else {
      final minutes = seconds ~/ 60;
      final remainingSeconds = seconds % 60;
      if (remainingSeconds == 0) {
        return '$minutes min';
      } else {
        return '$minutes min $remainingSeconds sec';
      }
    }
  }
}