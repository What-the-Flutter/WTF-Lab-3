import 'package:flutter/material.dart';

abstract class ThemeRepositoryApi {
  static const Color defaultColor = Colors.blue;

  static const bool defaultIsDarkMode = true;

  Color get color;

  bool get isDarkMode;

  Future<void> setColor(Color color);

  Future<void> setDarkMode(bool isDarkMode);

  Future<void> resetToDefault();
}
