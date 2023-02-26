import 'package:flutter/material.dart';

enum LightPossibleColors {
  main([0xFFffdebe, 0xFFfbf3ec]),
  green([0xFFccffb4, 0xFFedf1e5]),
  orange([0xFFf0a98a, 0xFFf9e4bd]),
  pink([0xFFffc7b8, 0xFFfff4f2]),
  blue([0xFFb2c5ff, 0xFFdae2ff]),
  violet([0xFFe8def8, 0xFFf6edff]),
  grey([0xFFbbbac0, 0xFFe8e8e8]),
  beige([0xFFaa9b8d, 0xFFbbb6b0]);

  final List<int> colors;

  const LightPossibleColors(this.colors);
}

enum DarkPossibleColors {
  main([0xFF141414, 0xFF202020]),
  darkPurple([0xFF3a2d49, 0xFF362e3d]),
  darkBrown([0xFF211312, 0xFF342222]);

  final List<int> colors;

  const DarkPossibleColors(this.colors);
}

abstract class AppColors {
  //Light colors
  static const int primaryLight = 0xFFffdebe;
  static const int primaryBackgroundLight = 0xFFfdfdfd;
  static const int primaryItemLight = 0xFFfbf3ec;

  //Dark colors
  static const int primaryDark = 0xFF141414;
  static const int primaryBackgroundDark = 0xFF232325;
  static const int primaryItemDark = 0xFF202020;
}

enum ThemeKeys { light, dark }

class Themes {
  static final ThemeData _lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.white,
    primaryColorLight: const Color(AppColors.primaryLight),
    primarySwatch: Colors.grey,
    scaffoldBackgroundColor: const Color(AppColors.primaryBackgroundLight),
    indicatorColor: Colors.black,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Color(AppColors.primaryBackgroundLight),
      surfaceTintColor: Color(AppColors.primaryBackgroundLight),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: const Color(AppColors.primaryLight),
      elevation: 2,
      sizeConstraints: const BoxConstraints(minWidth: 90.0, minHeight: 90.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      foregroundColor: Colors.black,
    ),
    cardTheme: const CardTheme(
      elevation: 0,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
        elevation: 0,
        backgroundColor: Color(0x00FFFFFF),
        surfaceTintColor: Color(0x00FFFFFF)),
    sliderTheme: SliderThemeData(
      trackHeight: 2.0,
      overlayShape: SliderComponentShape.noThumb,
    ),
    dialogTheme: const DialogTheme(
      elevation: 0,
      backgroundColor: Color(AppColors.primaryBackgroundLight),
    ),
  );

  static final ThemeData _darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColorLight: const Color(AppColors.primaryDark),
    scaffoldBackgroundColor: const Color(AppColors.primaryBackgroundDark),
    primarySwatch: Colors.grey,
    indicatorColor: Colors.white,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Color(AppColors.primaryBackgroundDark),
      surfaceTintColor: Color(AppColors.primaryBackgroundDark),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: const Color(AppColors.primaryDark),
      elevation: 2,
      sizeConstraints: const BoxConstraints(minWidth: 90.0, minHeight: 90.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      foregroundColor: Colors.white,
    ),
    cardTheme: const CardTheme(
      color: Color(AppColors.primaryItemDark),
      elevation: 0,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),
    sliderTheme: SliderThemeData(
      trackHeight: 2.0,
      thumbColor: const Color(AppColors.primaryDark),
      activeTrackColor: const Color(AppColors.primaryDark),
      overlayShape: SliderComponentShape.noThumb,
    ),
    dialogTheme: const DialogTheme(
      elevation: 0,
      backgroundColor: Color(AppColors.primaryBackgroundDark),

    ),
  );

  static ThemeData getThemeFromKey(ThemeKeys themeKey) {
    switch (themeKey) {
      case ThemeKeys.light:
        return _lightTheme;
      case ThemeKeys.dark:
        return _darkTheme;
      default:
        return _lightTheme;
    }
  }
}
