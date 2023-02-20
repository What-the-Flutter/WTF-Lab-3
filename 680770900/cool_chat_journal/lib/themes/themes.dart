import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

enum ThemeKeys { light, dark, ugly }

class AppThemes {
  static final lightTheme = FlexThemeData.light(
    useMaterial3: true,
    surface: const Color(0xffff7373),
    scheme: FlexScheme.mandyRed,
  );

  static final darkTheme = FlexThemeData.dark(
    useMaterial3: true,
    scheme: FlexScheme.mandyRed,
  );

  static final ThemeData uglyTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFFACF53D),
        onPrimary: Color(0xFF015367),
        secondary: Color(0xFF8EEB00),
        onSecondary: Color(0xFF04819E),
        error: Colors.red,
        onError: Colors.yellow,
        background: Color(0xFF60B9CE),
        onBackground: Color(0xFF64DF85),
        surface: Color(0xFF00BF32),
        onSurface: Color(0xFF545454)),
  );

  static ThemeData getThemeFromKey(ThemeKeys key) {
    switch (key) {
      case ThemeKeys.ugly:
        return uglyTheme;

      case ThemeKeys.light:
        return lightTheme;

      case ThemeKeys.dark:
        return darkTheme;
    }
  }
}
