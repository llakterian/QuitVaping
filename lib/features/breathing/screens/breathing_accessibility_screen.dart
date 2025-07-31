import 'package:flutter/material.dart';
import '../widgets/breathing_accessibility_settings.dart';
import '../widgets/breathing_animation_widget.dart';
import '../../../data/models/breathing_exercise_model.dart';

/// A screen that allows users to configure accessibility settings for breathing exercises
class BreathingAccessibilityScreen extends StatefulWidget {
  const BreathingAccessibilityScreen({Key? key}) : super(key: key);

  @override
  State<BreathingAccessibilityScreen> createState() => _BreathingAccessibilityScreenState();
}

class _BreathingAccessibilityScreenState extends State<BreathingAccessibilityScreen> {
  // Sample breathing pattern for preview
  final BreathingPattern _samplePattern = BreathingPattern(
    inhaleSeconds: 4,
    inhaleHoldSeconds: 2,
    exhaleSeconds: 6,
    exhaleHoldSeconds: 0,
  );

  bool _isAnimationPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accessibility Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Explanation text
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Customize how breathing exercises look and feel to make them more accessible.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            
            // Settings
            const BreathingAccessibilitySettings(),
            
            const Divider(),
            
            // Preview section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Preview',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'See how your settings affect the breathing exercise experience.',
                  ),
                  const SizedBox(height: 16),
                  
                  // Animation preview
                  Center(
                    child: Column(
                      children: [
                        BreathingAnimationWidget(
                          pattern: _samplePattern,
                          isPlaying: _isAnimationPlaying,
                          size: 150,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _isAnimationPlaying = !_isAnimationPlaying;
                            });
                          },
                          icon: Icon(_isAnimationPlaying ? Icons.pause : Icons.play_arrow),
                          label: Text(_isAnimationPlaying ? 'Pause' : 'Play Preview'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const Divider(),
            
            // Tips section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Accessibility Tips',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildTipCard(
                    'High Contrast Mode',
                    'Enhances color differences to make breathing phases more distinct.',
                    Icons.contrast,
                  ),
                  _buildTipCard(
                    'Haptic Feedback',
                    'Provides vibration cues to help you follow the breathing pattern without looking at the screen.',
                    Icons.vibration,
                  ),
                  _buildTipCard(
                    'Screen Reader Support',
                    'All breathing exercises are fully compatible with screen readers.',
                    Icons.record_voice_over,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard(String title, String description, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}