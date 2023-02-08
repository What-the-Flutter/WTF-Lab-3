import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme/themes.dart';

class ThemeProvider {
  Future<ThemeData> get theme async {
    final prefs = await SharedPreferences.getInstance();
    final isLight = prefs.getBool('isLight') ?? true;
    return isLight ? Themes.lightTheme : Themes.darkTheme;
  }

  Future<void> setTheme(ThemeData theme) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLight', theme == Themes.lightTheme);
  }
}
