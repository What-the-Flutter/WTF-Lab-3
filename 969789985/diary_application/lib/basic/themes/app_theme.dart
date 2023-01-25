import 'package:flutter/material.dart';

import 'preferences.dart';

class AppTheme extends StatefulWidget {
  final Widget child;

  AppTheme({
    super.key,
    required this.child,
  });

  @override
  State<StatefulWidget> createState() => _AppThemeState();
}

class _AppThemeState extends State<AppTheme> {
  bool _isDarkMode = ThemePreferences.get().isDarkMode;

  bool get isDarkMode => _isDarkMode;

  set isDarkMode(bool value) {
    if (_isDarkMode != value) {
      setState(() => _isDarkMode = value);
      ThemePreferences.get().isDarkMode = value;
    }
  }

  void changeTheme() => isDarkMode = !isDarkMode;

  @override
  Widget build(BuildContext context) => ThemeChanger(
        child: widget.child,
        appTheme: this,
      );
}

class ThemeChanger extends InheritedWidget {
  final _AppThemeState appTheme;

  ThemeChanger({
    super.key,
    required super.child,
    required this.appTheme,
  });

  static ThemeChanger of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ThemeChanger>()!;

  static ThemeChanger? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ThemeChanger>();

  @override
  bool updateShouldNotify(ThemeChanger oldWidget) =>
      appTheme.isDarkMode == oldWidget.appTheme.isDarkMode;
}
