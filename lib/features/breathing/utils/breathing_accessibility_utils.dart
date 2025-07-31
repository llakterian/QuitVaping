import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'package:quit_vaping/features/breathing/models/breathing_phase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../data/models/breathing_exercise_model.dart';
import '../models/breathing_phase.dart';
import '../widgets/breathing_animation_widget.dart';

/// Utility class for breathing exercise accessibility functions
class BreathingAccessibilityUtils {
  /// Accessibility preferences
  static bool _useHighContrastMode = false;
  static bool _useHapticFeedback = true;
  static double _contrastLevel = 1.0; // 1.0 is normal, higher values increase contrast
  static int _hapticIntensity = 1; // 0 = off, 1 = light, 2 = medium, 3 = heavy

  /// High contrast colors for breathing phases
  static final Map<BreathingPhase, Color> _highContrastColors = {
    BreathingPhase.inhale: Colors.blue.shade700,      // Darker blue for inhale
    BreathingPhase.inhaleHold: Colors.purple.shade700, // Darker purple for inhale hold
    BreathingPhase.exhale: Colors.red.shade700,       // Darker red for exhale
    BreathingPhase.exhaleHold: Colors.orange.shade700, // Darker orange for exhale hold
  };

  /// Toggle high contrast mode
  static void setHighContrastMode(bool enabled) {
    _useHighContrastMode = enabled;
  }

  /// Get high contrast mode status
  static bool isHighContrastModeEnabled() {
    return _useHighContrastMode;
  }

  /// Set contrast level (1.0 is normal, higher values increase contrast)
  static void setContrastLevel(double level) {
    _contrastLevel = level.clamp(1.0, 2.0);
  }

  /// Get current contrast level
  static double getContrastLevel() {
    return _contrastLevel;
  }

  /// Toggle haptic feedback
  static void setHapticFeedback(bool enabled) {
    _useHapticFeedback = enabled;
  }

  /// Get haptic feedback status
  static bool isHapticFeedbackEnabled() {
    return _useHapticFeedback;
  }

  /// Set haptic feedback intensity (0 = off, 1 = light, 2 = medium, 3 = heavy)
  static void setHapticIntensity(int intensity) {
    _hapticIntensity = intensity.clamp(0, 3);
    if (intensity == 0) {
      _useHapticFeedback = false;
    } else if (_hapticIntensity > 0) {
      _useHapticFeedback = true;
    }
  }

  /// Get haptic feedback intensity
  static int getHapticIntensity() {
    return _hapticIntensity;
  }

  /// Provide haptic feedback based on the current breathing phase
  static void provideHapticFeedback(BreathingPhase phase) {
    if (!_useHapticFeedback || _hapticIntensity == 0) return;

    switch (phase) {
      case BreathingPhase.inhale:
        // Light feedback for inhale
        if (_hapticIntensity >= 1) {
          HapticFeedback.lightImpact();
        }
        break;
      case BreathingPhase.inhaleHold:
      case BreathingPhase.exhaleHold:
        // Medium feedback for holds
        if (_hapticIntensity >= 2) {
          HapticFeedback.mediumImpact();
        }
        break;
      case BreathingPhase.exhale:
        // Heavy feedback for exhale
        if (_hapticIntensity >= 3) {
          HapticFeedback.heavyImpact();
        } else if (_hapticIntensity >= 1) {
          // Use light feedback for lower intensity settings
          HapticFeedback.lightImpact();
        }
        break;
    }
  }

  /// Get color for breathing phase based on accessibility settings
  static Color getAccessibleColorForPhase(BreathingPhase phase, Color defaultColor) {
    if (!_useHighContrastMode) {
      return defaultColor;
    }
    
    // Use high contrast colors
    final highContrastColor = _highContrastColors[phase] ?? defaultColor;
    
    // Apply contrast level adjustment if needed
    if (_contrastLevel > 1.0) {
      // Make colors darker to increase contrast
      final HSLColor hslColor = HSLColor.fromColor(highContrastColor);
      final adjustedLightness = (hslColor.lightness / _contrastLevel).clamp(0.0, 1.0);
      return hslColor.withLightness(adjustedLightness).toColor();
    }
    
    return highContrastColor;
  }

  /// Get text color with appropriate contrast for a background color
  static Color getAccessibleTextColor(Color backgroundColor) {
    // Calculate relative luminance using the formula from WCAG 2.0
    final double luminance = 0.2126 * backgroundColor.red / 255 + 
                            0.7152 * backgroundColor.green / 255 + 
                            0.0722 * backgroundColor.blue / 255;
    
    // Use white text on dark backgrounds, black text on light backgrounds
    // The threshold 0.5 is a simplified version of the WCAG contrast ratio calculation
    return luminance < 0.5 ? Colors.white : Colors.black;
  }

