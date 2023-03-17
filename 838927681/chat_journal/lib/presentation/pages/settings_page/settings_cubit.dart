import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/api_settings_repository.dart';
import '../../../theme/themes.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final ApiSettingsRepository _settingsRepository;

  SettingsCubit({required ApiSettingsRepository settingsRepository})
      : _settingsRepository = settingsRepository,
        super(
          const SettingsState(
            isLightTheme: true,
            isLocked: false,
            backgroundImage: '',
            bubbleAlignment: false,
            centerDate: false,
            fontSize: 0,
          ),
        ) {
    _init();
  }

  void _init() async {
    final theme = await _settingsRepository.theme;
    final isLocked = await _settingsRepository.isLocked;
    final bubbleAlignment = await _settingsRepository.bubbleAlignment;
    final backgroundImage = await _settingsRepository.backgroundImage;
    final centerDate = await _settingsRepository.centerDate;
    final fontSize = await _settingsRepository.fontSize;
    emit(state.copyWith(
      isLightTheme: theme,
      isLocked: isLocked,
      bubbleAlignment: bubbleAlignment,
      backgroundImage: backgroundImage,
      fontSize: fontSize,
      centerDate: centerDate,
    ));
  }

  void changeTheme() {
    if (state.isLightTheme) {
      _settingsRepository.setTheme(false);
      emit(state.copyWith(isLightTheme: false));
    } else {
      _settingsRepository.setTheme(true);
      emit(state.copyWith(isLightTheme: true));
    }
  }

  void setIsLocked(bool value) {
    _settingsRepository.setIsLocked(value);
    emit(state.copyWith(isLocked: value));
  }

  void setBubbleAlignment(bool value) {
    _settingsRepository.setBubbleAlignment(value);
    emit(state.copyWith(bubbleAlignment: value));
  }

  void setFontSize(int value) {
    _settingsRepository.setFontSize(value);
    switch (value) {
      case 0:
        {
          _settingsRepository.setFontSize(0);
          emit(state.copyWith(fontSize: 0));
          break;
        }
      case 1:
        {
          _settingsRepository.setFontSize(1);
          emit(state.copyWith(fontSize: 1));
          break;
        }
      case -1:
        {
          _settingsRepository.setFontSize(-1);
          emit(state.copyWith(fontSize: -1));
          break;
        }
    }
  }

  void setCenterDate(bool value) {
    _settingsRepository.setCenterDate(value);
    emit(state.copyWith(centerDate: value));
  }

  void setBackgroundImage(String path) {
    _settingsRepository.setBackgroundImage(path);
    emit(state.copyWith(backgroundImage: path));
  }

  void setDefault() {
    _settingsRepository.setDefault();
    emit(
      state.copyWith(
        centerDate: false,
        backgroundImage: '',
        bubbleAlignment: false,
        fontSize: 0,
        isLightTheme: true,
        isLocked: false,
      ),
    );
  }
}
