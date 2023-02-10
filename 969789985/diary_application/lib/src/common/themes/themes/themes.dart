import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

IList<IList<int>> possibleColors = [
  [0xFFffdebe, 0xFFfbf3ec].lock,
  [0xFFccffb4, 0xFFedf1e5].lock,
  [0xFFf0a98a, 0xFFf9e4bd].lock,
  [0xFFffc7b8, 0xFFfff4f2].lock,
  [0xFFb2c5ff, 0xFFdae2ff].lock,
  [0xFFe8def8, 0xFFf6edff].lock,
  [0xFFbbbac0, 0xFFe8e8e8].lock,
].lock;

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


