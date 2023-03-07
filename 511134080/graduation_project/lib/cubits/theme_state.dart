part of 'theme_cubit.dart';

class ThemeState {
  final bool isLight;

  ThemeState({this.isLight = true});

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
  );

  final _darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.deepPurple.shade700,
    useMaterial3: true,
    focusColor: Colors.deepPurple.withAlpha(99),
    cardColor: Colors.deepPurple.withAlpha(72),
    primaryColorLight: Colors.deepPurple,
    primaryColorDark: Colors.deepPurple.shade300,
  );

  ThemeData get theme => isLight ? _lightTheme : _darkTheme;
}
