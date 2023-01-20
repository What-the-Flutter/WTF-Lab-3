import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:my_final_project/utils/theme/app_theme.dart';
import 'package:my_final_project/utils/theme/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(
          ThemeState(
            theme: AppTheme.lightTheme,
            textTheme: AppFontSize.mediumFontSize,
          ),
        );

  void initializer() async {
    ThemeData themeData;
    TextTheme textTheme;
    final prefs = await SharedPreferences.getInstance();
    final themeKey = prefs.getString('theme') ?? ThemeGlobalKey.light.toString();
    final fontKey = prefs.getString('font') ?? FontSizeKey.medium.toString();
    if (themeKey == ThemeGlobalKey.light.toString() || themeKey == '') {
      themeData = AppTheme.lightTheme;
    } else {
      themeData = AppTheme.darkTheme;
    }
    if (fontKey == FontSizeKey.medium.toString() || fontKey == '') {
      textTheme = AppFontSize.mediumFontSize;
    } else if (fontKey == FontSizeKey.small.toString()) {
      textTheme = AppFontSize.smallFontSize;
    } else {
      textTheme = AppFontSize.largeFontSize;
    }
    emit(state.copyWith(theme: themeData, textTheme: textTheme));
  }

  Future<void> changeFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    if (state.textTheme == AppFontSize.smallFontSize) {
      prefs.setString('font', FontSizeKey.medium.toString());
      emit(state.copyWith(textTheme: AppFontSize.mediumFontSize));
    } else if (state.textTheme == AppFontSize.mediumFontSize) {
      prefs.setString('font', FontSizeKey.large.toString());
      emit(state.copyWith(textTheme: AppFontSize.largeFontSize));
    } else {
      prefs.setString('font', FontSizeKey.small.toString());
      emit(state.copyWith(textTheme: AppFontSize.smallFontSize));
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
