import 'package:chat_journal/data/provider/settings_provider.dart';
import 'package:chat_journal/data/repository/settings_repository.dart';
import 'package:chat_journal/presentation/pages/settings_page/settings.dart';
import 'package:chat_journal/presentation/pages/settings_page/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'integration test',
    () {
      testWidgets(
        'change FontSize',
        (widgetTester) async {
          final cubit = SettingsCubit(
            settingsRepository: SettingsRepository(
              settingsProvider: const SettingsProvider(),
            ),
          );
          final home = BlocProvider<SettingsCubit>(
            create: (context) => cubit,
            child: MaterialApp(
              home: const Scaffold(
                body: Settings(),
              ),
            ),
          );
          await widgetTester.pumpWidget(home);
          expect(cubit.state.fontSize, 0);
          await widgetTester.tap(find.text('FontSize'));
          await widgetTester.pump();
          await widgetTester.tap(find.text('Small'));
          await widgetTester.pump();
          expect(cubit.state.fontSize, -1);
        },
      );

      testWidgets(
        'change bubbleAlignment',
        (widgetTester) async {
          final cubit = SettingsCubit(
            settingsRepository: SettingsRepository(
              settingsProvider: const SettingsProvider(),
            ),
          );
          final home = BlocProvider<SettingsCubit>(
            create: (context) => cubit,
            child: MaterialApp(
              home: const Scaffold(
                body: Settings(),
              ),
            ),
          );
          await widgetTester.pumpWidget(home);
          expect(find.byIcon(Icons.format_align_left), findsOneWidget);
          expect(cubit.state.bubbleAlignment, false);
          await widgetTester.tap(find.byType(Switch).first);
          await widgetTester.pump();
          expect(find.byIcon(Icons.format_align_right), findsOneWidget);
          expect(cubit.state.bubbleAlignment, true);
        },
      );
    },
  );
}
