import 'package:flutter/material.dart';

class AppColors {
  // X (Twitter) Style Primary Colors - Excellent contrast and readability
  static const Color primary = Color(0xFF1DA1F2); // X Blue - Trust, communication
  static const Color primaryLight = Color(0xFF71C9F8); // Light X Blue - Accessibility
  static const Color primaryDark = Color(0xFF0D8BD9); // Dark X Blue - Depth
  
  // Secondary colors - Clean and modern
  static const Color secondary = Color(0xFF14171A); // X Dark - Professional
  static const Color secondaryLight = Color(0xFF657786); // X Grey - Subtle
  static const Color secondaryDark = Color(0xFF000000); // Pure Black - Maximum contrast
  
  // Accent colors - Health and motivation focused
  static const Color accent = Color(0xFF17BF63); // X Green - Success, health
  static const Color accentLight = Color(0xFF5ED47A); // Light Green - Hope
  static const Color accentDark = Color(0xFF0F9549); // Dark Green - Achievement
  
  // Light Theme Colors - Enhanced readability with subtle backgrounds
  static const Color background = Color(0xFFFAFBFC); // Very light grey - Reduces eye strain
  static const Color surface = Color(0xFFFFFFFF); // Pure White - Clean cards
  static const Color cardBackground = Color(0xFFFFFFFF); // White cards - Clean separation
  
  // Text colors - Enhanced contrast for perfect readability
  static const Color textPrimary = Color(0xFF0F1419); // Darker than X - Maximum readability
  static const Color textSecondary = Color(0xFF536471); // Improved contrast - 8:1 ratio
  static const Color textLight = Color(0xFFFFFFFF); // Pure white for dark backgrounds
  static const Color textHint = Color(0xFF8B98A5); // Better contrast - Subtle hints
  
  // Status colors - X Style with excellent visibility
  static const Color success = Color(0xFF17BF63); // X Green - Achievement
  static const Color warning = Color(0xFFFFAD1F); // X Orange - Attention
  static const Color error = Color(0xFFE0245E); // X Red - Alert
  static const Color info = Color(0xFF1DA1F2); // X Blue - Information
  
  // Dark Theme Colors - X Dark Mode Style
  static const Color darkBackground = Color(0xFF000000); // Pure Black - X Dark Mode
  static const Color darkSurface = Color(0xFF16181C); // X Dark Surface - Depth
  static const Color darkCardBackground = Color(0xFF1C1F23); // X Card Dark - Separation
  static const Color darkTextPrimary = Color(0xFFFFFFFF); // Pure White - Maximum contrast
  static const Color darkTextSecondary = Color(0xFF8B98A5); // X Dark Grey - Readable
  
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
  
  // Health milestone colors (progressive achievement)
  static const Color milestone1 = Color(0xFFE8F5E8); // Very light green - First steps
  static const Color milestone2 = Color(0xFFC8E6C9); // Light green - Progress
  static const Color milestone3 = Color(0xFF81C784); // Medium green - Significant progress
  static const Color milestone4 = Color(0xFF4CAF50); // Full green - Major achievement
  
  // Emotional support colors (psychology-based)
  static const Color calm = Color(0xFF81D4FA); // Light Blue 300 - Serenity, peace
  static const Color motivation = Color(0xFFFFB74D); // Orange 300 - Energy, drive
  static const Color achievement = Color(0xFFAED581); // Light Green 300 - Success, growth
  static const Color support = Color(0xFFCE93D8); // Purple 300 - Care, empathy
  
  // Get gradient for progress (motivational colors)
  static LinearGradient progressGradient = const LinearGradient(
    colors: [Color(0xFFE65100), Color(0xFFFF9800), Color(0xFF2E7D32)], // Orange to Green
    stops: [0.0, 0.5, 1.0],
  );
  
  // Get gradient for health recovery
  static LinearGradient healthGradient = const LinearGradient(
    colors: [Color(0xFF00695C), Color(0xFF4DB6AC)], // Teal gradient
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Get color with proper contrast for accessibility
  static Color getContrastColor(Color backgroundColor) {
    // Calculate luminance and return appropriate text color
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? textPrimary : textLight;
  }
}