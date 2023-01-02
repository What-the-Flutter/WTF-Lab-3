import 'package:flutter/material.dart';

import 'preferences.dart';

class AppTheme extends StatefulWidget {
  final Widget child;

  AppTheme({
    super.key,
    required this.child,
  });

  static final colors = <Color>[
    Colors.pink,
    Colors.red,
    Colors.deepOrange,
    Colors.orange,
    Colors.amber,
    Colors.yellow,
    Colors.lime,
    Colors.lightGreen,
    Colors.green,
    Colors.teal,
    Colors.cyan,
    Colors.lightBlue,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.deepPurple,
    Colors.blueGrey,
    Colors.brown,
  ];

  @override
  _AppThemeState createState() => _AppThemeState();
}

class _AppThemeState extends State<AppTheme> {
  bool _isDarkMode = ThemePreferences.get().isDarkMode;
  Color _color = ThemePreferences.get().color;

  bool get isDarkMode => _isDarkMode;
  set isDarkMode(bool value) {
    if (_isDarkMode != value) {
      setState(() => _isDarkMode = value);
      ThemePreferences.get().isDarkMode = value;
    }
  }

  Color get color => _color;
  set color(Color value) {
    if (value != _color) {
      setState(() => _color = value);
      ThemePreferences.get().color = value;
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
