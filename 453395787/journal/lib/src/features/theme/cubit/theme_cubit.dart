import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../data/theme_repository_api.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({
    required ThemeRepositoryApi repository,
  })  : _repository = repository,
        super(const ThemeState(color: Colors.grey, isDarkMode: true));

  final ThemeRepositoryApi _repository;

  set color(Color value) {
    _repository.setColor(value);
    emit(state.copyWith(color: value));
  }

  set isDarkMode(bool value) {
    _repository.setDarkMode(value);
    emit(state.copyWith(isDarkMode: value));
  }

  void toggleDarkMode() {
    _repository.setDarkMode(!state.isDarkMode);
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
  }
}
