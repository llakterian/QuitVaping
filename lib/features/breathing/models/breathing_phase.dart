/// Enum representing different phases of a breathing exercise
enum BreathingPhase {
  /// Inhale phase
  inhale,
  
  /// Hold after inhale phase
  inhaleHold,
  
  /// Exhale phase
  exhale,
  
  /// Hold after exhale phase
  exhaleHold,
}

/// Extension methods for BreathingPhase
extension BreathingPhaseExtension on BreathingPhase {
  /// Get a user-friendly name for the breathing phase
  String get displayName {
    switch (this) {
      case BreathingPhase.inhale:
        return 'Inhale';
      case BreathingPhase.inhaleHold:
        return 'Hold';
      case BreathingPhase.exhale:
        return 'Exhale';
      case BreathingPhase.exhaleHold:
        return 'Hold';
    }
  }
  
  /// Get a description of the breathing phase
  String get description {
    switch (this) {
      case BreathingPhase.inhale:
        return 'Breathe in slowly through your nose';
      case BreathingPhase.inhaleHold:
        return 'Hold your breath';
      case BreathingPhase.exhale:
        return 'Breathe out slowly through your mouth';
      case BreathingPhase.exhaleHold:
        return 'Hold your breath';
    }
  }
  
  /// Get the next phase in the breathing cycle
  BreathingPhase get nextPhase {
    switch (this) {
      case BreathingPhase.inhale:
        return BreathingPhase.inhaleHold;
      case BreathingPhase.inhaleHold:
        return BreathingPhase.exhale;
      case BreathingPhase.exhale:
        return BreathingPhase.exhaleHold;
      case BreathingPhase.exhaleHold:
        return BreathingPhase.inhale;
    }
  }
}