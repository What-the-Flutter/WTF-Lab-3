import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graduation_project/main.dart' as app;
import 'package:graduation_project/pages/home/home_page.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group(
    'main page test',
    () {
      testWidgets(
        'welcome animation and switching to home page',
        (widgetTester) async {
          app.main();
          await widgetTester.pumpAndSettle(
            const Duration(
              seconds: 2,
            ),
          );

          expect(
              find.widgetWithText(
                HomePage,
                'Home',
              ),
              findsOneWidget);
        },
      );

      testWidgets(
        'default theme, switching theme',
        (widgetTester) async {
          app.main();
          await widgetTester.pumpAndSettle();

          final lightThemeIconFinder = find.byIcon(
            Icons.sunny,
          );

          expect(lightThemeIconFinder, findsOneWidget);

          await widgetTester.tap(lightThemeIconFinder);
          await widgetTester.pumpAndSettle();

          expect(
              find.byIcon(
                Icons.dark_mode_outlined,
              ),
              findsOneWidget);
        },
      );

      testWidgets(
        'adding chat',
        (widgetTester) async {
          app.main();
          await widgetTester.pumpAndSettle();

          await widgetTester.tap(
            find.byIcon(
              Icons.add,
            ),
          );
          await widgetTester.pumpAndSettle();

          expect(find.text('Create a new Page'), findsOneWidget);

          await widgetTester.enterText(find.byType(TextField), 'chat1');
          await widgetTester.pumpAndSettle();
          await widgetTester.tap(
            find.byType(FloatingActionButton),
          );
          await widgetTester.pumpAndSettle();

          expect(find.text('chat1'), findsOneWidget);
        },
      );
    },
  );
}
