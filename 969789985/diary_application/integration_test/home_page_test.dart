import 'package:diary_application/main.dart' as app;
import 'package:diary_application/src/feature/widget/chatter/chatter_main/chatter_list_item/chatter_card.dart';
import 'package:diary_application/src/feature/widget/chatter/chatter_variation.dart';
import 'package:diary_application/src/feature/widget/main/animated_main_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:integration_test/integration_test.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Start screen test', () {
    testWidgets('start screen should render', (widgetTester) async {
      app.main();
      await widgetTester.pumpAndSettle(const Duration(seconds: 3));

      final gNav = find.byType(GNav);
      final fabButton = find.byType(FloatingActionButton);
      final appBar = find.byType(AppBar);
      final animateTitle = find.byType(AnimatedMainTitle);

      expect(gNav, findsOneWidget);
      expect(fabButton, findsOneWidget);
      expect(appBar, findsOneWidget);
      expect(animateTitle, findsOneWidget);
    });

    testWidgets('on FAB tap', (widgetTester) async {
      app.main();
      await widgetTester.pumpAndSettle(const Duration(seconds: 3));

      final fabButton = find.byType(FloatingActionButton);

      await widgetTester.tap(fabButton);
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.byType(ChatVariation), findsOneWidget);

      final backButton = find.byIcon(Icons.arrow_back);

      expect(backButton, findsOneWidget);

      await widgetTester.tap(backButton);
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));

      final gNav = find.byType(GNav);

      expect(gNav, findsOneWidget);
    });
  });
  
  testWidgets('should add chat', (widgetTester) async {
    app.main();
    await widgetTester.pumpAndSettle(const Duration(seconds: 3));

    final fabButton = find.byType(FloatingActionButton);

    await widgetTester.tap(fabButton);
    await widgetTester.pumpAndSettle(const Duration(seconds: 1));

    final textField = find.byType(TextField);

    await widgetTester.enterText(textField, 'Test chats');
    await widgetTester.pumpAndSettle();

    final addFabButton = find.byType(FloatingActionButton);

    await widgetTester.tap(addFabButton);
    await widgetTester.pumpAndSettle(const Duration(seconds: 1));

    final chatterCard = find.byType(ChatterCard);

    expect(chatterCard, findsWidgets);
  });

}
