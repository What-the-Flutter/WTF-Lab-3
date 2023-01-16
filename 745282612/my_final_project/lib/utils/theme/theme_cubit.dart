import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:my_final_project/utils/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeData initTheme = AppTheme.lightTheme;

  ThemeCubit() : super(ThemeData()) {
    initializer();
  }

  Future<void> initializer() async {
    final prefs = await SharedPreferences.getInstance();
    final themeKey = prefs.getString('theme') ?? ThemeGlobalKey.light.toString();
    if (themeKey == ThemeGlobalKey.light.toString() || themeKey == '') {
      emit(initTheme = AppTheme.lightTheme);
    } else {
      emit(initTheme = AppTheme.darkTheme);
    }
  }

  Future<void> changeTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (state == AppTheme.lightTheme) {
      prefs.setString('theme', ThemeGlobalKey.dark.toString());
      emit(initTheme = AppTheme.darkTheme);
    } else {
      prefs.setString('theme', ThemeGlobalKey.light.toString());
      emit(initTheme = AppTheme.lightTheme);
    }
  }
}
