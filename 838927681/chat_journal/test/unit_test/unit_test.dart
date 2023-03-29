import 'package:chat_journal/data/provider/settings_provider.dart';
import 'package:chat_journal/data/repository/settings_repository.dart';
import 'package:chat_journal/presentation/pages/settings_page/settings_cubit.dart';
import 'package:flutter/src/widgets/binding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main() {
  group(
    'description',
    () {
      test(
        'set font size',
        () {
          WidgetsFlutterBinding.ensureInitialized();
          SharedPreferences.setMockInitialValues({});
          final SettingsCubit cubit = SettingsCubit(
            settingsRepository: SettingsRepository(
              settingsProvider: SettingsProvider(),
            ),
          );
          cubit.setFontSize(0);
          expect(cubit.state.fontSize, 0);
          cubit.setFontSize(1);
          expect(cubit.state.fontSize, 1);
          cubit.setFontSize(-1);
          expect(cubit.state.fontSize, -1);
        },
      );

      test(
        'set center date',
        () {
          WidgetsFlutterBinding.ensureInitialized();
          SharedPreferences.setMockInitialValues({});
          final SettingsCubit cubit = SettingsCubit(
            settingsRepository: SettingsRepository(
              settingsProvider: SettingsProvider(),
            ),
          );
          cubit.setCenterDate(true);
          expect(cubit.state.centerDate, true);
          cubit.setCenterDate(false);
          expect(cubit.state.centerDate, false);
        },
      );

      test(
        'set bubble alignment',
        () {
          WidgetsFlutterBinding.ensureInitialized();
          SharedPreferences.setMockInitialValues({});
          final SettingsCubit cubit = SettingsCubit(
            settingsRepository: SettingsRepository(
              settingsProvider: SettingsProvider(),
            ),
          );
          cubit.setBubbleAlignment(true);
          expect(cubit.state.bubbleAlignment, true);
          cubit.setBubbleAlignment(false);
          expect(cubit.state.bubbleAlignment, false);
        },
      );

      test(
        'set background image',
        () {
          WidgetsFlutterBinding.ensureInitialized();
          SharedPreferences.setMockInitialValues({});
          final SettingsCubit cubit = SettingsCubit(
            settingsRepository: SettingsRepository(
              settingsProvider: SettingsProvider(),
            ),
          );
          const image = 'some image';
          cubit.setBackgroundImage(image);
          expect(cubit.state.backgroundImage, image);
        },
      );

      test(
        'set lock',
        () {
          WidgetsFlutterBinding.ensureInitialized();
          SharedPreferences.setMockInitialValues({});
          final SettingsCubit cubit = SettingsCubit(
            settingsRepository: SettingsRepository(
              settingsProvider: SettingsProvider(),
            ),
          );
          cubit.setIsLocked(true);
          expect(cubit.state.isLocked, true);
          cubit.setIsLocked(false);
          expect(cubit.state.isLocked, false);
        },
      );

      test(
        'set theme',
        () {
          WidgetsFlutterBinding.ensureInitialized();
          SharedPreferences.setMockInitialValues({});
          final SettingsCubit cubit = SettingsCubit(
            settingsRepository: SettingsRepository(
              settingsProvider: SettingsProvider(),
            ),
          );
          final theme = cubit.state.isLightTheme;
          cubit.changeTheme();
          expect(cubit.state.isLightTheme, !theme);
          cubit.changeTheme();
          expect(cubit.state.isLightTheme, theme);
        },
      );

      test(
        'set default',
        () {
          WidgetsFlutterBinding.ensureInitialized();
          SharedPreferences.setMockInitialValues({});
          final SettingsCubit cubit = SettingsCubit(
            settingsRepository: SettingsRepository(
              settingsProvider: SettingsProvider(),
            ),
          );
          cubit.setDefault();
          expect(cubit.state.fontSize, 0);
          expect(cubit.state.isLightTheme, true);
          expect(cubit.state.isLocked, false);
          expect(cubit.state.backgroundImage, '');
          expect(cubit.state.bubbleAlignment, false);
          expect(cubit.state.centerDate, false);
        },
      );
    },
  );
}
