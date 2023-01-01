import 'package:flutter/material.dart';

import 'theme_preferences.dart';

class ThemeModel extends ChangeNotifier {
  late bool _isDark;
  late ThemePreferences _preferences;

  bool get isDark => _isDark;

  ThemeModel() {
    _isDark = false;
    _preferences = ThemePreferences();
    getPreferences();
  }

  set isDark(bool value) {
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  void getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }
}
