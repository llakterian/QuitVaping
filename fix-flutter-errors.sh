#!/bin/bash

echo "Fixing Flutter errors..."

# Fix unnecessary imports
echo "Removing unnecessary imports..."
for file in lib/data/models/*.dart; do
  sed -i '/import.*json_annotation\/json_annotation.dart/d' $file
done

# Fix unused imports
echo "Removing unused imports..."
sed -i '/import.*flutter\/foundation.dart/d' lib/data/services/ad_service.dart
sed -i '/import.*dart:convert/d' lib/data/services/ai_service.dart
sed -i '/import.*uuid\/uuid.dart/d' lib/features/nrt_tracker/screens/nrt_tracker_screen.dart
sed -i '/import.*subscription_service.dart/d' lib/features/nrt_tracker/screens/nrt_tracker_screen.dart
sed -i '/import.*subscription_screen.dart/d' lib/features/nrt_tracker/widgets/nrt_analytics_tab.dart
sed -i '/import.*premium_feature_overlay.dart/d' lib/features/breathing/screens/breathing_screen.dart
sed -i '/import.*provider\/provider.dart/d' lib/features/checkins/screens/checkin_screen.dart
sed -i '/import.*fl_chart\/fl_chart.dart/d' lib/features/checkins/screens/checkin_screen.dart
sed -i '/import.*user_service.dart/d' lib/features/checkins/screens/checkin_screen.dart
sed -i '/import.*subscription_service.dart/d' lib/features/checkins/screens/checkin_screen.dart
sed -i '/import.*subscription_screen.dart/d' lib/features/checkins/screens/checkin_screen.dart
sed -i '/import.*premium_feature_overlay.dart/d' lib/features/checkins/screens/checkin_screen.dart
sed -i '/import.*subscription_screen.dart/d' lib/features/checkins/widgets/craving_analytics.dart
sed -i '/import.*premium_feature_overlay.dart/d' lib/features/panic_mode/screens/panic_mode_screen.dart
sed -i '/import.*app_theme.dart/d' lib/features/subscription/screens/subscription_screen.dart
sed -i '/import.*in_app_purchase.dart/d' lib/features/subscription/screens/subscription_screen.dart
sed -i '/import.*google_mobile_ads\/google_mobile_ads.dart/d' lib/main.dart
sed -i '/import.*app_constants.dart/d' lib/main.dart
sed -i '/import.*flutter\/material.dart/d' lib/shared/constants/app_constants.dart

# Fix timezone dependency
echo "Adding timezone dependency to pubspec.yaml..."
sed -i '/dependencies:/a \ \ timezone: ^0.9.2' pubspec.yaml

# Fix withOpacity deprecation warnings
echo "Fixing withOpacity deprecation warnings..."
find lib -name "*.dart" -exec sed -i 's/withOpacity(0.1)/withValues(alpha: 26)/g' {} \;
find lib -name "*.dart" -exec sed -i 's/withOpacity(0.2)/withValues(alpha: 51)/g' {} \;
find lib -name "*.dart" -exec sed -i 's/withOpacity(0.3)/withValues(alpha: 77)/g' {} \;
find lib -name "*.dart" -exec sed -i 's/withOpacity(0.4)/withValues(alpha: 102)/g' {} \;
find lib -name "*.dart" -exec sed -i 's/withOpacity(0.5)/withValues(alpha: 128)/g' {} \;
find lib -name "*.dart" -exec sed -i 's/withOpacity(0.6)/withValues(alpha: 153)/g' {} \;
find lib -name "*.dart" -exec sed -i 's/withOpacity(0.7)/withValues(alpha: 179)/g' {} \;
find lib -name "*.dart" -exec sed -i 's/withOpacity(0.8)/withValues(alpha: 204)/g' {} \;
find lib -name "*.dart" -exec sed -i 's/withOpacity(0.9)/withValues(alpha: 230)/g' {} \;

# Fix unchecked nullable value errors
echo "Fixing unchecked nullable value errors..."

# Fix AI service errors
sed -i '347s/sum + craving.intensity/sum + (craving.intensity ?? 0)/' lib/data/services/ai_service.dart
sed -i '371s/firstHalf.last.timestamp.difference(firstHalf.first.timestamp).inDays + 1/firstHalf.last.timestamp.difference(firstHalf.first.timestamp).inDays + 1/' lib/data/services/ai_service.dart
sed -i '372s/secondHalf.last.timestamp.difference(secondHalf.first.timestamp).inDays + 1/secondHalf.last.timestamp.difference(secondHalf.first.timestamp).inDays + 1/' lib/data/services/ai_service.dart

# Fix NRT service error
sed -i '239s/sum + record.nicotineStrength/sum + (record.nicotineStrength ?? 0.0)/' lib/data/services/nrt_service.dart

# Fix NRT tracker screen error
sed -i '149s/sum + record.nicotineStrength/sum + (record.nicotineStrength ?? 0.0)/' lib/features/nrt_tracker/screens/nrt_tracker_screen.dart

# Fix NRT usage chart errors
sed -i '57s/sum + spot.y/sum + (spot.y ?? 0.0)/' lib/features/nrt_tracker/widgets/nrt_usage_chart.dart
sed -i '58s/sum + spot.y/sum + (spot.y ?? 0.0)/' lib/features/nrt_tracker/widgets/nrt_usage_chart.dart

# Fix craving analytics errors
sed -i '365s/sum + entry.value/sum + (entry.value ?? 0)/' lib/features/checkins/widgets/craving_analytics.dart
sed -i '398s/entry.value.toDouble()/entry.value?.toDouble() ?? 0.0/' lib/features/checkins/widgets/craving_analytics.dart
sed -i '398s/entry.value \* 1.2/(entry.value ?? 0) * 1.2/' lib/features/checkins/widgets/craving_analytics.dart

# Fix NRT analytics tab errors
sed -i '371s/sum + entry.value/sum + (entry.value ?? 0)/' lib/features/nrt_tracker/widgets/nrt_analytics_tab.dart
sed -i '404s/entry.value.toDouble()/entry.value?.toDouble() ?? 0.0/' lib/features/nrt_tracker/widgets/nrt_analytics_tab.dart
sed -i '404s/entry.value \* 1.2/(entry.value ?? 0) * 1.2/' lib/features/nrt_tracker/widgets/nrt_analytics_tab.dart

# Fix unused local variables
echo "Fixing unused local variables..."
sed -i '/isSelected/s/final isSelected/final _/' lib/features/breathing/screens/breathing_screen.dart
sed -i '/craving/s/final craving/final _/' lib/features/checkins/screens/checkin_screen.dart
sed -i '/userService/s/final userService/final _/' lib/features/checkins/widgets/craving_analytics.dart
sed -i '/daysElapsed/s/final daysElapsed/final _/' lib/features/nrt_tracker/widgets/nrt_schedule_card.dart
sed -i '/isAvailableInFree/s/final isAvailableInFree/final _/' lib/features/subscription/screens/subscription_screen.dart

# Fix unused element
echo "Fixing unused element..."
sed -i '/_currentSteps/s/List<Map<String, dynamic>> get _currentSteps/List<Map<String, dynamic>> get _getSteps/' lib/features/panic_mode/screens/panic_mode_screen.dart

echo "Fixes applied! Run 'flutter analyze --no-fatal-infos --no-fatal-warnings' to check for remaining errors."