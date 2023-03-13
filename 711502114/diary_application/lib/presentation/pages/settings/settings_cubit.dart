import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repository/settings_repository_api.dart';
import '../../../theme/colors.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepositoryApi _repository;

  SettingsCubit({required SettingsRepositoryApi rep})
      : _repository = rep,
        super(SettingsState(theme: ThemeData.dark(), isLocked: false)) {
    _init();
  }

  void _init() async {
    final theme = await _repository.theme
        ? CustomTheme.darkTheme
        : CustomTheme.lightTheme;
    final isLocked = await _repository.isLocked;
    emit(state.copyWith(
      theme: theme,
      isLocked: isLocked,
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
}
