import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';

import '../interfaces/theme_repository_interface.dart';
import '../themes/themes.dart';

part 'theme_state.dart';

part 'theme_cubit.freezed.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({
    required ThemeRepositoryInterface repository,
  })  : _repository = repository,
        super(
          ThemeState(
            isDarkMode: repository.isDarkMode,
          ),
        );

  final ThemeRepositoryInterface _repository;

  set isDarkMode(bool value) {
    _repository.setDarkMode(value);
    emit(
      state.copyWith(isDarkMode: value),
    );
  }

  void changeTheme() {
    _repository.setDarkMode(!state.isDarkMode);
    emit(
      state.copyWith(
        isDarkMode: !state.isDarkMode,
      ),
    );
  }
}
