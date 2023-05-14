import 'package:chat_journal/presentation/screens/settings/settings_cubit.dart';
import 'package:chat_journal/data/repos/shared_preferences_repository.dart';
import 'package:chat_journal/data/services/shared_preferences.dart';
import 'package:chat_journal/presentation/widgets/app_theme/app_theme_cubit.dart';
import 'package:chat_journal/presentation/widgets/app_theme/app_theme_state.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'settings test',
    () {
      test(
        'set font size',
        () {
          final SettingsCubit cubit = SettingsCubit(
            sharedPreferencesRepository: SharedPreferencesRepository(
              sharedPreferencesService: SharedPreferencesService(),
            ),
          );
          cubit.changeFont(12);
          expect(cubit.state.fontSize, 12);
          cubit.changeFont(16);
          expect(cubit.state.fontSize, 16);
        },
      );

      test(
        'set bubble alignment',
        () {
          final SettingsCubit cubit = SettingsCubit(
            sharedPreferencesRepository: SharedPreferencesRepository(
              sharedPreferencesService: SharedPreferencesService(),
            ),
          );
          cubit.changeBubbleAlignment(true);
          expect(cubit.state.isRightBubbleAlignment, true);
          cubit.changeBubbleAlignment(false);
          expect(cubit.state.isRightBubbleAlignment, false);
        },
      );

      test(
        'set center date bubble',
        () {
          final SettingsCubit cubit = SettingsCubit(
            sharedPreferencesRepository: SharedPreferencesRepository(
              sharedPreferencesService: SharedPreferencesService(),
            ),
          );
          cubit.changeDateBubble(true);
          expect(cubit.state.isCenterDateBubble, true);
          cubit.changeDateBubble(false);
          expect(cubit.state.isCenterDateBubble, false);
        },
      );
    },
  );

  group(
    'theme tests',
    () {
      test(
        'load theme',
        () {
          final AppThemeCubit appThemeCubit = AppThemeCubit(
            sharedPreferencesRepository: SharedPreferencesRepository(
              sharedPreferencesService: SharedPreferencesService(),
            ),
          );
          appThemeCubit.loadTheme();
          expect(appThemeCubit.state.theme, Themes.light);
        },
      );

      test(
        'change theme',
        () {
          final AppThemeCubit appThemeCubit = AppThemeCubit(
            sharedPreferencesRepository: SharedPreferencesRepository(
              sharedPreferencesService: SharedPreferencesService(),
            ),
          );
          appThemeCubit.changeTheme();
          expect(appThemeCubit.state.theme, Themes.dark);
        },
      );
    },
  );
}
