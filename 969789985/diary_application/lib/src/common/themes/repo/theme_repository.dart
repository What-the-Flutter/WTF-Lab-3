import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../interfaces/theme_repository_interface.dart';

import '../themes/themes.dart';

class ThemeRepository extends ThemeRepositoryInterface {
  static const String _isDarkModeKey = 'diary_application_theme_mode_key';

  static bool _isDarkMode = false;

  static Future<void> initialize() async {
    final preference = await SharedPreferences.getInstance();

    _isDarkMode = await preference.getBool(_isDarkModeKey) ?? false;
  }

  @override
  // TODO: implement isDarkMode
  bool get isDarkMode => _isDarkMode;

  @override
  Future<void> setDarkMode(bool isDarkMode) async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_isDarkModeKey, isDarkMode);
  }

  @override
  Future<ThemeData> themeByKey(ThemeKeys key) async => await themeByKey(key);

}