// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:squadup/main.dart';
import 'package:squadup/screens/team_discovery_screen.dart';
import 'package:squadup/widgets/common/app_button.dart';
import 'package:squadup/widgets/common/app_card.dart';

void main() {
  group('SquadUp App Tests', () {
    testWidgets('App should start without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );
      
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('AppButton should render correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Test Button',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('AppButton should handle loading state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Loading Button',
              onPressed: () {},
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading Button'), findsNothing);
    });

    testWidgets('AppButton should handle disabled state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Disabled Button',
              onPressed: null,
            ),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('AppCard should render correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppCard(
              child: const Text('Card Content'),
            ),
          ),
        ),
      );

      expect(find.text('Card Content'), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('AppCard should handle tap events', (WidgetTester tester) async {
      bool tapped = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppCard(
              onTap: () => tapped = true,
              child: const Text('Tappable Card'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tappable Card'));
      expect(tapped, isTrue);
    });

    testWidgets('AppCardHeader should render correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppCardHeader(
              title: const Text('Card Title'),
              subtitle: const Text('Card Subtitle'),
              leading: const Icon(Icons.star),
              trailing: const Icon(Icons.arrow_forward),
            ),
          ),
        ),
      );

      expect(find.text('Card Title'), findsOneWidget);
      expect(find.text('Card Subtitle'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('AppCardContent should render correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppCardContent(
              child: const Text('Card Content'),
            ),
          ),
        ),
      );

      expect(find.text('Card Content'), findsOneWidget);
    });
  });

  group('Team Discovery Screen Tests', () {
    testWidgets('TeamDiscoveryScreen should render correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TeamDiscoveryScreen(),
        ),
      );

      expect(find.text('Find Teams'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('Search functionality should work', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TeamDiscoveryScreen(),
        ),
      );

      final searchField = find.byType(TextField);
      await tester.enterText(searchField, 'Basketball');
      await tester.pump();

      expect(find.text('Basketball'), findsOneWidget);
    });

    testWidgets('Sport filter should work', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: TeamDiscoveryScreen(),
        ),
      );

      expect(find.text('All'), findsOneWidget);
      expect(find.text('Basketball'), findsOneWidget);
      expect(find.text('Football'), findsOneWidget);
    });
  });

  group('Accessibility Tests', () {
    testWidgets('AppButton should have semantic label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              text: 'Accessible Button',
              onPressed: () {},
              semanticLabel: 'Custom semantic label',
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(AppButton));
      expect(semantics.label, 'Custom semantic label');
    });

    testWidgets('AppCard should have semantic label when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppCard(
              semanticLabel: 'Team information card',
              child: const Text('Card Content'),
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(AppCard));
      expect(semantics.label, 'Team information card');
    });
  });

  group('Theme Tests', () {
    testWidgets('App should use dark theme by default', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MyApp(),
        ),
      );

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.themeMode, ThemeMode.dark);
    });

    testWidgets('AppButton should use theme colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          ),
          home: Scaffold(
            body: AppButton(
              text: 'Themed Button',
              onPressed: () {},
            ),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.style?.backgroundColor?.resolve({}), isNotNull);
    });
  });
}
