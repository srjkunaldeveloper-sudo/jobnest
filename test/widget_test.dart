// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:jobnest/main.dart';
import 'package:jobnest/core/providers/theme_provider.dart';
import 'package:jobnest/features/splash/splash_screen.dart';
import 'package:jobnest/features/onboarding/onboarding_screen.dart';

void main() {
  testWidgets('JobNest startup flow smoke test', (WidgetTester tester) async {
    // Initialize SharedPreferences with empty values for clean test
    SharedPreferences.setMockInitialValues({});

    // Build our app wrapped in ThemeProvider as done in main()
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: const JobNestApp(),
      ),
    );

    // Pump once to allow async ThemeProvider._loadTheme() to complete
    await tester.pump();

    // Verify that our app starts at SplashScreen with JOBNEST logo text.
    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.text('JOBNEST'), findsOneWidget);

    // Pump duration to complete animation and initialization timers (3.5 seconds)
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // Verify that on a clean install (first launch), app navigates to OnboardingScreen.
    expect(find.byType(OnboardingScreen), findsOneWidget);
    expect(find.text('Smart Hiring Starts Here'), findsOneWidget);
  });
}
