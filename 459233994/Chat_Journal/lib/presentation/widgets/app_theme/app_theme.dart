import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'inherited_app_theme.dart';
import 'theme.dart';
import 'theme_notifier.dart';

class AppTheme extends StatefulWidget {
  final Widget child;
  late final CustomTheme? _theme;

  AppTheme({required this.child, theme}) {
    _theme = (theme != null) ? theme : null;
  }

  @override
  State<AppTheme> createState() => _AppThemeState(theme: _theme);
}

class _AppThemeState extends State<AppTheme> {
  final ThemeNotifier _theme = ThemeNotifier();

  _AppThemeState({theme}) {
    loadTheme();
    if (theme != null) {
      _theme.update(theme);
    }
  }

  void loadTheme() async {
    await _theme.loadPreferences();
    setState(() {
      if(!_theme.isDefaultTheme){_theme.getStartTheme(CustomTheme(
        name: 'black',
        themeColor: const Color(0xff000000),
        auxiliaryColor: const Color(0xff7F8487),
        keyColor: const Color(0xffffffff),
        backgroundColor: const Color(0xff0F0E0E),
        textColor: const Color(0xffffffff),
        iconColor: const Color(0xffffffff),
        actionColor: const Color(0xff1E5128),
      ));}
    });

  }

  void _changeTheme() {
    setState(
      () {
        var theme = (_theme.theme.name == 'default')
            ? CustomTheme(
                name: 'black',
                themeColor: const Color(0xff000000),
                auxiliaryColor: const Color(0xff7F8487),
                keyColor: const Color(0xffffffff),
                backgroundColor: const Color(0xff0F0E0E),
                textColor: const Color(0xffffffff),
                iconColor: const Color(0xffffffff),
                actionColor: const Color(0xff1E5128),
              )
            : CustomTheme(
                name: 'default',
                themeColor: const Color(0xffB1CC74),
                auxiliaryColor: const Color(0xffE8FCC2),
                keyColor: const Color(0xffffffff),
                backgroundColor: const Color(0xffffffff),
                textColor: const Color(0xff545F66),
                iconColor: const Color(0xff829399),
                actionColor: const Color(0xffD0F4EA),
              );
        print(theme.name);

        _theme.update(theme);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeNotifier>(
      create: (context) => ThemeNotifier(),
      child: InheritedAppTheme(
        theme: _theme,
        changeTheme: _changeTheme,
        child: widget.child,
      ),
    );
  }
}
