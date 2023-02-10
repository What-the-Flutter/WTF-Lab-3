part of 'theme_cubit.dart';

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState({
    required Color color,
    required bool isDarkMode,
  }) = _ThemeState;
}
