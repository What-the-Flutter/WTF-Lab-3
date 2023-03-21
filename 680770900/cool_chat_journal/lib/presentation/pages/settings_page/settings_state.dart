part of 'settings_cubit.dart';

extension ThemeKeyX on ThemeKey {
  ThemeData get themeData => this == ThemeKey.light ? lightTheme : darkTheme;

  static final lightTheme = FlexThemeData.light(
    useMaterial3: true,
    surface: const Color(0xffff7373),
    scheme: FlexScheme.mandyRed,
  );

  static final darkTheme = FlexThemeData.dark(
    useMaterial3: true,
    scheme: FlexScheme.mandyRed,
  );
}

class SettingsState extends Equatable {
  final bool isInit;
  final ThemeKey themeKey;
  final ThemeData themeData;

  const SettingsState({
    this.isInit = false,
    this.themeKey = ThemeKey.light,
    required this.themeData,
  });

  SettingsState copyWith({
    bool? isInit,
    ThemeKey? themeKey,
    ThemeData? themeData,
  }) =>
      SettingsState(
        isInit: isInit ?? this.isInit,
        themeKey: themeKey ?? this.themeKey,
        themeData: themeData ?? this.themeData,
      );

  @override
  List<Object> get props => [themeKey, themeData, isInit];
}
