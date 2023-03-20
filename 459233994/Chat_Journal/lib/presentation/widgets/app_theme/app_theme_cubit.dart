import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit({required sharedPreferencesService})
      : super(AppThemeState(
          sharedPreferencesService: sharedPreferencesService,
        )) {
    loadTheme();
  }

  void loadTheme() async {
    emit(await state.loadTheme());
  }

  void changeTheme() {
    emit(state.changeTheme());
  }
}
