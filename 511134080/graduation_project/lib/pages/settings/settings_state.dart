part of 'settings_cubit.dart';

class SettingsState {
  final bool isLight;
  final int fontSize;
  final bool isRightToLeft;
  final bool isCenterDate;
  final String backgroundImage;
  final bool isLoaded;
  final bool useFingerprint;

  SettingsState({
    this.isLight = true,
    this.fontSize = 0,
    this.isRightToLeft = false,
    this.isCenterDate = false,
    this.backgroundImage = '',
    this.isLoaded = false,
    this.useFingerprint = false,
  });

  ThemeData get currentTheme => isLight
      ? AppTheme.lightTheme.copyWith(
          textTheme: currentTextTheme,
        )
      : AppTheme.darkTheme.copyWith(
          textTheme: currentTextTheme,
        );

  TextTheme get currentTextTheme {
    if (fontSize == 0) {
      return AppTheme.defaultTextTheme;
    } else if (fontSize == -1) {
      return AppTheme.smallTextTheme;
    } else if (fontSize == 1) {
      return AppTheme.largeTextTheme;
    } else {
      throw Exception('Undefined font size!!!');
    }
  }

  SettingsState copyWith({
    bool? light,
    int? newFontSize,
    bool? rightToLeft,
    bool? centerDate,
    String? newBackgroundImage,
    bool? loaded,
    bool? useFingerprint,
  }) =>
      SettingsState(
        isLight: light ?? isLight,
        fontSize: newFontSize ?? fontSize,
        isRightToLeft: rightToLeft ?? isRightToLeft,
        isCenterDate: centerDate ?? isCenterDate,
        backgroundImage: newBackgroundImage ?? backgroundImage,
        isLoaded: loaded ?? isLoaded,
        useFingerprint: useFingerprint ?? this.useFingerprint,
      );
}
