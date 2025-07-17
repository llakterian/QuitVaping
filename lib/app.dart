import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/onboarding/screens/welcome_screen.dart';
import 'features/tracker/screens/home_screen.dart';
import 'data/services/user_service.dart';
import 'shared/theme/app_theme.dart';

class QuitVapingApp extends StatelessWidget {
  const QuitVapingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuitVaping',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: _buildInitialScreen(context),
    );
  }

  Widget _buildInitialScreen(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    
    // Show loading indicator while checking user status
    if (userService.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    
    // If user is logged in and has completed onboarding, show home screen
    if (userService.isLoggedIn) {
      return const HomeScreen();
    }
    
    // Otherwise, show welcome/onboarding screen
    return const WelcomeScreen();
  }
}