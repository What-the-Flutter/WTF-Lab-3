import 'package:flutter/material.dart';

class AppTheme extends StatefulWidget {
  final Widget child;

  AppTheme({
    super.key,
    required this.child,
  });

  @override
  _AppThemeState createState() => _AppThemeState();
}

class _AppThemeState extends State<AppTheme> {
  bool _isDarkMode = false;
  Color _color = Colors.red;

  bool get isDarkMode => _isDarkMode;
  set isDarkMode(bool value) {
    if (_isDarkMode != value) {
      setState(() => _isDarkMode = value);
    }
  }

  Color get color => _color;
  set color(Color value) {
    if (value != _color) {
      setState(() => _color = value);
    }
  }

  void toggleThemeMode() => isDarkMode = !isDarkMode;

  @override
  Widget build(BuildContext context) {
    return ThemeChanger(
      child: widget.child,
      appTheme: this,
    );
  }
}

class ThemeChanger extends InheritedWidget {
  final _AppThemeState appTheme;

  ThemeChanger({
    super.key,
    required super.child,
    required this.appTheme,
  });

  static ThemeChanger of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeChanger>()!;
  }

  static ThemeChanger? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeChanger>();
  }

  @override
  bool updateShouldNotify(ThemeChanger oldWidget) {
    return appTheme.isDarkMode == oldWidget.appTheme.isDarkMode &&
        appTheme.color == oldWidget.appTheme.color;
  }
}
