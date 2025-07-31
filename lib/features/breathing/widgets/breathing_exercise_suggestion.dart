import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'package:flutter/material.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../data/models/breathing_exercise_model.dart';
import '../../../data/models/craving_model.dart';

/// Widget that shows a breathing exercise suggestion after logging a craving
class BreathingExerciseSuggestion extends StatelessWidget {
  final CravingModel craving;
  final BreathingExerciseModel exercise;
  final VoidCallback onStartExercise;
  final VoidCallback onDismiss;
  
  const BreathingExerciseSuggestion({
    Key? key,
    required this.craving,
    required this.exercise,
    required this.onStartExercise,
    required this.onDismiss,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.spa,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'Breathing Exercise Suggestion',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onDismiss,
                  tooltip: 'Dismiss',
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              _getSuggestionText(craving),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.air,
                    size: 32,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        exercise.benefitsDescription,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Duration: ${exercise.recommendedDuration ~/ 60} minutes',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onDismiss,
                  child: const Text('Maybe Later'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: onStartExercise,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Start Now'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  String _getSuggestionText(CravingModel craving) {
    if (craving.intensity >= 7) {
      return 'This breathing exercise can help reduce your strong craving right now:';
    } else if (craving.intensity >= 4) {
      return 'Try this breathing exercise to help manage your craving:';
    } else {
      return 'This breathing exercise can help reinforce your progress:';
    }
  }
}