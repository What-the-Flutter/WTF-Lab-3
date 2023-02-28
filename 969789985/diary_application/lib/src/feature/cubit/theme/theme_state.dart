part of 'theme_cubit.dart';

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState({
    required bool isDarkMode,
    required double messageFontSize,
    required double messageBorderRadius,
    required int primaryColor,
    required int primaryItemColor,
    required String messageAlignment,
    required bool dateBubbleVisible,
    required int chatBackgroundColor,
    required String imagePath,
    required File? image,
  }) = _ThemeState;
}
