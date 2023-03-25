part of 'settings_cubit.dart';

class SettingsState {
  final bool isLight;
  final AppTheme theme;

  SettingsState({this.isLight = true}) : theme = AppTheme();

  ThemeData get currentTheme => isLight ? theme.lightTheme : theme.darkTheme;

  SettingsState copyWith({bool? light}) => SettingsState(
        isLight: light ?? isLight,
      );
}
