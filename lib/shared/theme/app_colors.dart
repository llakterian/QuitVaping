import 'package:flutter/material.dart';

class AppColors {
  // Primary brand colors
  static const Color primary = Color(0xFF4CAF50); // Green for health and growth
  static const Color primaryLight = Color(0xFFA5D6A7);
  static const Color primaryDark = Color(0xFF2E7D32);
  
  // Secondary colors
  static const Color secondary = Color(0xFF2196F3); // Blue for calm and focus
  static const Color secondaryLight = Color(0xFF90CAF9);
  static const Color secondaryDark = Color(0xFF1565C0);
  
  // Accent colors
  static const Color accent = Color(0xFFFF9800); // Orange for motivation
  static const Color accentLight = Color(0xFFFFCC80);
  static const Color accentDark = Color(0xFFEF6C00);
  
  // Neutral colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);
  
  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFFFFFFFF);
  
  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  // Dark theme colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkCardBackground = Color(0xFF2C2C2C);
  static const Color darkTextPrimary = Color(0xFFF5F5F5);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  
  // Craving intensity colors
  static const Color cravingMild = Color(0xFF4CAF50); // Green
  static const Color cravingModerate = Color(0xFFFFC107); // Yellow
  static const Color cravingSevere = Color(0xFFF44336); // Red
  
  // Progress colors
  static const Color progressStart = Color(0xFFF44336); // Red
  static const Color progressMiddle = Color(0xFFFFC107); // Yellow
  static const Color progressEnd = Color(0xFF4CAF50); // Green
  
  // Breathing exercise colors
  static const Color breatheIn = Color(0xFF2196F3); // Blue
  static const Color breatheHold = Color(0xFF673AB7); // Purple
  static const Color breatheOut = Color(0xFF4CAF50); // Green
  
  // Get color for craving intensity
  static Color getCravingColor(int intensity) {
    if (intensity <= 3) {
      return cravingMild;
    } else if (intensity <= 7) {
      return cravingModerate;
    } else {
      return cravingSevere;
    }
  }
  
  // Get color for progress percentage
  static Color getProgressColor(double percentage) {
    if (percentage < 0.3) {
      return progressStart;
    } else if (percentage < 0.7) {
      return progressMiddle;
    } else {
      return progressEnd;
    }
  }
  
  // Get gradient for progress
  static LinearGradient progressGradient = const LinearGradient(
    colors: [progressStart, progressMiddle, progressEnd],
    stops: [0.0, 0.5, 1.0],
  );
}