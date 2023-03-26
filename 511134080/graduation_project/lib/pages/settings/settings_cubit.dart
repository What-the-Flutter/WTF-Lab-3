import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../providers/settings_provider.dart';
import '../../theme/theme.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsProvider settingsProvider;
  SettingsCubit()
      : settingsProvider = SettingsProvider(),
        super(SettingsState()) {
    init();
  }

  Future<void> init() async {
    final isLight = await settingsProvider.theme ?? true;
    final fontSize = await settingsProvider.fontSize ?? 0;
    final bubbleAlignment = await settingsProvider.bubbleAlignment ?? false;
    final centerDate = await settingsProvider.dateAlignment ?? false;
    emit(
      state.copyWith(
        light: isLight,
        newFontSize: fontSize,
        rightToLeft: bubbleAlignment,
        centerDate: centerDate,
      ),
    );
  }

  Future<void> toggleTheme() async {
    await settingsProvider.saveTheme(!state.isLight);
    emit(state.copyWith(light: !state.isLight));
  }

  Future<void> toggleFontSize() async {
    if (state.fontSize == 1) {
      await settingsProvider.saveFontSize(-1);
      emit(
        state.copyWith(
          newFontSize: -1,
        ),
      );
    } else {
      await settingsProvider.saveFontSize(state.fontSize + 1);
      emit(
        state.copyWith(
          newFontSize: state.fontSize + 1,
        ),
      );
    }
  }

  Future<void> toggleBubbleAlignment(bool value) async {
    await settingsProvider.saveBubbleAlignment(value);
    emit(
      state.copyWith(
        rightToLeft: value,
      ),
    );
  }

  Future<void> toggleCenterDate(bool value) async {
    await settingsProvider.saveDateAlignment(value);
    emit(
      state.copyWith(
        centerDate: value,
      ),
    );
  }

  Future<void> resetAllPreferences() async {
    await settingsProvider.saveDefaultPreferences();
    emit(
      state.copyWith(
        newFontSize: 0,
        light: true,
        rightToLeft: false,
        centerDate: false,
      ),
    );
  }
}
