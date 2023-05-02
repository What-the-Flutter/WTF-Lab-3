import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:chat_journal/presentation/widgets/app_theme/inherited_theme.dart';
import 'package:chat_journal/presentation/widgets/app_theme/theme.dart';
import 'package:chat_journal/presentation/screens/settings/settings.dart';
import 'package:chat_journal/presentation/screens/settings/settings_cubit.dart';
import 'package:chat_journal/data/repos/shared_preferences_repository.dart';
import 'package:chat_journal/data/services/shared_preferences.dart';
import 'package:chat_journal/presentation/widgets/app_theme/app_theme_cubit.dart';
import 'package:chat_journal/presentation/widgets/app_theme/app_theme_state.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(
    'integration test',
    () {
      testWidgets(
        'settings test',
        (tester) async {
          final cubit = SettingsCubit(
            sharedPreferencesRepository: SharedPreferencesRepository(
              sharedPreferencesService: SharedPreferencesService(),
            ),
          );
          await tester.pumpWidget(
            InheritedAppTheme(
              themeData: CustomTheme.lightTheme,
              child: BlocProvider<SettingsCubit>(
                create: (context) => cubit,
                child: MaterialApp(
                  home: SettingsScreen(),
                ),
              ),
            ),
          );
          await tester.tap(find.byType(Switch).last);
          await tester.pump();
          expect(cubit.state.isCenterDateBubble, true);
        },
      );

      testWidgets(
        'switch theme test',
        (tester) async {
          final settingsCubit = SettingsCubit(
            sharedPreferencesRepository: SharedPreferencesRepository(
              sharedPreferencesService: SharedPreferencesService(),
            ),
          );
          final themeCubit = AppThemeCubit(
            sharedPreferencesRepository: SharedPreferencesRepository(
              sharedPreferencesService: SharedPreferencesService(),
            ),
          );
          await tester.pumpWidget(
            InheritedAppTheme(
              themeData: CustomTheme.lightTheme,
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<AppThemeCubit>(
                    create: (context) => themeCubit,
                  ),
                  BlocProvider<SettingsCubit>(
                    create: (context) => settingsCubit,
                  ),
                ],
                child: MaterialApp(
                  home: SettingsScreen(),
                ),
              ),
            ),
          );
          final expectedTheme = themeCubit.state.theme == Themes.light
              ? Themes.dark
              : Themes.light;
          await tester.tap(find.byType(Switch).first);
          await tester.pump();
          expect(tester.widget<Switch>(find.byType(Switch).first).value, true);
          expect(themeCubit.state.theme, expectedTheme);
        },
      );
    },
  );
}
