import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:my_final_project/utils/theme/app_theme.dart';
import 'package:my_final_project/utils/theme/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(theme: ThemeData()));

  void initializer() async {
    ThemeData themeData;
    final prefs = await SharedPreferences.getInstance();
    final themeKey = prefs.getString('theme') ?? ThemeGlobalKey.light.toString();
    if (themeKey == ThemeGlobalKey.light.toString() || themeKey == '') {
      themeData = AppTheme.lightTheme;
      emit(state.copyWith(theme: themeData));
    } else {
      themeData = AppTheme.darkTheme;
      emit(state.copyWith(theme: themeData));
    }
  }

  Future<void> changeTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (state.theme == AppTheme.lightTheme) {
      prefs.setString('theme', ThemeGlobalKey.dark.toString());
      emit(state.copyWith(theme: AppTheme.darkTheme));
    } else {
      prefs.setString('theme', ThemeGlobalKey.light.toString());
      emit(state.copyWith(theme: AppTheme.lightTheme));
    }
  }

  bool isLight() => state.theme == AppTheme.lightTheme;
}
