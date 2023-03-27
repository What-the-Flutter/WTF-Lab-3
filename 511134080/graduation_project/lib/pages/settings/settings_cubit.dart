import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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
    final backgroundImage = await settingsProvider.backgroundImage ?? '';
    emit(
      state.copyWith(
        light: isLight,
        newFontSize: fontSize,
        rightToLeft: bubbleAlignment,
        centerDate: centerDate,
        newBackgroundImage: backgroundImage,
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

  Future<void> pickBackgroundImage() async {
    final status = await Permission.mediaLibrary.request();

    if (status.isGranted) {
      final imagePicker = ImagePicker();
      final pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        settingsProvider.saveBackgroundImage(pickedFile.path);
        emit(
          state.copyWith(
            newBackgroundImage: pickedFile.path,
          ),
        );
      }
    }
  }

  void unsetBackgroundImage() {
    settingsProvider.saveBackgroundImage('');
    emit(
      state.copyWith(
        newBackgroundImage: '',
      ),
    );
  }
}
