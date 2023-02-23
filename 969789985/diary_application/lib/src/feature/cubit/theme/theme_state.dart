part of 'theme_cubit.dart';

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState({
    required bool isDarkMode,
    required double messageFontSize,
    required int primaryColor,
    required int primaryItemColor,
  }) = _ThemeState;
}
