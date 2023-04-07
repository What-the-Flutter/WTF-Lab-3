import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:diary_application/data/repository/settings_repository.dart';
import 'package:diary_application/data/provider/settings_provider.dart';
import 'package:diary_application/presentation/pages/settings/settings_cubit.dart';
import 'package:diary_application/presentation/pages/settings/settings_page.dart';
import 'package:diary_application/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:diary_application/presentation/pages/home/home_page.dart';
import 'package:diary_application/domain/utils/utils.dart';

void main() {
  group('Widget tests', () {
    // Widget test 1
    testWidgets('Settings elements', (widgetTester) async {
      final settings = BlocProvider<SettingsCubit>(
        create: (context) => SettingsCubit(
          rep: SettingsRepository(
            settingsProvider: SettingsProvider(),
          ),
        ),
        child: MaterialApp(
          supportedLocales: L10n.all,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: const Scaffold(
            body: Settings(),
          ),
        ),
      );
      await widgetTester.pumpWidget(settings);
      expect(find.text('Settings'), findsOneWidget);
      expect(find.byIcon(Icons.invert_colors), findsOneWidget);
      expect(find.byIcon(Icons.fingerprint), findsOneWidget);
      expect(find.byIcon(Icons.format_size), findsOneWidget);
      expect(find.byIcon(Icons.date_range_outlined), findsOneWidget);
      expect(find.byIcon(Icons.image), findsOneWidget);
      expect(find.byIcon(Icons.reset_tv), findsOneWidget);
      expect(find.byIcon(Icons.mail), findsNothing);
      expect(find.byType(Switch), findsWidgets);
    });

    // Widget test 2
    testWidgets('Bubble alignment swap', (widgetTester) async {
      final settings = BlocProvider<SettingsCubit>(
        create: (context) => SettingsCubit(
          rep: SettingsRepository(
            settingsProvider: SettingsProvider(),
          ),
        ),
        child: MaterialApp(
          supportedLocales: L10n.all,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: const Scaffold(
            body: Settings(),
          ),
        ),
      );
      await widgetTester.pumpWidget(settings);
      expect(find.byIcon(Icons.format_align_left), findsOneWidget);
      expect(find.byIcon(Icons.format_align_right), findsNothing);
      await widgetTester.tap(find.byKey(Key('bubble switch')));
      await widgetTester.pump();
      expect(find.byIcon(Icons.format_align_left), findsNothing);
      expect(find.byIcon(Icons.format_align_right), findsOneWidget);
    });

    // Widget test 3
    testWidgets('Default settings', (widgetTester) async {
      final cubit = SettingsCubit(
        rep: SettingsRepository(
          settingsProvider: SettingsProvider(),
        ),
      );
      final settings = BlocProvider<SettingsCubit>(
        create: (context) => cubit,
        child: MaterialApp(
          supportedLocales: L10n.all,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: const Scaffold(
            body: Settings(),
          ),
        ),
      );
      const size = 'FontSize';
      await widgetTester.pumpWidget(settings);
      expect(find.text(size), findsOneWidget);
      expect(cubit.state.fontSize, FontSize.medium.toString());
      await widgetTester.tap(find.text(size));
      await widgetTester.pump();
      expect(find.text(size), findsOneWidget);
      expect(cubit.state.fontSize, FontSize.big.toString());
      expect(find.byIcon(Icons.format_align_left), findsOneWidget);
      expect(find.byIcon(Icons.format_align_right), findsNothing);
      await widgetTester.tap(find.byKey(Key('bubble switch')));
      await widgetTester.pump();
      expect(find.byIcon(Icons.format_align_left), findsNothing);
      expect(find.byIcon(Icons.format_align_right), findsOneWidget);
      await widgetTester.tap(find.text('Reset all settings'));
      await widgetTester.pump();
      expect(find.byIcon(Icons.format_align_left), findsOneWidget);
      expect(find.byIcon(Icons.format_align_right), findsNothing);
      expect(cubit.state.fontSize, FontSize.medium.toString());
    });
  });
}
