import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_repository_api.dart';

class ThemeRepository extends ThemeRepositoryApi {
  static const String _colorKey = 'themeColorKey';
  static const String _isDarkModeKey = 'themeIsDarkModeKey';

  static Color _color = Colors.blue;
  static bool _isDarkMode = true;

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();

    final colorCode = await prefs.getInt(_colorKey) ?? Colors.blue.value;
    _color = Color(colorCode);

    _isDarkMode = await prefs.getBool(_isDarkModeKey) ?? false;
  }

  @override
  Color get color => _color;

  @override
  bool get isDarkMode => _isDarkMode;

  @override
  Future<void> setColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    ThemeRepository._color = color;
    await prefs.setInt(_colorKey, color.value);
  }

  @override
  Future<void> setDarkMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    ThemeRepository._isDarkMode = isDarkMode;
    await prefs.setBool(_isDarkModeKey, isDarkMode);
  }
}
