import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState()) {
    init();
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final isLight = await prefs.getBool('is_light') ?? true;
    await prefs.setBool('is_light', isLight);
    emit(
      state.copyWith(
        light: isLight,
      ),
    );
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_light', !state.isLight);
    emit(state.copyWith(light: !state.isLight));
  }
}
