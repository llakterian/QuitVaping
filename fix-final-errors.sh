#!/bin/bash

echo "Fixing final Flutter errors..."

# Fix AI service errors
echo "Fixing AI service errors..."
sed -i '370s/firstHalf.last.timestamp.difference(firstHalf.first.timestamp).inDays + 1/firstHalf.isNotEmpty \&\& firstHalf.length > 1 ? firstHalf.last.timestamp.difference(firstHalf.first.timestamp).inDays + 1 : 1/g' lib/data/services/ai_service.dart
sed -i '371s/secondHalf.last.timestamp.difference(secondHalf.first.timestamp).inDays + 1/secondHalf.isNotEmpty \&\& secondHalf.length > 1 ? secondHalf.last.timestamp.difference(secondHalf.first.timestamp).inDays + 1 : 1/g' lib/data/services/ai_service.dart

# Fix CardTheme errors
echo "Fixing CardTheme errors..."
sed -i 's/cardTheme: CardTheme(/cardTheme: ThemeData.light().cardTheme.copyWith(/g' lib/shared/theme/app_theme.dart
sed -i 's/cardTheme: CardTheme(/cardTheme: ThemeData.dark().cardTheme.copyWith(/g' lib/shared/theme/app_theme.dart

# Fix craving analytics errors
echo "Fixing craving analytics errors..."
sed -i '397s/entry.value.toDouble()/entry.value?.toDouble() ?? 0.0/g' lib/features/checkins/widgets/craving_analytics.dart
sed -i '397s/entry.value \* 1.2/(entry.value ?? 0) * 1.2/g' lib/features/checkins/widgets/craving_analytics.dart

# Fix NRT analytics tab errors
echo "Fixing NRT analytics tab errors..."
sed -i '403s/entry.value.toDouble()/entry.value?.toDouble() ?? 0.0/g' lib/features/nrt_tracker/widgets/nrt_analytics_tab.dart
sed -i '403s/entry.value \* 1.2/(entry.value ?? 0) * 1.2/g' lib/features/nrt_tracker/widgets/nrt_analytics_tab.dart

# Fix panic mode screen
echo "Fixing panic mode screen..."
sed -i 's/_currentSteps/_getSteps/g' lib/features/panic_mode/screens/panic_mode_screen.dart

echo "Fixes applied! Run 'flutter analyze --no-fatal-infos --no-fatal-warnings' to check for remaining errors."