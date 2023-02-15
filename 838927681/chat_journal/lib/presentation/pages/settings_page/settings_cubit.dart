import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/api_settings_repository.dart';
import '../../../theme/themes.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final ApiSettingsRepository settingsRepository;

  SettingsCubit({required this.settingsRepository})
      : super(
          SettingsState(theme: Themes.lightTheme, isLocked: false),
        ) {
    _init();
  }

  void _init() async {
    final theme =
        await settingsRepository.theme ? Themes.lightTheme : Themes.darkTheme;
    final isLocked = await settingsRepository.isLocked;
    emit(state.copyWith(theme: theme, isLocked: isLocked));
  }

  void changeTheme() {
    if (state.theme == Themes.lightTheme) {
      settingsRepository.setTheme(false);
      emit(state.copyWith(theme: Themes.darkTheme));
    } else {
      settingsRepository.setTheme(true);
      emit(state.copyWith(theme: Themes.lightTheme));
    }
  }

  bool isLight() => state.theme == Themes.lightTheme;

  bool get isLocked => state.isLocked;

  void setIsLocked(bool value) {
    settingsRepository.setIsLocked(value);
    emit(state.copyWith(isLocked: value));
  }
}
