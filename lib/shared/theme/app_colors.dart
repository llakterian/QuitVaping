import 'package:flutter/material.dart';

/// App color palette
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary colors
  static const Color primary = Color(0xFF4CAF50);
  static const Color primaryLight = Color(0xFF80E27E);
  static const Color primaryDark = Color(0xFF087F23);
  
  // Secondary colors
  static const Color secondary = Color(0xFF42A5F5);
  static const Color secondaryLight = Color(0xFF80D6FF);
  static const Color secondaryDark = Color(0xFF0077C2);
  
  // Tertiary colors
  static const Color tertiary = Color(0xFFFFA726);
  static const Color tertiaryLight = Color(0xFFFFD95B);
  static const Color tertiaryDark = Color(0xFFC77800);
  
  // Accent color
  static const Color accent = Color(0xFFFFA726);
  
  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textTertiary = Color(0xFF9E9E9E);
  static const Color textLight = Color(0xFFFFFFFF);
  
  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFB74D);
  static const Color info = Color(0xFF29B6F6);
  
  // Background colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFBDBDBD);
  
  // Get color for craving intensity (1-5)
  static Color getCravingColor(int intensity) {
    switch (intensity) {
      case 1:
        return const Color(0xFF81C784); // Light green
      case 2:
        return const Color(0xFFFFB74D); // Orange
      case 3:
        return const Color(0xFFFFA726); // Dark orange
      case 4:
        return const Color(0xFFF57C00); // Deep orange
      case 5:
        return const Color(0xFFE53935); // Red
      default:
        return const Color(0xFF81C784); // Default to light green
    }
  }
  
  // Get color for progress based on percentage
  static Color getProgressColor(double percentage) {
    if (percentage < 0.3) {
      return error;
    } else if (percentage < 0.7) {
      return warning;
    } else {
      return success;
    }
  }
  
  // Progress gradient
  static const List<Color> progressGradient = [
    Color(0xFF4CAF50),  // Green
    Color(0xFF8BC34A),  // Light Green
    Color(0xFFCDDC39),  // Lime
    Color(0xFFFFEB3B),  // Yellow
    Color(0xFFFFC107),  // Amber
    Color(0xFFFF9800),  // Orange
  ];
}