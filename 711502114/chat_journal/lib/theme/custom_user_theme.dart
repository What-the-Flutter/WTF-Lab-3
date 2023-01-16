import 'package:flutter/material.dart';

import 'colors.dart';
import 'theme_inherited.dart';

class CustomUserTheme extends StatefulWidget {
  final Widget child;

  const CustomUserTheme({
    super.key,
    required this.child,
  });

  @override
  CustomUserThemeState createState() => CustomUserThemeState();
}

class CustomUserThemeState extends State<CustomUserTheme> {
  ThemeData _themeData = CustomTheme.darkTheme;

  ThemeData get themeData => _themeData;

  void switchTheme() => setState(_setThemeData);

  void _setThemeData() {
    _themeData = _themeData == CustomTheme.darkTheme
        ? CustomTheme.lightTheme
        : CustomTheme.darkTheme;
  }

  @override
  Widget build(BuildContext context) {
    return ThemeInherited(
      themeData: _themeData,
      child: widget.child,
      state: this,
    );
  }
}
