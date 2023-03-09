import 'package:flutter/material.dart';

import 'theme_saver.dart';
import 'themes.dart';

class CustomTheme extends StatefulWidget {
  final Widget child;

  const CustomTheme({
    super.key,
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
  _CustomThemeState createState() => _CustomThemeState();
}

class _CustomThemeState extends State<CustomTheme> {
  final _saver = ThemeSaver();

  var _theme = AppThemes.getThemeFromKey(ThemeKeys.light);
  var _currentKey = ThemeKeys.light;

  ThemeData get theme => _theme;

  void _setNextTheme() {
    switch (_currentKey) {
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

    _saver.save(key);
  }

  @override
  void initState() {
    super.initState();

    _saver.read().then((theme) {
      setState(() {
        _theme = AppThemes.getThemeFromKey(theme);
        _currentKey = theme;
      });
    });
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
