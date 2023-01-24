import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_state.dart';
import 'themes.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(theme: Themes.lightTheme));

  void changeTheme() {
    if (state.theme == Themes.lightTheme) {
      emit(state.copyWith(theme: Themes.darkTheme));
    } else {
      emit(state.copyWith(theme: Themes.lightTheme));
    }
  }

  bool isLight() => state.theme == Themes.lightTheme;
}
