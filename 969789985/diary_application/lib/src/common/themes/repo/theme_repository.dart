import 'package:shared_preferences/shared_preferences.dart';

import '../interfaces/theme_repository_interface.dart';

class ThemeRepository extends ThemeRepositoryInterface {
  static const String _isDarkModeKey = 'diary_application_theme_mode_key';
  static const String _messageFontSizeKey = 'diary_application_message_font_size';
  static const String _primaryColorKey = 'diary_application_primary_color';
  static const String _primaryItemColorKey = 'diary_application_primary_item_color';

  static bool _isDarkMode = false;

  static double _messageFontSize = 14.0;

  static int _primaryColor = 0xFFffdebe;

  static int _primaryItemColor = 0xFFfbf3ec;

  static Future<void> initialize() async {
    final preference = await SharedPreferences.getInstance();

    _isDarkMode = await preference.getBool(_isDarkModeKey) ?? false;
    _messageFontSize = await preference.getDouble(_messageFontSizeKey) ?? 14.0;
    _primaryColor = await preference.getInt(_primaryColorKey) ?? 0xFFffdebe;
    _primaryItemColor = await preference.getInt(_primaryItemColorKey) ?? 0xFFfbf3ec;
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