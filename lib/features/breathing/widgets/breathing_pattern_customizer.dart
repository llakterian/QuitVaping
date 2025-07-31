import 'package:flutter/material.dart';
import '../../../data/models/breathing_exercise_model.dart';
import '../../../shared/theme/app_colors.dart';
import '../utils/breathing_accessibility_utils.dart';

/// A widget for customizing breathing patterns with sliders and preset options
class BreathingPatternCustomizer extends StatefulWidget {
  /// The initial breathing pattern to customize
  final BreathingPattern initialPattern;
  
  /// Callback when the pattern is changed
  final Function(BreathingPattern pattern) onPatternChanged;
  
  /// Whether to show preset patterns
  final bool showPresets;
  
  /// Whether to allow saving as favorite
  final bool allowSaveAsFavorite;
  
  /// Callback when save as favorite is pressed
  final Function(BreathingPattern pattern, String name)? onSaveAsFavorite;
  
  /// List of user's saved patterns (optional)
  final List<Map<String, dynamic>>? savedPatterns;

  const BreathingPatternCustomizer({
    Key? key,
    required this.initialPattern,
    required this.onPatternChanged,
    this.showPresets = true,
    this.allowSaveAsFavorite = false,
    this.onSaveAsFavorite,
    this.savedPatterns,
  }) : super(key: key);

  @override
  State<BreathingPatternCustomizer> createState() => _BreathingPatternCustomizerState();
}

class _BreathingPatternCustomizerState extends State<BreathingPatternCustomizer> {
  late BreathingPattern _currentPattern;
  final TextEditingController _patternNameController = TextEditingController();
  
  // Preset patterns
  final Map<String, BreathingPattern> _presetPatterns = {
    'Box Breathing': const BreathingPattern(
      inhaleSeconds: 4,
      inhaleHoldSeconds: 4,
      exhaleSeconds: 4,
      exhaleHoldSeconds: 4,
    ),
    '4-7-8 Technique': const BreathingPattern(
      inhaleSeconds: 4,
      inhaleHoldSeconds: 7,
      exhaleSeconds: 8,
      exhaleHoldSeconds: 0,
    ),
    'Relaxing Breath': const BreathingPattern(
      inhaleSeconds: 5,
      inhaleHoldSeconds: 2,
      exhaleSeconds: 6,
      exhaleHoldSeconds: 0,
    ),
    'Energizing Breath': const BreathingPattern(
      inhaleSeconds: 6,
      inhaleHoldSeconds: 0,
      exhaleSeconds: 2,
      exhaleHoldSeconds: 0,
    ),
    'Deep Calming': const BreathingPattern(
      inhaleSeconds: 4,
      inhaleHoldSeconds: 2,
      exhaleSeconds: 6,
      exhaleHoldSeconds: 2,
    ),
  };

  @override
  void initState() {
    super.initState();
    _currentPattern = widget.initialPattern;
  }

