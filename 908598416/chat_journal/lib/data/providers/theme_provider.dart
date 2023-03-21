import 'package:flutter/material.dart';
import '../preferences/theme_preference.dart';

class ThemeProvider extends ChangeNotifier {
  late bool _isDark;
  late ThemePreference _preferences;

  bool get isDark => _isDark;

  ThemeProvider() {
    _isDark = false;
    _preferences = ThemePreference();
    _getPreferences();
  }

  set isDark(bool value) {
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  void switchTheme() {
    if (_isDark) {
      isDark = false;
    } else {
      isDark = true;
    }
  }

  void _getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }
}
