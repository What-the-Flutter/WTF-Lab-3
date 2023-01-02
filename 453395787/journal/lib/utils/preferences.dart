import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static final _instance = ThemePreferences._();

  static late SharedPreferences _prefs;
  final _colorKey = 'themeColor';
  final _isDarkModeKey = 'isDarkMode';

  ThemePreferences._();

  factory ThemePreferences.get() => _instance;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Color get color {
    final colorCode = _prefs.getInt(_colorKey);
    if (colorCode == null) {
      color = Colors.blue;
      return Colors.blue;
    } else {
      return Color(colorCode);
    }
  }

  set color(Color color) {
    _prefs.setInt(_colorKey, color.value);
  }

  bool get isDarkMode {
    final value = _prefs.getBool(_isDarkModeKey);
    if (value == null) {
      isDarkMode = false;
      return false;
    } else {
      return value;
    }
  }

  set isDarkMode(bool value) {
    _prefs.setBool(_isDarkModeKey, value);
  }
}
