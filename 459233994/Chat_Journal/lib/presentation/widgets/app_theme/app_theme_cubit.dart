import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/shared_preferences_repository.dart';
import 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  final SharedPreferencesRepository _sharedPreferencesRepository;

  AppThemeCubit({required sharedPreferencesRepository})
      : _sharedPreferencesRepository = sharedPreferencesRepository,
        super(AppThemeState(theme: Themes.light)) {
    loadTheme();
  }

  void loadTheme() async {
    final theme = await _sharedPreferencesRepository.loadThemePreferences()
        ? Themes.light
        : Themes.dark;
    emit(
      await AppThemeState(theme: theme),
    );
  }

  void changeTheme() {
    final theme = state.theme == Themes.light ? Themes.dark : Themes.light;
    state.theme == Themes.light
        ? _sharedPreferencesRepository.updateTheme(false)
        : _sharedPreferencesRepository.updateTheme(true);
    emit(
      AppThemeState(theme: theme),
    );
  }
}
