import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/services/breathing_exercise_service.dart';
import 'data/services/breathing_preset_service.dart';

/// Provides all the providers for the app
class AppProviders extends StatelessWidget {
  /// The child widget
  final Widget child;
  
  /// Creates a new app providers widget
  const AppProviders({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        final sharedPreferences = snapshot.data!;

        return MultiProvider(
          providers: [
            Provider<SharedPreferences>.value(
              value: sharedPreferences,
            ),
            Provider<BreathingExerciseService>(
              create: (_) => BreathingExerciseService(sharedPreferences),
            ),
            ChangeNotifierProvider<BreathingPresetService>(
              create: (_) => BreathingPresetService(sharedPreferences),
            ),
          ],
          child: child,
        );
      },
    );
  }
}
