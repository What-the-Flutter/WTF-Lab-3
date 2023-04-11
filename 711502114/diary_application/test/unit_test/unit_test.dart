import 'package:test/test.dart';
import 'package:flutter/src/widgets/binding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diary_application/data/repository/settings_repository.dart';
import 'package:diary_application/data/provider/settings_provider.dart';
import 'package:diary_application/presentation/pages/settings/settings_cubit.dart';
import 'package:diary_application/domain/utils/utils.dart';

void main() {
  group('Settings Unit tests', () {
    // Unit test 1
    test('Theme changing', () {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      final SettingsCubit cubit = SettingsCubit(
        rep: SettingsRepository(
          settingsProvider: SettingsProvider(),
        ),
      );
      expect(cubit.isDark, true);
      cubit.changeTheme();
      expect(cubit.isDark, false);
    });

    // Unit test 2
    test('Font size setting', () {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      final SettingsCubit cubit = SettingsCubit(
        rep: SettingsRepository(
          settingsProvider: SettingsProvider(),
        ),
      );
      expect(cubit.state.fontSize, FontSize.medium.toString());
      cubit.setFontSize(FontSize.big.toString());
      expect(cubit.state.fontSize, FontSize.big.toString());
      cubit.setFontSize(FontSize.small.toString());
      expect(cubit.state.fontSize, FontSize.small.toString());
      cubit.setFontSize(FontSize.medium.toString());
      expect(cubit.state.fontSize, FontSize.medium.toString());
    });

    // Unit test 3
    test('Default settings', () {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      final SettingsCubit cubit = SettingsCubit(
        rep: SettingsRepository(
          settingsProvider: SettingsProvider(),
        ),
      );
      const image = 'diary_application\assets\bot.svg';

      cubit.setBackgroundImage(image);
      cubit.setFontSize(FontSize.big.toString());
      cubit.setCenterDate(true);
      cubit.setBubbleAlignment(true);
      cubit.setIsLocked(true);
      cubit.changeTheme();

      expect(cubit.state.fontSize, FontSize.big.toString());
      expect(cubit.state.isCenter, true);
      expect(cubit.state.alignment, true);
      expect(cubit.state.isLocked, true);
      expect(cubit.isDark, false);
      expect(cubit.state.backgroundImage, image);

      cubit.setDefault();

      expect(cubit.state.fontSize, FontSize.medium.toString());
      expect(cubit.state.isCenter, false);
      expect(cubit.state.alignment, false);
      expect(cubit.state.isLocked, false);
      expect(cubit.isDark, true);
      expect(cubit.state.backgroundImage, '');
    });
  });

  group('Utils Unit tests', () {
    // Unit test 4
    test('Text fitting', () {
      expect(fitText('This is text', 12), 'This is text');
      expect(fitText('When it comes to mobile apps, performance is critical to user experience.', 21), 'When it comes to mob...');
      expect(fitText('12345', 3), '12...');
      expect(fitText('1234567890', 11), '1234567890');
      expect(fitText('......', 3), '.....');
    });

    // Unit test 5
    test('Time format', () {
      String datetime = '2023-04-07 12:18:19.104';
      expect(formatTime(datetime, includeSec: false), '12:18');
      expect(formatTime(datetime), '12:18:19');

      datetime = '2023-06-22 04:03:05.104';
      expect(formatTime(datetime, includeSec: false), '04:03');
      expect(formatTime(datetime), '04:03:05');
    });
  });
}
