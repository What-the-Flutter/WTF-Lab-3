import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../providers/settings_provider.dart';
import '../../theme/theme.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsProvider _settingsProvider;

  SettingsCubit({
    required SettingsProvider provider,
  })  : _settingsProvider = provider,
        super(SettingsState()) {
    init();
  }

  Future<void> init() async {
    final isLight = await _settingsProvider.theme;
    final fontSize = await _settingsProvider.fontSize;
    final bubbleAlignment = await _settingsProvider.bubbleAlignment;
    final centerDate = await _settingsProvider.dateAlignment;
    final backgroundImage = await _settingsProvider.backgroundImage;
    final useFingerprint = await _settingsProvider.useFingerprint;
    emit(
      state.copyWith(
        light: isLight,
        newFontSize: fontSize,
        rightToLeft: bubbleAlignment,
        centerDate: centerDate,
        newBackgroundImage: backgroundImage,
        useFingerprint: useFingerprint,
      ),
    );
  }

  Future<void> toggleTheme() async {
    await _settingsProvider.saveTheme(!state.isLight);
    emit(state.copyWith(light: !state.isLight));
  }

  Future<void> toggleFontSize() async {
    if (state.fontSize == 1) {
      await _settingsProvider.saveFontSize(-1);
      emit(
        state.copyWith(
          newFontSize: -1,
        ),
      );
    } else {
      await _settingsProvider.saveFontSize(state.fontSize + 1);
      emit(
        state.copyWith(
          newFontSize: state.fontSize + 1,
        ),
      );
    }
  }

  Future<void> toggleBubbleAlignment(bool value) async {
    await _settingsProvider.saveBubbleAlignment(value);
    emit(
      state.copyWith(
        rightToLeft: value,
      ),
    );
  }

  Future<void> toggleCenterDate(bool value) async {
    await _settingsProvider.saveDateAlignment(value);
    emit(
      state.copyWith(
        centerDate: value,
      ),
    );
  }

  Future<void> resetAllPreferences() async {
    await _settingsProvider.saveDefaultThemeAndFontPreferences();
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
        _settingsProvider.saveBackgroundImage(pickedFile.path);
        emit(
          state.copyWith(
            newBackgroundImage: pickedFile.path,
          ),
        );
      }
    }
  }

  void unsetBackgroundImage() {
    _settingsProvider.saveBackgroundImage('');
    emit(
      state.copyWith(
        newBackgroundImage: '',
      ),
    );
  }

  Future<void> toggleUsingFingerprint(bool value) async {
    await _settingsProvider.saveUsingFingerprint(value);
    emit(
      state.copyWith(
        useFingerprint: value,
      ),
    );
  }

  void startLoading() {
    emit(
      state.copyWith(
        loaded: true,
      ),
    );
    Future.delayed(
      const Duration(
        milliseconds: 3000,
      ),
    ).then(
      (_) => emit(
        state.copyWith(
          loaded: false,
        ),
      ),
    );
  }
}
