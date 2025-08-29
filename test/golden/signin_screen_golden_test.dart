import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:squadup/app/theme.dart';
import 'package:squadup/screens/auth_screen.dart';

void main() {
  group('SignIn Screen Golden Tests', () {
    testGoldens('SignIn Screen - English (LTR)', (tester) async {
      await tester.pumpWidgetBuilder(
        const AuthScreen(),
                 wrapper: materialAppWrapper(
           theme: SquadUpTheme.darkTheme,
         ),
        surfaceSize: const Size(375, 812), // iPhone X size
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(AuthScreen),
        matchesGoldenFile('signin_screen_english_ltr.png'),
      );
    });

    testGoldens('SignIn Screen - Arabic (RTL)', (tester) async {
      await tester.pumpWidgetBuilder(
        const AuthScreen(),
                 wrapper: materialAppWrapper(
           theme: SquadUpTheme.arabicTheme,
         ),
        surfaceSize: const Size(375, 812), // iPhone X size
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(AuthScreen),
        matchesGoldenFile('signin_screen_arabic_rtl.png'),
      );
    });

    testGoldens('SignIn Screen - English Tablet (LTR)', (tester) async {
      await tester.pumpWidgetBuilder(
        const AuthScreen(),
                 wrapper: materialAppWrapper(
           theme: SquadUpTheme.darkTheme,
         ),
        surfaceSize: const Size(768, 1024), // iPad size
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(AuthScreen),
        matchesGoldenFile('signin_screen_english_tablet_ltr.png'),
      );
    });

    testGoldens('SignIn Screen - Arabic Tablet (RTL)', (tester) async {
      await tester.pumpWidgetBuilder(
        const AuthScreen(),
                 wrapper: materialAppWrapper(
           theme: SquadUpTheme.arabicTheme,
         ),
        surfaceSize: const Size(768, 1024), // iPad size
      );

      await tester.pumpAndSettle();

      await expectLater(
        find.byType(AuthScreen),
        matchesGoldenFile('signin_screen_arabic_tablet_rtl.png'),
      );
    });

    testGoldens('SignIn Screen - Dark Theme Components', (tester) async {
      await tester.pumpWidgetBuilder(
        const AuthScreen(),
                 wrapper: materialAppWrapper(
           theme: SquadUpTheme.darkTheme,
         ),
        surfaceSize: const Size(375, 812),
      );

      await tester.pumpAndSettle();

      // Test individual components
      await expectLater(
        find.byType(TextField).first,
        matchesGoldenFile('signin_input_field_english.png'),
      );

      await expectLater(
        find.byType(ElevatedButton),
        matchesGoldenFile('signin_button_english.png'),
      );

      await expectLater(
        find.byType(Checkbox),
        matchesGoldenFile('signin_checkbox_english.png'),
      );
    });

    testGoldens('SignIn Screen - RTL Components', (tester) async {
      await tester.pumpWidgetBuilder(
        const AuthScreen(),
                 wrapper: materialAppWrapper(
           theme: SquadUpTheme.arabicTheme,
         ),
        surfaceSize: const Size(375, 812),
      );

      await tester.pumpAndSettle();

      // Test RTL-specific components
      await expectLater(
        find.byType(TextField).first,
        matchesGoldenFile('signin_input_field_arabic_rtl.png'),
      );

      await expectLater(
        find.byType(ElevatedButton),
        matchesGoldenFile('signin_button_arabic_rtl.png'),
      );

      await expectLater(
        find.byType(Checkbox),
        matchesGoldenFile('signin_checkbox_arabic_rtl.png'),
      );
    });

    testGoldens('SignIn Screen - Theme Colors Verification', (tester) async {
      await tester.pumpWidgetBuilder(
        const AuthScreen(),
                 wrapper: materialAppWrapper(
           theme: SquadUpTheme.darkTheme,
         ),
        surfaceSize: const Size(375, 812),
      );

      await tester.pumpAndSettle();

      // Verify theme colors are applied correctly
      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('signin_theme_colors_verification.png'),
      );
    });

    testGoldens('SignIn Screen - Typography Verification', (tester) async {
      await tester.pumpWidgetBuilder(
        const AuthScreen(),
                 wrapper: materialAppWrapper(
           theme: SquadUpTheme.darkTheme,
         ),
        surfaceSize: const Size(375, 812),
      );

      await tester.pumpAndSettle();

      // Verify typography is applied correctly
      await expectLater(
        find.byType(Text),
        matchesGoldenFile('signin_typography_verification.png'),
      );
    });

    testGoldens('SignIn Screen - Arabic Typography Verification', (tester) async {
      await tester.pumpWidgetBuilder(
        const AuthScreen(),
                 wrapper: materialAppWrapper(
           theme: SquadUpTheme.arabicTheme,
         ),
        surfaceSize: const Size(375, 812),
      );

      await tester.pumpAndSettle();

      // Verify Arabic typography is applied correctly
      await expectLater(
        find.byType(Text),
        matchesGoldenFile('signin_arabic_typography_verification.png'),
      );
    });

    testGoldens('SignIn Screen - Component Spacing', (tester) async {
      await tester.pumpWidgetBuilder(
        const AuthScreen(),
                 wrapper: materialAppWrapper(
           theme: SquadUpTheme.darkTheme,
         ),
        surfaceSize: const Size(375, 812),
      );

      await tester.pumpAndSettle();

      // Verify component spacing follows design system
      await expectLater(
        find.byType(Column),
        matchesGoldenFile('signin_component_spacing.png'),
      );
    });

    testGoldens('SignIn Screen - RTL Component Spacing', (tester) async {
      await tester.pumpWidgetBuilder(
        const AuthScreen(),
                 wrapper: materialAppWrapper(
           theme: SquadUpTheme.arabicTheme,
         ),
        surfaceSize: const Size(375, 812),
      );

      await tester.pumpAndSettle();

      // Verify RTL component spacing follows design system
      await expectLater(
        find.byType(Column),
        matchesGoldenFile('signin_rtl_component_spacing.png'),
      );
    });
  });
}
