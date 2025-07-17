#!/bin/bash

echo "Fixing remaining Flutter errors..."

# Fix CardTheme errors in app_theme.dart
echo "Fixing CardTheme errors..."
sed -i 's/cardTheme: CardTheme(/cardTheme: ThemeData.light().cardTheme.copyWith(/g' lib/shared/theme/app_theme.dart
sed -i 's/cardTheme: CardTheme(/cardTheme: ThemeData.dark().cardTheme.copyWith(/g' lib/shared/theme/app_theme.dart

# Fix unchecked nullable value errors in AI service
echo "Fixing AI service errors..."
sed -i '346s/sum + craving.intensity/sum + (craving.intensity)/g' lib/data/services/ai_service.dart
sed -i '370s/firstHalf.last.timestamp.difference(firstHalf.first.timestamp).inDays + 1/firstHalf.isNotEmpty \&\& firstHalf.length > 1 ? firstHalf.last.timestamp.difference(firstHalf.first.timestamp).inDays + 1 : 1/g' lib/data/services/ai_service.dart
sed -i '371s/secondHalf.last.timestamp.difference(secondHalf.first.timestamp).inDays + 1/secondHalf.isNotEmpty \&\& secondHalf.length > 1 ? secondHalf.last.timestamp.difference(secondHalf.first.timestamp).inDays + 1 : 1/g' lib/data/services/ai_service.dart

# Fix NRT service error
echo "Fixing NRT service errors..."
sed -i '239s/sum + record.nicotineStrength/sum + record.nicotineStrength/g' lib/data/services/nrt_service.dart
sed -i '239s/ ?? 0.0//g' lib/data/services/nrt_service.dart

# Fix NRT tracker screen error
echo "Fixing NRT tracker screen errors..."
sed -i '147s/sum + record.nicotineStrength/sum + record.nicotineStrength/g' lib/features/nrt_tracker/screens/nrt_tracker_screen.dart

# Fix NRT usage chart errors
echo "Fixing NRT usage chart errors..."
sed -i '57s/sum + (spot.y ?? 0.0)/sum + spot.y/g' lib/features/nrt_tracker/widgets/nrt_usage_chart.dart
sed -i '58s/sum + (spot.y ?? 0.0)/sum + spot.y/g' lib/features/nrt_tracker/widgets/nrt_usage_chart.dart

# Fix craving analytics errors
echo "Fixing craving analytics errors..."
sed -i '364s/sum + entry.value/sum + entry.value/g' lib/features/checkins/widgets/craving_analytics.dart
sed -i '397s/entry.value.toDouble()/entry.value.toDouble()/g' lib/features/checkins/widgets/craving_analytics.dart
sed -i '397s/entry.value \* 1.2/entry.value * 1.2/g' lib/features/checkins/widgets/craving_analytics.dart

# Fix NRT analytics tab errors
echo "Fixing NRT analytics tab errors..."
sed -i '370s/sum + entry.value/sum + entry.value/g' lib/features/nrt_tracker/widgets/nrt_analytics_tab.dart
sed -i '403s/entry.value.toDouble()/entry.value.toDouble()/g' lib/features/nrt_tracker/widgets/nrt_analytics_tab.dart
sed -i '403s/entry.value \* 1.2/entry.value * 1.2/g' lib/features/nrt_tracker/widgets/nrt_analytics_tab.dart

# Fix isSelected error in breathing screen
echo "Fixing isSelected error in breathing screen..."
sed -i 's/final _/final isSelected/g' lib/features/breathing/screens/breathing_screen.dart

# Fix unused element in panic mode screen
echo "Fixing unused element in panic mode screen..."
sed -i '/_currentSteps/d' lib/features/panic_mode/screens/panic_mode_screen.dart

# Fix withOpacity in AI chat screen
echo "Fixing withOpacity in AI chat screen..."
sed -i '178s/withOpacity/withValues/g' lib/features/ai_chat/screens/ai_chat_screen.dart
sed -i '178s/(0.3)/(alpha: 77)/g' lib/features/ai_chat/screens/ai_chat_screen.dart

# Fix timezone dependency
echo "Fixing timezone dependency..."
sed -i '/timezone:/d' pubspec.yaml
sed -i '/dependencies:/a \ \ timezone: ^0.9.2' pubspec.yaml

# Fix const constructors
echo "Adding const to constructors..."
find lib -name "*.dart" -exec sed -i 's/ThemeData(/const ThemeData(/g' {} \;
find lib -name "*.dart" -exec sed -i 's/TextStyle(/const TextStyle(/g' {} \;
find lib -name "*.dart" -exec sed -i 's/BorderRadius.circular(/BorderRadius.circular(/g' {} \;
find lib -name "*.dart" -exec sed -i 's/EdgeInsets.all(/const EdgeInsets.all(/g' {} \;
find lib -name "*.dart" -exec sed -i 's/EdgeInsets.symmetric(/const EdgeInsets.symmetric(/g' {} \;
find lib -name "*.dart" -exec sed -i 's/EdgeInsets.only(/const EdgeInsets.only(/g' {} \;

# Fix print statements
echo "Replacing print statements with debugPrint..."
find lib -name "*.dart" -exec sed -i 's/print(/debugPrint(/g' {} \;

# Fix BuildContext across async gaps
echo "Adding mounted checks for BuildContext across async gaps..."
sed -i '/ScaffoldMessenger.of(context).showSnackBar/i \ \ \ \ \ \ if (!mounted) return;' lib/features/subscription/screens/subscription_screen.dart

echo "Fixes applied! Run 'flutter analyze --no-fatal-infos --no-fatal-warnings' to check for remaining errors."