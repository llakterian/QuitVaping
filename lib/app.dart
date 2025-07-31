import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quit_vaping/data/models/breathing_exercise_model.dart';
import 'package:quit_vaping/features/breathing/models/breathing_phase.dart';
import 'package:quit_vaping/features/breathing/screens/breathing_exercise_screen.dart';
import 'package:quit_vaping/features/breathing/screens/panic_mode_breathing_screen.dart';
import 'package:quit_vaping/shared/theme/app_theme.dart';

/// Main app widget
class QuitVapingApp extends StatefulWidget {
  /// Creates a new QuitVaping app
  const QuitVapingApp({super.key});

  @override
  State<QuitVapingApp> createState() => _QuitVapingAppState();
}

class _QuitVapingAppState extends State<QuitVapingApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuitVaping',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      onGenerateRoute: _generateRoute,
    );
  }

  Route<dynamic> _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Home Screen'),
            ),
          ),
        );
      case '/breathing-exercise':
        final args = settings.arguments as Map<String, dynamic>;
        final exercise = args['exercise'] as BreathingExerciseModel;
        final customPattern = args['customPattern'] as BreathingPattern?;
        
        return MaterialPageRoute(
          builder: (context) => BreathingExerciseScreen(
            exercise: exercise,
            customPattern: customPattern,
          ),
        );
      case '/panic-mode':
        final args = settings.arguments as Map<String, dynamic>;
        
        return MaterialPageRoute(
          builder: (context) => PanicModeBreathingScreen(
            exercise: args['exercise'] as BreathingExerciseModel,
            durationSeconds: 300,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('Route not found: ${settings.name}'),
            ),
          ),
        );
    }
  }
}
