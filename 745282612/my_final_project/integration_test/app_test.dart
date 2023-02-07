import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:my_final_project/init_app.dart';
import 'package:my_final_project/init_blocs.dart';
import 'package:my_final_project/main.dart' as app;

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('end-to-end test', () {
    testWidgets('Load app and read Home title', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      final initial = await initApp();

      await tester.pumpWidget(InitialBlocs(
        user: initial['user']!,
      ));
      await tester.pumpAndSettle();
      expect(find.text('Home'), findsWidgets);
    });
    testWidgets('Load app and switch theme and icon', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      final initial = await initApp();

      await tester.pumpWidget(InitialBlocs(
        user: initial['user']!,
      ));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Button theme'));
      await tester.pump();
      expect(find.byIcon(Icons.invert_colors), findsWidgets);
    });
  });
}
