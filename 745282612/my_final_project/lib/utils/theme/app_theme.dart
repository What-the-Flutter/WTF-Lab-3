import 'package:flutter/material.dart';

import 'package:my_final_project/utils/constants/app_colors.dart';

enum ThemeGlobalKey { light, dark }

enum FontSizeKey { small, medium, large }

class AppFontSize {
  static final smallFontSize = const TextTheme(
    displayMedium: TextStyle(fontSize: 20),
    bodyLarge: TextStyle(fontSize: 14),
    bodyMedium: TextStyle(fontSize: 12),
  );
  static final mediumFontSize = const TextTheme(
    displayMedium: TextStyle(fontSize: 22),
    bodyLarge: TextStyle(fontSize: 16),
    bodyMedium: TextStyle(fontSize: 14),
  );
  static final largeFontSize = const TextTheme(
    displayMedium: TextStyle(fontSize: 24),
    bodyLarge: TextStyle(fontSize: 18),
    bodyMedium: TextStyle(fontSize: 16),
  );
}

class AppTheme {
  static const floatingStyle = FloatingActionButtonThemeData(
    backgroundColor: AppColors.colorLightYellow,
    foregroundColor: Colors.black,
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.colorTurquoise,
      unselectedItemColor: Colors.grey,
    ),
    appBarTheme: const AppBarTheme(
      color: AppColors.colorTurquoise,
      centerTitle: true,
    ),
    floatingActionButtonTheme: floatingStyle,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: AppColors.colorLightYellow,
      unselectedItemColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      centerTitle: true,
    ),
    floatingActionButtonTheme: floatingStyle,
  );
}
