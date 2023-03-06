import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/api_settings_repository.dart';
import '../../../theme/themes.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final ApiSettingsRepository _settingsRepository;

  SettingsCubit({required ApiSettingsRepository settingsRepository})
      : _settingsRepository = settingsRepository,
        super(
          SettingsState(
            theme: Themes.lightTheme,
            isLocked: false,
            backgroundImage: '',
            bubbleAlignment: false,
            centerDate: false,
            fontSize: Themes.normalTextTheme,
          ),
        ) {
    _init();
  }

  void _init() async {
    final theme =
        await _settingsRepository.theme ? Themes.lightTheme : Themes.darkTheme;
    final isLocked = await _settingsRepository.isLocked;
    final bubbleAlignment = await _settingsRepository.bubbleAlignment;
    final backgroundImage = await _settingsRepository.backgroundImage;
    final centerDate = await _settingsRepository.centerDate;
    final fontSize = await _settingsRepository.fontSize;
    if (fontSize == -1) {
      emit(state.copyWith(
        theme: theme,
        isLocked: isLocked,
        bubbleAlignment: bubbleAlignment,
        backgroundImage: backgroundImage,
        fontSize: Themes.smallTextTheme,
        centerDate: centerDate,
      ));
    } else {
      if (fontSize == 1) {
        emit(state.copyWith(
          theme: theme,
          isLocked: isLocked,
          bubbleAlignment: bubbleAlignment,
          backgroundImage: backgroundImage,
          fontSize: Themes.largeTextTheme,
          centerDate: centerDate,
        ));
      } else {
        emit(state.copyWith(
          theme: theme,
          isLocked: isLocked,
          bubbleAlignment: bubbleAlignment,
          backgroundImage: backgroundImage,
          fontSize: Themes.normalTextTheme,
          centerDate: centerDate,
        ));
      }
    }
  }

  void changeTheme() {
    if (state.theme == Themes.lightTheme) {
      _settingsRepository.setTheme(false);
      emit(state.copyWith(theme: Themes.darkTheme));
    } else {
      _settingsRepository.setTheme(true);
      emit(state.copyWith(theme: Themes.lightTheme));
    }
  }

  bool isLight() => state.theme == Themes.lightTheme;

  bool get isLocked => state.isLocked;

  bool get bubbleAlignment => state.bubbleAlignment;

  String get backgroundImage => state.backgroundImage;

  bool get centerDate => state.centerDate;

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
          emit(state.copyWith(fontSize: Themes.normalTextTheme));
          break;
        }
      case 1:
        {
          _settingsRepository.setFontSize(1);
          emit(state.copyWith(fontSize: Themes.largeTextTheme));
          break;
        }
      case -1:
        {
          _settingsRepository.setFontSize(-1);
          emit(state.copyWith(fontSize: Themes.smallTextTheme));
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
        fontSize: Themes.normalTextTheme,
        theme: Themes.lightTheme,
        isLocked: false,
      ),
    );
  }
}