  @override
  void dispose() {
    _patternNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        const Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Text(
            'Customize Breathing Pattern',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
        // Inhale duration slider
        _buildSlider(
          label: 'Inhale',
          value: _currentPattern.inhaleSeconds,
          min: BreathingPattern.minDuration.toDouble(),
          max: BreathingPattern.maxDuration.toDouble(),
          onChanged: (value) {
            setState(() {
              _currentPattern = _currentPattern.copyWith(inhaleSeconds: value.round());
            });
            widget.onPatternChanged(_currentPattern);
          },
          color: AppColors.primary,
        ),
        
        // Inhale hold duration slider
        _buildSlider(
          label: 'Hold after inhale',
          value: _currentPattern.inhaleHoldSeconds,
          min: 0,
          max: BreathingPattern.maxDuration.toDouble(),
          onChanged: (value) {
            setState(() {
              _currentPattern = _currentPattern.copyWith(inhaleHoldSeconds: value.round());
            });
            widget.onPatternChanged(_currentPattern);
          },
          color: AppColors.secondary,
        ),
        
        // Exhale duration slider
        _buildSlider(
          label: 'Exhale',
          value: _currentPattern.exhaleSeconds,
          min: BreathingPattern.minDuration.toDouble(),
          max: BreathingPattern.maxDuration.toDouble(),
          onChanged: (value) {
            setState(() {
              _currentPattern = _currentPattern.copyWith(exhaleSeconds: value.round());
            });
            widget.onPatternChanged(_currentPattern);
          },
          color: AppColors.tertiary,
        ),
        
        // Exhale hold duration slider
        _buildSlider(
          label: 'Hold after exhale',
          value: _currentPattern.exhaleHoldSeconds,
          min: 0,
          max: BreathingPattern.maxDuration.toDouble(),
          onChanged: (value) {
            setState(() {
              _currentPattern = _currentPattern.copyWith(exhaleHoldSeconds: value.round());
            });
            widget.onPatternChanged(_currentPattern);
          },
          color: AppColors.info,
        ),
        
        // Pattern visualization
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: _buildPatternVisualization(),
        ),
        
        // Preset patterns
        if (widget.showPresets) ...[
          const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 12),
            child: Text(
              'Preset Patterns',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildPresetPatterns(),
        ],
        
        // User's saved patterns
        if (widget.savedPatterns != null && widget.savedPatterns!.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.only(top: 16, bottom: 12),
            child: Text(
              'Your Saved Patterns',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildSavedPatterns(),
        ],
        
        // Save as favorite button
        if (widget.allowSaveAsFavorite && widget.onSaveAsFavorite != null) ...[
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton.icon(
              onPressed: _showSavePatternDialog,
              icon: const Icon(Icons.favorite_border),
              label: const Text('Save as Favorite'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
        ],
      ],
    );
  }

  /// Builds a slider for adjusting a breathing phase duration
  Widget _buildSlider({
    required String label,
    required int value,
    required double min,
    required double max,
    required Function(double) onChanged,
    required Color color,
  }) {
    // Generate semantic label for screen readers
    final semanticLabel = BreathingAccessibilityUtils.getSliderSemanticLabel(
      label, value, min.toInt(), max.toInt()
    );
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Text(
                  '$value seconds',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: color,
              inactiveTrackColor: color.withOpacity(0.2),
              thumbColor: color,
              overlayColor: color.withOpacity(0.2),
            ),
            child: Semantics(
              label: semanticLabel,
              slider: true,
              child: Slider(
                value: value.toDouble(),
                min: min,
                max: max,
                divisions: (max - min).round(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a visual representation of the current breathing pattern
  Widget _buildPatternVisualization() {
    final totalDuration = _currentPattern.inhaleSeconds + 
                         _currentPattern.inhaleHoldSeconds + 
                         _currentPattern.exhaleSeconds + 
                         _currentPattern.exhaleHoldSeconds;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pattern Visualization',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.withOpacity(0.1),
          ),
          child: Row(
            children: [
              _buildPatternSegment('Inhale', _currentPattern.inhaleSeconds, totalDuration, AppColors.primary),
              if (_currentPattern.inhaleHoldSeconds > 0)
                _buildPatternSegment('Hold', _currentPattern.inhaleHoldSeconds, totalDuration, AppColors.secondary),
              _buildPatternSegment('Exhale', _currentPattern.exhaleSeconds, totalDuration, AppColors.tertiary),
              if (_currentPattern.exhaleHoldSeconds > 0)
                _buildPatternSegment('Hold', _currentPattern.exhaleHoldSeconds, totalDuration, AppColors.info),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Total cycle: $totalDuration seconds',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  /// Builds a segment of the pattern visualization
  Widget _buildPatternSegment(String label, int seconds, int totalDuration, Color color) {
    // Calculate the flex based on the proportion of time
    final flex = (seconds * 100 ~/ totalDuration).clamp(10, 100);
    
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            '$seconds',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the preset patterns section
  Widget _buildPresetPatterns() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _presetPatterns.entries.map((entry) {
        final isSelected = _currentPattern == entry.value;
        final semanticLabel = BreathingAccessibilityUtils.getPresetPatternSemanticLabel(
          entry.key, entry.value, isSelected
        );
        
        return Semantics(
          label: semanticLabel,
          button: true,
          selected: isSelected,
          child: InkWell(
            onTap: () {
              setState(() {
                _currentPattern = entry.value;
              });
              widget.onPatternChanged(_currentPattern);
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.textSecondary.withOpacity(0.3),
                ),
              ),
              child: Text(
                entry.key,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Builds the user's saved patterns section
  Widget _buildSavedPatterns() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: widget.savedPatterns!.map((patternData) {
        final pattern = BreathingPattern(
          inhaleSeconds: patternData['inhaleSeconds'] as int,
          inhaleHoldSeconds: patternData['inhaleHoldSeconds'] as int,
          exhaleSeconds: patternData['exhaleSeconds'] as int,
          exhaleHoldSeconds: patternData['exhaleHoldSeconds'] as int,
        );
        
        final name = patternData['name'] as String;
        final isSelected = _currentPattern == pattern;
        final patternDescription = BreathingAccessibilityUtils.getPatternSemanticLabel(pattern);
        final semanticLabel = 'Favorite pattern: $name. $patternDescription. ${isSelected ? 'Selected.' : 'Not selected.'}';
        
        return Semantics(
          label: semanticLabel,
          button: true,
          selected: isSelected,
          child: InkWell(
            onTap: () {
              setState(() {
                _currentPattern = pattern;
              });
              widget.onPatternChanged(_currentPattern);
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.tertiary : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.tertiary : AppColors.textSecondary.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.favorite, size: 16, color: Colors.red),
                  const SizedBox(width: 4),
                  Text(
                    name,
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Shows a dialog to save the current pattern as a favorite
  void _showSavePatternDialog() {
    _patternNameController.text = '';
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Save Breathing Pattern'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _patternNameController,
              decoration: const InputDecoration(
                labelText: 'Pattern Name',
                hintText: 'Enter a name for this pattern',
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            _buildPatternVisualization(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = _patternNameController.text.trim();
              if (name.isNotEmpty) {
                widget.onSaveAsFavorite?.call(_currentPattern, name);
                Navigator.of(context).pop();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}