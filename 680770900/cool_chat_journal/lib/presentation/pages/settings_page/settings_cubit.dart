import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import '../../../data/models/theme.dart';
import '../../../data/repository/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final _settingsRepository = SettingsRepository();

  SettingsCubit() : super(SettingsState(themeData: ThemeKeyX.lightTheme));

  Future<void> initTheme() async {
    final themeKey = await _settingsRepository.updateTheme();

    emit(
      state.copyWith(
        themeKey: themeKey,
        themeData: themeKey.themeData,
      )
    );
  }

  Future<void> switchTheme() async {
    final ThemeKey themeKey;
    switch (state.themeKey) {
      case ThemeKey.light:
        themeKey = ThemeKey.dark;
        break;
      case ThemeKey.dark:
        themeKey = ThemeKey.light;
        break;
    }

    await _settingsRepository.saveTheme(themeKey);

    emit(
      state.copyWith(
        themeKey: themeKey,
        themeData: themeKey.themeData,
      )
    );
  }
}
