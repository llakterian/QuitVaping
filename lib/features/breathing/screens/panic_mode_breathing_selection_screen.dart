import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/breathing_exercise_model.dart';
import '../../../data/services/breathing_exercise_service.dart';
import '../../../shared/theme/app_colors.dart';
import 'panic_mode_breathing_screen.dart';

/// A screen for selecting a breathing exercise in panic mode
class PanicModeBreathingSelectionScreen extends StatelessWidget {
  const PanicModeBreathingSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final breathingService = Provider.of<BreathingExerciseService>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Breathing Exercise'),
        backgroundColor: AppColors.primary,
      ),
      body: FutureBuilder<List<BreathingExerciseModel>>(
        future: breathingService.getExercises(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading exercises: ${snapshot.error}',
                style: TextStyle(color: AppColors.error),
              ),
            );
          }
          
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No breathing exercises available'),
            );
          }
          
          // Filter exercises for panic mode (shorter exercises first)
          final exercises = snapshot.data!;
          exercises.sort((a, b) => a.recommendedDuration.compareTo(b.recommendedDuration));
          
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Card(
                color: Color(0xFFF0F8FF), // Light blue background
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(
                        Icons.air,
                        color: AppColors.primary,
                        size: 48,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Breathing exercises can help reduce cravings and anxiety',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Choose a quick exercise below to help you through this moment',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              Text(
                'Recommended Exercises',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              
              ...exercises.map((exercise) {
                // For panic mode, use a shorter duration
                final panicModeDuration = exercise.recommendedDuration < 180 
                    ? exercise.recommendedDuration 
                    : 120; // Cap at 2 minutes for panic mode
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PanicModeBreathingScreen(durationSeconds: 300, durationSeconds: 300, 
                            exercise: exercise,
                            durationSeconds: panicModeDuration,
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(
                              Icons.air,
                              color: AppColors.primary,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  exercise.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  exercise.benefitsDescription,
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 14,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.timer,
                                      size: 16,
                                      color: AppColors.textSecondary,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${panicModeDuration ~/ 60}:${(panicModeDuration % 60).toString().padLeft(2, '0')}',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    ...exercise.tags.take(2).map((tag) {
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 4),
                                        child: Chip(
                                          label: Text(
                                            tag,
                                            style: const TextStyle(fontSize: 10),
                                          ),
                                          padding: EdgeInsets.zero,
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          visualDensity: VisualDensity.compact,
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
              
              const SizedBox(height: 16),
              
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context); // Return to panic mode screen
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Back to Distraction Techniques'),
              ),
            ],
          );
        },
      ),
    );
  }
}