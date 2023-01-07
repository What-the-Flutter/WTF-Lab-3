import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_repository_api.dart';

class ThemeRepository extends ThemeRepositoryApi {
  static const String _colorKey = 'themeColorKey';
  static const String _isDarkModeKey = 'themeIsDarkModeKey';

  @override
  Future<Color> getColor() async {
    var prefs = await SharedPreferences.getInstance();
    var colorCode = await prefs.getInt(_colorKey) ?? Colors.blue.value;
    return Color(colorCode);
  }

  @override
  Future<bool> getDarkMode() async {
    var prefs = await SharedPreferences.getInstance();
    var isDarkMode = await prefs.getBool(_isDarkModeKey) ?? false;
    return isDarkMode;
  }

  @override
  Future<void> setColor(Color color) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_colorKey, color.value);
  }

  @override
  Future<void> setDarkMode(bool isDarkMode) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isDarkModeKey, isDarkMode);
  }

  static final List<Color> colors = [
    Colors.pink,
    Colors.red,
    Colors.deepOrange,
    Colors.orange,
    Colors.amber,
    Colors.yellow,
    Colors.lime,
    Colors.lightGreen,
    Colors.green,
    Colors.teal,
    Colors.cyan,
    Colors.lightBlue,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.deepPurple,
    Colors.blueGrey,
    Colors.brown,
  ];
}
