class BreathingExercise {
  final String name;
  final String description;
  final List<BreathingStep> steps;
  final int defaultDuration;
  final bool isPremium;

  const BreathingExercise({
    required this.name,
    required this.description,
    required this.steps,
    required this.defaultDuration,
    this.isPremium = false,
  });
}

class BreathingStep {
  final String instruction;
  final int durationSeconds;
  final StepType type;

  const BreathingStep({
    required this.instruction,
    required this.durationSeconds,
    required this.type,
  });
}

enum StepType {
  inhale,
  hold,
  exhale,
  rest
}
