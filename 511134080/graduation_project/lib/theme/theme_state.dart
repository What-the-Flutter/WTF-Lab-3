part of 'theme_cubit.dart';

class ThemeState {
  final bool _isLight;

  ThemeState({bool isLight = true}) : _isLight = isLight;

  final _lightTheme = ThemeData(
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    colorSchemeSeed: Colors.deepPurple,
    useMaterial3: true,
    hintColor: Colors.grey.shade400,
    highlightColor: Colors.green[100],
    focusColor: Colors.deepPurple.withAlpha(99),
    cardColor: Colors.deepPurple.withAlpha(72),
    primaryColorLight: Colors.deepPurple.shade300,
    primaryColorDark: Colors.deepPurple,
    hoverColor: Colors.deepPurple,
  );

  final _darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.deepPurple.shade700,
    useMaterial3: true,
    focusColor: Colors.deepPurple.withAlpha(99),
    cardColor: Colors.deepPurple.withAlpha(72),
    primaryColorLight: Colors.deepPurple,
    primaryColorDark: Colors.deepPurple.shade300,
    hoverColor: Colors.grey[850],
  );

  ThemeData get theme => _isLight ? _lightTheme : _darkTheme;

  bool get isLight => _isLight;
}
