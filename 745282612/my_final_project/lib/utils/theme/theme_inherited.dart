import 'package:flutter/material.dart';

import 'package:my_final_project/utils/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomThemeInherited extends InheritedWidget {
  final ThemeData themeData;
  final CustomThemeState state;

  CustomThemeInherited({
    super.key,
    required super.child,
    required this.themeData,
    required this.state,
  });

  static CustomThemeState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CustomThemeInherited>()!.state;

  @override
  bool updateShouldNotify(CustomThemeInherited oldWidget) => true;
}

class CustomTheme extends StatefulWidget {
  final Widget child;

  const CustomTheme({
    super.key,
    required this.child,
  });

  @override
  CustomThemeState createState() => CustomThemeState();
}

class CustomThemeState extends State<CustomTheme> {
  ThemeData themeData = AppTheme.lightTheme;
  late SharedPreferences _prefs;
  late String themeKey;

  @override
  void initState() {
    super.initState();
    _initTheme();
  }

  void _initTheme() async {
    _prefs = await SharedPreferences.getInstance();
    themeKey = _prefs.getString('theme') ?? ThemeGlobalKey.light.toString();
    setState(
      () {
        if (themeKey == ThemeGlobalKey.light.toString()) {
          themeData = AppTheme.lightTheme;
        } else {
          themeData = AppTheme.darkTheme;
        }
      },
    );
  }

  void changeTheme() async {
    _prefs = await SharedPreferences.getInstance();
    setState(
      () {
        if (themeData == AppTheme.lightTheme) {
          themeData = AppTheme.darkTheme;
          _prefs.setString('theme', ThemeGlobalKey.dark.toString());
        } else {
          themeData = AppTheme.lightTheme;
          _prefs.setString('theme', ThemeGlobalKey.light.toString());
        }
      },
    );
  }

  bool isBrightnessLight() => themeData == AppTheme.lightTheme;

  @override
  Widget build(BuildContext context) {
    return CustomThemeInherited(
      themeData: themeData,
      child: widget.child,
      state: this,
    );
  }
}
