import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:quit_vaping/app.dart';
import 'package:quit_vaping/data/services/storage_service.dart';
import 'package:quit_vaping/data/services/user_service.dart';
import 'package:quit_vaping/data/services/ai_service.dart';
import 'package:quit_vaping/data/services/nrt_service.dart';

void main() {
  testWidgets('App should build without crashing', (WidgetTester tester) async {
    // Mock services
    final storageService = StorageService();
    final userService = UserService(storageService);
    final aiService = AIService(storageService);
    final nrtService = NRTService(storageService);
    
    // Build our app and trigger a frame
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<UserService>(create: (_) => userService),
          ChangeNotifierProvider<AIService>(create: (_) => aiService),
          ChangeNotifierProvider<NRTService>(create: (_) => nrtService),
          Provider<StorageService>(create: (_) => storageService),
        ],
        child: const QuitVapingApp(),
      ),
    );

    // Verify that the app builds without crashing
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}