  /// Generates a semantic label for a breathing exercise
  static String getExerciseSemanticLabel(BreathingExerciseModel exercise) {
    final pattern = exercise.defaultPattern;
    final patternDescription = _getPatternDescription(pattern);
    
    return '${exercise.name} breathing exercise. ${exercise.description}. '
        'Recommended duration: ${_formatDuration(exercise.recommendedDuration)}. '
        'Breathing pattern: $patternDescription';
  }
  
  /// Generates a semantic label for a breathing pattern
  static String getPatternSemanticLabel(BreathingPattern pattern) {
    return _getPatternDescription(pattern);
  }
  
  /// Generates a semantic label for the current breathing phase
  static String getPhaseSemanticLabel(BreathingPhase phase, int secondsRemaining) {
    switch (phase) {
      case BreathingPhase.inhale:
        return 'Inhale for $secondsRemaining seconds';
      case BreathingPhase.inhaleHold:
        return 'Hold breath for $secondsRemaining seconds';
      case BreathingPhase.exhale:
        return 'Exhale for $secondsRemaining seconds';
      case BreathingPhase.exhaleHold:
        return 'Hold breath for $secondsRemaining seconds';
    }
  }
  
  /// Generates a semantic label for a breathing exercise card
  static String getExerciseCardSemanticLabel(BreathingExerciseModel exercise, bool isFavorite) {
    final favoriteStatus = isFavorite ? 'Favorite exercise.' : '';
    final tags = exercise.tags.isNotEmpty 
        ? 'Tags: ${exercise.tags.join(", ")}.' 
        : '';
    
    return '${exercise.name} breathing exercise. $favoriteStatus '
        '${exercise.description} '
        'Recommended duration: ${_formatDuration(exercise.recommendedDuration)}. '
        '$tags Double tap to view details or use the start button to begin.';
  }
  
  /// Generates a semantic label for the exercise player controls
  static String getPlayerControlsSemanticLabel(bool isPlaying) {
    return isPlaying 
        ? 'Exercise in progress. Use pause button to pause or stop button to end the exercise.'
        : 'Exercise paused. Use start button to begin or resume the exercise.';
  }
  
  /// Generates a semantic label for the progress indicator
  static String getProgressSemanticLabel(int elapsedSeconds, int totalSeconds) {
    final remainingSeconds = totalSeconds - elapsedSeconds;
    final percentComplete = (elapsedSeconds / totalSeconds * 100).round();
    
    return 'Exercise progress: $percentComplete percent complete. '
        'Elapsed time: ${_formatDuration(elapsedSeconds)}. '
        'Remaining time: ${_formatDuration(remainingSeconds)}.';
  }
  
  /// Generates a semantic label for a slider in the pattern customizer
  static String getSliderSemanticLabel(String phaseName, int value, int min, int max) {
    return '$phaseName duration: $value seconds. Adjustable from $min to $max seconds.';
  }
  
  /// Generates a semantic label for a preset pattern button
  static String getPresetPatternSemanticLabel(String name, BreathingPattern pattern, bool isSelected) {
    final selectedStatus = isSelected ? 'Selected.' : 'Not selected.';
    return '$name preset breathing pattern. ${_getPatternDescription(pattern)}. $selectedStatus';
  }

  /// Generates a semantic label for accessibility settings
  static String getAccessibilitySettingsSemanticLabel(bool highContrastEnabled, bool hapticEnabled) {
    final highContrastStatus = highContrastEnabled ? 'High contrast mode is enabled.' : 'High contrast mode is disabled.';
    final hapticStatus = hapticEnabled ? 'Haptic feedback is enabled.' : 'Haptic feedback is disabled.';
    
    return 'Breathing exercise accessibility settings. $highContrastStatus $hapticStatus';
  }
  
  /// Helper method to get a description of a breathing pattern
  static String _getPatternDescription(BreathingPattern pattern) {
    final parts = <String>[];
    
    parts.add('Inhale for ${pattern.inhaleSeconds} seconds');
    
    if (pattern.inhaleHoldSeconds > 0) {
      parts.add('hold for ${pattern.inhaleHoldSeconds} seconds');
    }
    
    parts.add('exhale for ${pattern.exhaleSeconds} seconds');
    
    if (pattern.exhaleHoldSeconds > 0) {
      parts.add('hold for ${pattern.exhaleHoldSeconds} seconds');
    }
    
    return parts.join(', ');
  }
  
  /// Helper method to format duration in seconds to a readable string
  static String _formatDuration(int seconds) {
    if (seconds < 60) {
      return '$seconds seconds';
    } else {
      final minutes = seconds ~/ 60;
      final remainingSeconds = seconds % 60;
      if (remainingSeconds == 0) {
        return '$minutes minutes';
      } else {
        return '$minutes minutes and $remainingSeconds seconds';
      }
    }
  }
}