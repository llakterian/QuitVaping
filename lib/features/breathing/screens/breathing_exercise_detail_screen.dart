import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/breathing_exercise_model.dart';
import '../../../data/services/breathing_exercise_service.dart';
import '../../../shared/theme/app_colors.dart';
import '../widgets/breathing_animation_widget.dart';
import '../widgets/breathing_pattern_customizer.dart';

/// Screen showing exercise details and customization options
class BreathingExerciseDetailScreen extends StatefulWidget {
  /// The breathing exercise to display
  final BreathingExerciseModel exercise;

  const BreathingExerciseDetailScreen({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  @override
  State<BreathingExerciseDetailScreen> createState() => _BreathingExerciseDetailScreenState();
}

class _BreathingExerciseDetailScreenState extends State<BreathingExerciseDetailScreen> {
  late BreathingPattern _currentPattern;
  late int _selectedDuration;
  bool _isPreviewPlaying = false;
  List<Map<String, dynamic>> _savedPatterns = [];
  
  // Available exercise durations in seconds
  final List<int> _availableDurations = [60, 120, 180, 300, 600, 900];

  @override
  void initState() {
    super.initState();
    _currentPattern = widget.exercise.defaultPattern;
    _selectedDuration = widget.exercise.recommendedDuration;
    _loadUserPreferences();
  }
  
  /// Loads user preferences for this exercise
  Future<void> _loadUserPreferences() async {
    final breathingService = Provider.of<BreathingExerciseService>(context, listen: false);
    
    // Load preferred pattern if available
    final preferredPattern = await breathingService.getPreferredPattern(widget.exercise.id);
    if (preferredPattern != null) {
      setState(() {
        _currentPattern = preferredPattern;
      });
    }
    
    // Load preferred duration if available
    final preferredDuration = await breathingService.getPreferredDuration(widget.exercise.id);
    if (preferredDuration != null) {
      setState(() {
        _selectedDuration = preferredDuration;
      });
    }
    
    // In a real app, load saved patterns from preferences or database
    // For now, we'll just use a placeholder
    setState(() {
      _savedPatterns = [
        {
          'name': 'My Favorite',
          'inhaleSeconds': 4,
          'inhaleHoldSeconds': 2,
          'exhaleSeconds': 6,
          'exhaleHoldSeconds': 0,
        }
      ];
    });
  }
  
  /// Saves the current pattern and duration as preferences
  Future<void> _savePreferences() async {
    final breathingService = Provider.of<BreathingExerciseService>(context, listen: false);
    await breathingService.saveExercisePreferences(
      widget.exercise.id,
      _currentPattern,
      _selectedDuration,
    );
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Preferences saved')),
    );
  }
  
  /// Saves a pattern as a favorite
  void _savePatternAsFavorite(BreathingPattern pattern, String name) {
    // In a real app, save to preferences or database
    setState(() {
      _savedPatterns.add({
        'name': name,
        'inhaleSeconds': pattern.inhaleSeconds,
        'inhaleHoldSeconds': pattern.inhaleHoldSeconds,
        'exhaleSeconds': pattern.exhaleSeconds,
        'exhaleHoldSeconds': pattern.exhaleHoldSeconds,
      });
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pattern "$name" saved')),
    );
  }
  
  /// Starts the breathing exercise with current settings
  void _startExercise() {
    // Stop the preview if it's playing
    setState(() {
      _isPreviewPlaying = false;
    });
    
    // Save preferences
    _savePreferences();
    
    // Navigate to the exercise screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Placeholder(
          child: Center(
            child: Text('Exercise screen for ${widget.exercise.name}'),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise.name),
        actions: [
          // Save preferences button
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _savePreferences,
            tooltip: 'Save preferences',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exercise header with animation preview
            _buildExerciseHeader(),
            
            // Exercise details
            _buildExerciseDetails(),
            
            // Duration selection
            _buildDurationSelection(),
            
            // Pattern customization
            Padding(
              padding: const EdgeInsets.all(16),
              child: BreathingPatternCustomizer(
                initialPattern: _currentPattern,
                onPatternChanged: (pattern) {
                  setState(() {
                    _currentPattern = pattern;
                  });
                },
                showPresets: true,
                allowSaveAsFavorite: true,
                onSaveAsFavorite: _savePatternAsFavorite,
                savedPatterns: _savedPatterns,
              ),
            ),
            
            // Start button
            Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: _startExercise,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Start Exercise'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  /// Builds the exercise header with animation preview
  Widget _buildExerciseHeader() {
    return Container(
      color: AppColors.primary.withOpacity(0.1),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Animation preview
          Stack(
            alignment: Alignment.center,
            children: [
              BreathingAnimationWidget(
                pattern: _currentPattern,
                size: 200,
                isPlaying: _isPreviewPlaying,
              ),
              if (!_isPreviewPlaying)
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.play_arrow, size: 36),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        _isPreviewPlaying = true;
                      });
                    },
                  ),
                ),
            ],
          ),
          
          // Preview controls
          if (_isPreviewPlaying)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _isPreviewPlaying = false;
                  });
                },
                icon: const Icon(Icons.stop),
                label: const Text('Stop Preview'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
  
  /// Builds the exercise details section
  Widget _buildExerciseDetails() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.exercise.description,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Benefits
          const Text(
            'Benefits',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.exercise.benefitsDescription,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Tags
          if (widget.exercise.tags.isNotEmpty) ...[
            const Text(
              'Tags',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.exercise.tags.map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getColorForTag(tag).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _getColorForTag(tag).withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      color: _getColorForTag(tag),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
  
  /// Builds the duration selection section
  Widget _buildDurationSelection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Exercise Duration',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _availableDurations.map((duration) {
              final isSelected = duration == _selectedDuration;
              
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedDuration = duration;
                  });
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.textSecondary.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    _formatDuration(duration),
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
  
  /// Returns a color based on the tag
  Color _getColorForTag(String tag) {
    final tagLower = tag.toLowerCase();
    
    if (tagLower.contains('stress') || tagLower.contains('calm')) {
      return AppColors.primary;
    } else if (tagLower.contains('sleep')) {
      return AppColors.tertiary;
    } else if (tagLower.contains('focus')) {
      return AppColors.secondary;
    } else if (tagLower.contains('energy')) {
      return AppColors.warning;
    } else if (tagLower.contains('craving')) {
      return AppColors.error;
    }
    
    return AppColors.info;
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