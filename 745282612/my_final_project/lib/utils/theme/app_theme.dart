import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.colorTurquoise,
      unselectedItemColor: Colors.grey,
    ),
    appBarTheme: const AppBarTheme(
      color: AppColors.colorTurquoise,
    ),
  );

  static final darkTheme = ThemeData(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.colorLightDark,
      unselectedItemColor: Colors.grey,
    ),
    appBarTheme: const AppBarTheme(
      color: AppColors.colorLightDark,
    ),
  );
}
