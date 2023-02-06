import 'package:flutter/material.dart';

import '../themes/themes.dart';

abstract class ThemeRepositoryInterface {

  bool get isDarkMode;

  Future<void> setDarkMode(bool isDarkMode);

  Future<ThemeData> themeByKey(ThemeKeys key);

}