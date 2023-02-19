import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'colors.dart';

class ThemePreferences {
  static final String themeKey = 'isDark?';

  Future<ThemeData> get theme async {
    final preferences = await SharedPreferences.getInstance();
    final isDark = preferences.getBool(themeKey) ?? true;
    return isDark ? CustomTheme.darkTheme : CustomTheme.lightTheme;
  }

  Future<void> switchTheme(ThemeData theme) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setBool(themeKey, theme == CustomTheme.darkTheme);
  }
}