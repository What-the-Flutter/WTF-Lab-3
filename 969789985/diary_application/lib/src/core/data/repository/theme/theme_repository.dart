import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/api/theme/api_theme_repository.dart';
import '../../../util/resources/themes.dart';

class ThemeRepository extends ApiThemeRepository {
  static const String _isDarkModeKey =
      'com.wtflab.diary_application_theme_mode_key';
  static const String _messageFontSizeKey =
      'com.wtflab.diary_application_message_font_size';
  static const String _primaryColorKey =
      'com.wtflab.diary_application_primary_color';
  static const String _primaryItemColorKey =
      'com.wtflab.diary_application_primary_item_color';

  static bool _isDarkMode = false;

  static double _messageFontSize = 14.0;

  static int _primaryColor = LightPossibleColors.main.colors[0];

  static int _primaryItemColor = LightPossibleColors.main.colors[1];

  static Future<void> initialize() async {
    final preference = await SharedPreferences.getInstance();

    _isDarkMode = await preference.getBool(_isDarkModeKey) ?? false;
    _messageFontSize = await preference.getDouble(_messageFontSizeKey) ?? 14.0;
    _primaryColor = await preference.getInt(_primaryColorKey) ??
        LightPossibleColors.main.colors[0];
    _primaryItemColor = await preference.getInt(_primaryItemColorKey) ??
        LightPossibleColors.main.colors[1];
  }

  @override
  bool get isDarkMode => _isDarkMode;

  @override
  double get messageFontSize => _messageFontSize;

  @override
  int get primaryColor => _primaryColor;

  @override
  int get primaryItemColor => _primaryItemColor;

  @override
  Future<void> setDarkMode(bool isDarkMode) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_isDarkModeKey, isDarkMode);
  }

  @override
  Future<void> setMessageFontSize(double fontSize) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setDouble(_messageFontSizeKey, fontSize);
  }

  @override
  Future<void> setColors(int primaryColor, int primaryItemColor) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt(_primaryColorKey, primaryColor);
    await preferences.setInt(_primaryItemColorKey, primaryItemColor);
  }
}
