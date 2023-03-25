import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repository/settings_repository_api.dart';
import '../../../theme/colors.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepositoryApi _repository;

  SettingsCubit({required SettingsRepositoryApi rep})
      : _repository = rep,
        super(SettingsState(
          theme: CustomTheme.darkTheme,
          isLocked: false,
          fontSize: 0,
          alignment: false,
          isCenter: false,
          backgroundImage: '',
        )) {
    _init();
  }

  void _init() async {
    final theme = await _repository.theme
        ? CustomTheme.darkTheme
        : CustomTheme.lightTheme;
    final isLocked = await _repository.isLocked;
    final alignment = await _repository.alignment;
    final centerDate = await _repository.isCenter;
    final fontSize = await _repository.fontSize;
    final backgroundImage = await _repository.backgroundImage;
    emit(state.copyWith(
      theme: theme,
      isLocked: isLocked,
      alignment: alignment,
      isCenter: centerDate,
      fontSize: fontSize,
      backgroundImage: backgroundImage,
    ));
  }

  void changeTheme() {
    if (state.theme == CustomTheme.darkTheme) {
      _repository.setTheme(false);
      emit(state.copyWith(theme: CustomTheme.lightTheme));
    } else {
      _repository.setTheme(true);
      emit(state.copyWith(theme: CustomTheme.darkTheme));
    }
  }

  bool get isDark => state.theme == CustomTheme.darkTheme;

  bool get isLocked => state.isLocked;

  void setIsLocked(bool value) {
    _repository.setIsLocked(value);
    emit(state.copyWith(isLocked: value));
  }

  void changeFontSize(int size) {
    switch (size) {
      case 0:
        _setFontSize(0);
        break;
      case -1:
        _setFontSize(-1);
        break;
      default:
        _setFontSize(1);
        break;
    }
  }

  void _setFontSize(int size) {
    _repository.setFontSize(size);
    emit(state.copyWith(fontSize: size));
  }

  void setBubbleAlignment(bool isRight) {
    _repository.setBubbleAlignment(isRight);
    emit(state.copyWith(alignment: isRight));
  }

  void setCenterDate(bool isCenter) {
    _repository.setCenterDate(isCenter);
    emit(state.copyWith(isCenter: isCenter));
  }

  void setBackgroundImage(String path) {
    _repository.setBackgroundImage(path);
    emit(state.copyWith(backgroundImage: path));
  }

  void setDefault() {
    _repository.setDefault();
    emit(
      state.copyWith(
        isLocked: false,
        theme: CustomTheme.darkTheme,
        fontSize: 0,
        alignment: false,
        isCenter: false,
        backgroundImage: '',
      ),
    );
  }
}
