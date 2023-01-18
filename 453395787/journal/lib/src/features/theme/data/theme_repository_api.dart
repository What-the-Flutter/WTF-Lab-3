import 'package:flutter/material.dart';

abstract class ThemeRepositoryApi {
  Color get color;

  bool get isDarkMode;

  Future<void> setColor(Color color);

  Future<void> setDarkMode(bool isDarkMode);
}
