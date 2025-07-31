import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/services/breathing_exercise_service.dart';
import '../services/breathing_craving_integration_service.dart';
import '../widgets/breathing_craving_correlation_chart.dart';

/// Screen that displays analytics about the correlation between breathing exercises and cravings
class BreathingCravingAnalyticsScreen extends StatelessWidget {
  const BreathingCravingAnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final breathingService = Provider.of<BreathingExerciseService>(context);
    final integrationService = Provider.of<BreathingCravingIntegrationService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathing & Cravings'),
      ),
      body: BreathingCravingCorrelationChart(
        integrationService: integrationService,
        breathingService: breathingService,
      ),
    );
  }
}