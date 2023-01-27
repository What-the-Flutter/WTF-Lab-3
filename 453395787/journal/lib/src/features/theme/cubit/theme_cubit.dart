import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/utils/default_values.dart';
import '../data/theme_repository_api.dart';

part 'theme_state.dart';

part 'theme_cubit.freezed.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({
    required ThemeRepositoryApi repository,
  })  : _repository = repository,
        super(
          ThemeState(
            color: repository.color,
            isDarkMode: repository.isDarkMode,
          ),
        );

  final ThemeRepositoryApi _repository;

  set color(Color value) {
    _repository.setColor(value);
    emit(
      state.copyWith(color: value),
    );
  }

  set isDarkMode(bool value) {
    _repository.setDarkMode(value);
    emit(
      state.copyWith(isDarkMode: value),
    );
  }

  void toggleDarkMode() {
    _repository.setDarkMode(!state.isDarkMode);
    emit(
      state.copyWith(
        isDarkMode: !state.isDarkMode,
      ),
    );
  }

  Future<void> resetToDefault() async {
    emit(
      ThemeState(
        color: DefaultValues.color,
        isDarkMode: DefaultValues.isDarkMode,
      ),
    );
    await _repository.resetToDefault();
  }
}
