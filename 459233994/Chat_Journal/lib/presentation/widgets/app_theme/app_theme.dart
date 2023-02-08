import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'inherited_app_theme.dart';
import 'theme.dart';
import 'theme_notifier.dart';

class AppTheme extends StatefulWidget {
  final Widget child;
  late final CustomTheme? _theme;

  AppTheme({required this.child, theme}) {
    if (theme != null) {
      _theme = theme;
    } else {
      _theme = null;
    }
  }

  @override
  State<AppTheme> createState() => _AppThemeState(theme: _theme);
}

class _AppThemeState extends State<AppTheme> {
  ThemeNotifier _theme = ThemeNotifier();
  final List<CustomTheme> _themes = [];

  _AppThemeState({theme}) {
    _themes.add(
      CustomTheme(
        name: 'default',
        themeColor: const Color(0xffB1CC74),
        auxiliaryColor: const Color(0xffE8FCC2),
        keyColor: const Color(0xffffffff),
        backgroundColor: const Color(0xffffffff),
        textColor: const Color(0xff545F66),
        iconColor: const Color(0xff829399),
        actionColor: const Color(0xffD0F4EA),
      ),
    );
    _themes.add(
      CustomTheme(
        name: 'black',
        themeColor: const Color(0xff000000),
        auxiliaryColor: const Color(0xff7F8487),
        keyColor: const Color(0xffffffff),
        backgroundColor: const Color(0xff0F0E0E),
        textColor: const Color(0xffffffff),
        iconColor: const Color(0xffffffff),
        actionColor: const Color(0xff1E5128),
      ),
    );
    if (theme != null) {
      _theme.update(theme);
    } else {
      _theme.update(_themes[0]);
    }
  }

  void _changeColor() {
    setState(() {
      if (_themes.indexOf(_theme.theme) != _themes.length - 1) {
        _theme.update(_themes[_themes.indexOf(_theme.theme) + 1]);
      } else {
        _theme.update(_themes[0]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: InheritedAppTheme(
        theme: _theme,
        changeTheme: _changeColor,
        child: widget.child,
      ),
    );
  }
}
