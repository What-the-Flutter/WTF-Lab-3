import 'package:flutter/material.dart';

import 'themes.dart';

class CustomTheme extends StatefulWidget {
  final Widget child;
  final ThemeKeys initalThemeKey;

  const CustomTheme({
    super.key,
    this.initalThemeKey = ThemeKeys.light,
    required this.child,
  });

  static ThemeData of(BuildContext context) {
    final inherited =
        context.dependOnInheritedWidgetOfExactType<_CustomThemeInherited>();
    assert(inherited != null, 'Error');
    return inherited!.themeState.theme;
  }

  static _CustomThemeState instanceOf(BuildContext context) {
    final inherited =
        context.dependOnInheritedWidgetOfExactType<_CustomThemeInherited>();
    assert(inherited != null, 'Error');
    return inherited!.themeState;
  }

  @override
  _CustomThemeState createState() => _CustomThemeState(initalThemeKey);
}

class _CustomThemeState extends State<CustomTheme> {
  late ThemeData _theme;
  late ThemeKeys _currentKey;

  ThemeData get theme => _theme;

  _CustomThemeState(ThemeKeys initalThemeKey) {
    _theme = AppThemes.getThemeFromKey(initalThemeKey);
    _currentKey = initalThemeKey;
  } 

  void _setNextTheme() {
    switch(_currentKey) {
      case ThemeKeys.light:
        _currentKey = ThemeKeys.dark;
        break;
      case ThemeKeys.dark:
        _currentKey = ThemeKeys.light;
        break;
      default:
        _currentKey = ThemeKeys.light;
    }
  }

  void chooseNextTheme() {
    _setNextTheme();
    changeTheme(_currentKey);
  }

  void changeTheme(ThemeKeys key) {
    setState(() {
      _theme = AppThemes.getThemeFromKey(key);
      _currentKey = key;
    });
  }

  @override
  void initState() {
    super.initState();
    _theme = AppThemes.getThemeFromKey(widget.initalThemeKey);
    _currentKey = widget.initalThemeKey;
  }

  @override
  Widget build(BuildContext context) {
    return _CustomThemeInherited(
      child: widget.child,
      themeState: this,
    );
  }
}

class _CustomThemeInherited extends InheritedWidget {
  final _CustomThemeState themeState;

  _CustomThemeInherited({
    super.key,
    required super.child,
    required this.themeState,
  });

  @override
  bool updateShouldNotify(_CustomThemeInherited oldTheme) => true;
}