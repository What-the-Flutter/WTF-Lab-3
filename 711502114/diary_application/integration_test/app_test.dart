import 'package:diary_application/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Integration tests', () {
    // Integration test 1
    testWidgets('Home page', (widgetTester) async {
      app.main();
      await widgetTester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.text('Home'), findsWidgets);
    });

    // Integration test 2
    testWidgets('Chat adding', (widgetTester) async {
      app.main();
      await widgetTester.pumpAndSettle(const Duration(seconds: 3));
      await widgetTester.tap(find.byIcon(Icons.add));
      await widgetTester.pumpAndSettle();
      expect(find.text('Create a new Page'), findsOneWidget);

      await widgetTester.enterText(find.byType(TextField), 'chat@');
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(FloatingActionButton));
      await widgetTester.pumpAndSettle();
      expect(find.text('chat@'), findsOneWidget);
    });
  });
}
