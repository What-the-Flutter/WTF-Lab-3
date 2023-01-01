import 'package:flutter/material.dart';

enum MyThemesKeys {
  light,
  dark,
}

class MyThemes {
  static final lightTheme = ThemeData(
    primarySwatch: Colors.teal,
    brightness: Brightness.light,
  );

  static final darkTheme = ThemeData(
    primarySwatch: Colors.teal,
    brightness: Brightness.dark,
    textTheme: Typography(platform: TargetPlatform.android).black,
  );

  static ThemeData getTheme(MyThemesKeys themeKey) {
    switch (themeKey) {
      case MyThemesKeys.dark:
        return darkTheme;
      case MyThemesKeys.light:
        return lightTheme;
      default:
        return lightTheme;
    }
  }
}
