// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:singlanguage12/main.dart';

void main() {
  testWidgets('App launches and shows StartPage', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());

    // Verify that StartPage elements are present
    expect(find.text('Choose Communication Type'), findsOneWidget);
    expect(find.text('Local Language'), findsOneWidget);

    // Verify the presence of Deaf and Hearing buttons
    expect(find.text('Deaf User (Signs → Text)'), findsOneWidget);
    expect(find.text('Hearing User (Text → Sign)'), findsOneWidget);

    // Verify the language dropdown default
    expect(find.text('Hindi'), findsOneWidget);
  });

  testWidgets('Tap Deaf User button navigates to DeafCameraScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Tap Deaf User button
    await tester.tap(find.text('Deaf User (Signs → Text)'));
    await tester.pumpAndSettle();

    // Verify DeafCameraScreen elements
    expect(find.text('Deaf Mode • Live Recognition'), findsOneWidget);
    expect(find.byTooltip('Switch Camera'), findsOneWidget);
    expect(find.byTooltip('Capture & Recognize'), findsOneWidget);
  });

  testWidgets('Tap Hearing User button navigates to HearingReplyScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Tap Hearing User button
    await tester.tap(find.text('Hearing User (Text → Sign)'));
    await tester.pumpAndSettle();

    // Verify HearingReplyScreen elements
    expect(find.text('Hearing Mode • Reply'), findsOneWidget);
    expect(find.text('Reply to Deaf User'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });
}
