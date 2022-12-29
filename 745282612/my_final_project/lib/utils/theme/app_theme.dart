import 'package:flutter/material.dart';

import 'package:my_final_project/utils/constants/app_colors.dart';

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
