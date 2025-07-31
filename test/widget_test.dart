// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:quit_vaping/main.dart';

void main() {
  testWidgets('QuitVaping app launches smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const QuitVapingApp());

    // Wait for the app to load
    await tester.pumpAndSettle();

    // Verify that the app launches and shows the welcome message
    expect(find.text('Welcome to QuitVaping'), findsOneWidget);
    
    // Verify that the main navigation elements are present
    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Breathing'), findsOneWidget);
    expect(find.text('Progress'), findsOneWidget);
    expect(find.text('NRT'), findsOneWidget);
  });

  testWidgets('Navigation between tabs works', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const QuitVapingApp());
    await tester.pumpAndSettle();

    // Tap on Breathing tab
    await tester.tap(find.text('Breathing'));
    await tester.pumpAndSettle();

    // Verify breathing exercises screen loads
    expect(find.text('Breathing Exercises'), findsOneWidget);

    // Tap on Progress tab
    await tester.tap(find.text('Progress'));
    await tester.pumpAndSettle();

    // Verify progress screen loads
    expect(find.text('Your Progress'), findsOneWidget);
  });
}
