import 'package:graduation_project/providers/settings_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main() {
  group(
    'settings provider',
    () {
      group(
        'default value if no value is stored in SharedPreferences',
        () {
          test(
            'theme',
            () async {
              SharedPreferences.setMockInitialValues({});

              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();

              final settingsProvider = SettingsProvider();

              final expectedThemeValue = true;
              final actualThemeValue = await settingsProvider.theme;
              expect(expectedThemeValue, actualThemeValue);
            },
          );
          test(
            'font size',
            () async {
              SharedPreferences.setMockInitialValues({});

              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();

              final settingsProvider = SettingsProvider();

              final expectedFontSizeValue = 0;
              final actualFontSizeValue = await settingsProvider.fontSize;
              expect(expectedFontSizeValue, actualFontSizeValue);
            },
          );

          test(
            'bubble alignment',
            () async {
              SharedPreferences.setMockInitialValues({});

              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();

              final settingsProvider = SettingsProvider();

              final expectedBubbleAlignmentValue = false;
              final actualBubbleAlignmentValue =
                  await settingsProvider.bubbleAlignment;
              expect(expectedBubbleAlignmentValue, actualBubbleAlignmentValue);
            },
          );

          test('date alignment', () async {
            SharedPreferences.setMockInitialValues({});

            final SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();

            final settingsProvider = SettingsProvider();

            final expectedDateAlignmentValue = false;
            final actualDateAlignmentValue =
                await settingsProvider.dateAlignment;
            expect(expectedDateAlignmentValue, actualDateAlignmentValue);
          });

          test(
            'background image',
            () async {
              SharedPreferences.setMockInitialValues({});

              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();

              final settingsProvider = SettingsProvider();

              final expectedBackgroundImageValue = '';
              final actualBackgroundImageValue =
                  await settingsProvider.backgroundImage;
              expect(expectedBackgroundImageValue, actualBackgroundImageValue);
            },
          );

          test(
            'use fingerprint',
            () async {
              SharedPreferences.setMockInitialValues({});

              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();

              final settingsProvider = SettingsProvider();

              final expectedUsingFingerprintValue = false;
              final actualUsingFingerprintValue =
                  await settingsProvider.useFingerprint;
              expect(
                  expectedUsingFingerprintValue, actualUsingFingerprintValue);
            },
          );
        },
      );

      group(
        'returns value that was set in SharedPreferences',
        () {
          test(
            'theme',
            () async {
              SharedPreferences.setMockInitialValues({});

              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();

              final settingsProvider = SettingsProvider();

              await settingsProvider.saveTheme(false);
              final expectedThemeValue = false;
              final actualThemeValue = await settingsProvider.theme;
              expect(expectedThemeValue, actualThemeValue);
            },
          );

          test(
            'font size',
            () async {
              SharedPreferences.setMockInitialValues({});

              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();

              final settingsProvider = SettingsProvider();

              await settingsProvider.saveFontSize(1);
              final expectedFontSizeValue = 1;
              final actualFontSizeValue = await settingsProvider.fontSize;
              expect(expectedFontSizeValue, actualFontSizeValue);
            },
          );
          test(
            'bubble alignment',
            () async {
              SharedPreferences.setMockInitialValues({});

              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();

              final settingsProvider = SettingsProvider();

              await settingsProvider.saveBubbleAlignment(true);
              final expectedBubbleAlignmentValue = true;
              final actualBubbleAlignmentValue =
                  await settingsProvider.bubbleAlignment;
              expect(expectedBubbleAlignmentValue, actualBubbleAlignmentValue);
            },
          );
          test(
            'date alignment',
            () async {
              SharedPreferences.setMockInitialValues({});

              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();

              final settingsProvider = SettingsProvider();

              await settingsProvider.saveDateAlignment(true);
              final expectedDateAlignmentValue = true;
              final actualDateAlignmentValue =
                  await settingsProvider.dateAlignment;
              expect(expectedDateAlignmentValue, actualDateAlignmentValue);
            },
          );
          test(
            'image background',
            () async {
              SharedPreferences.setMockInitialValues({});

              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();

              final settingsProvider = SettingsProvider();

              await settingsProvider.saveBackgroundImage('image.png');
              final expectedBackgroundImageValue = 'image.png';
              final actualBackgroundImageValue =
                  await settingsProvider.backgroundImage;
              expect(expectedBackgroundImageValue, actualBackgroundImageValue);
            },
          );
          test(
            'use fingerprint',
            () async {
              SharedPreferences.setMockInitialValues({});

              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();

              final settingsProvider = SettingsProvider();

              await settingsProvider.saveUsingFingerprint(true);
              final expectedUsingFingerprintValue = true;
              final actualUsingFingerprintValue =
                  await settingsProvider.useFingerprint;
              expect(
                  expectedUsingFingerprintValue, actualUsingFingerprintValue);
            },
          );
        },
      );

      group(
        'set default values for theme and font size',
        () {
          test(
            'theme',
            () async {
              SharedPreferences.setMockInitialValues({});

              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();

              final settingsProvider = SettingsProvider();

              await settingsProvider.saveTheme(false);
              await settingsProvider.saveFontSize(1);

              await settingsProvider.saveDefaultThemeAndFontPreferences();

              final expectedThemeValue = true;
              final actualThemeValue = await settingsProvider.theme;
              expect(expectedThemeValue, actualThemeValue);
            },
          );
          test(
            'font size',
            () async {
              SharedPreferences.setMockInitialValues({});

              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();

              final settingsProvider = SettingsProvider();

              await settingsProvider.saveTheme(false);
              await settingsProvider.saveFontSize(1);

              await settingsProvider.saveDefaultThemeAndFontPreferences();

              final expectedFontSizeValue = 0;
              final actualFontSizeValue = await settingsProvider.fontSize;
              expect(expectedFontSizeValue, actualFontSizeValue);
            },
          );
        },
      );
    },
  );
}
