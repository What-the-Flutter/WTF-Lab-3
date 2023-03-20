import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../data/providers/providers.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial(theme:ThemeData.dark()));

  void toggleTheme() {
    if (state.theme == ThemeData.dark()) {
      final updateState = ThemeInitial(theme: ThemeData.light());
      emit(updateState);
    } else if (state.theme == ThemeData.light()) {
      final updateState = ThemeInitial(theme: ThemeData.dark());
      emit(updateState);
    }
  }
}
