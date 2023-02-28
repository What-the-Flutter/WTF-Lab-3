import 'package:flutter_bloc/flutter_bloc.dart';

import 'colors.dart';
import 'theme_preferences.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final ThemePreferences provider;

  ThemeCubit(this.provider) : super(ThemeState(CustomTheme.darkTheme)) {
    _initTheme();
  }

  void _initTheme() async {
    emit(state.copyWith(await provider.theme));
  }

  void switchTheme() {
    if (state.theme == CustomTheme.darkTheme) {
      provider.switchTheme(CustomTheme.lightTheme);
      emit(state.copyWith(CustomTheme.lightTheme));
    } else {
      provider.switchTheme(CustomTheme.darkTheme);
      emit(state.copyWith(CustomTheme.darkTheme));
    }
  }

  bool get isDark => state.theme == CustomTheme.darkTheme;
}
