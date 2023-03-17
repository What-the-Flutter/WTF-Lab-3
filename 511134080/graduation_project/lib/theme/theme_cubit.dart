import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState()) {
    init();
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final isLight = await prefs.getBool('is_light') ?? true;
    await prefs.setBool('is_light', isLight);
    emit(
      ThemeState(
        isLight: isLight,
      ),
    );
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_light', !state.isLight);
    emit(ThemeState(isLight: !state.isLight));
  }
}
