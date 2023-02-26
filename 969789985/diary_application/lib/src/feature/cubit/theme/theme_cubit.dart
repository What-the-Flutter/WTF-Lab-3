import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/domain/api/theme/api_theme_repository.dart';

part 'theme_state.dart';

part 'theme_cubit.freezed.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({
    required ApiThemeRepository repository,
  })  : _repository = repository,
        super(
          ThemeState(
            isDarkMode: repository.isDarkMode,
            messageFontSize: repository.messageFontSize,
            primaryColor: repository.primaryColor,
            primaryItemColor: repository.primaryItemColor,
          ),
        );

  final ApiThemeRepository _repository;

  set isDarkMode(bool value) {
    _repository.setDarkMode(value);
    emit(
      state.copyWith(isDarkMode: value),
    );
  }

  set messageFontSize(double value) {
    _repository.setMessageFontSize(value);
    emit(
      state.copyWith(messageFontSize: value),
    );
  }

  void setColors(int primaryColor, int primaryItemColor) {
    _repository.setColors(primaryColor, primaryItemColor);
    emit(
      state.copyWith(
        primaryColor: primaryColor,
        primaryItemColor: primaryItemColor,
      ),
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
