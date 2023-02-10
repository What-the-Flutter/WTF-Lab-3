import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/provider/theme_provider.dart';
import 'theme_state.dart';
import 'themes.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final ThemeProvider themeProvider;

  ThemeCubit({required this.themeProvider})
      : super(ThemeState(theme: Themes.lightTheme)) {
    initState();
  }

  void initState() async {
    emit(state.copyWith(theme: await themeProvider.theme));
  }

  void changeTheme() {
    if (state.theme == Themes.lightTheme) {
      themeProvider.setTheme(Themes.darkTheme);
      emit(state.copyWith(theme: Themes.darkTheme));
    } else {
      themeProvider.setTheme(Themes.lightTheme);
      emit(state.copyWith(theme: Themes.lightTheme));
    }
  }

  bool isLight() => state.theme == Themes.lightTheme;
}
