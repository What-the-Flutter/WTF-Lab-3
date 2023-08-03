// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:diary_app/themes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _CustomTheme extends InheritedWidget {
  // ignore: overridden_fields, annotate_overrides
  final Widget child;
  final _CustomThemeState data;

  const _CustomTheme({
    required this.child,
    required this.data,
  }) : super(child: child);

  @override
  bool updateShouldNotify(_CustomTheme oldWidget) {
    return true;
  }
}

class CustomTheme extends StatefulWidget {
  final Widget child;
  final MyThemesKeys initialThemeKey;

  const CustomTheme({
    Key? key,
    required this.child,
    required this.initialThemeKey,
  }) : super(key: key);

  @override
  State<CustomTheme> createState() => _CustomThemeState();

  static ThemeData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_CustomTheme>()!.data._theme;
  }

  static void changeTheme(BuildContext context) {
    ThemeData theme = CustomTheme.of(context);
    MyThemesKeys changedTo;

    if (theme == MyThemes.lightTheme) {
      changedTo = MyThemesKeys.dark;
    } else if (theme == MyThemes.darkTheme) {
      changedTo = MyThemesKeys.light;
    } else {
      changedTo = MyThemesKeys.dark;
    }

    context.dependOnInheritedWidgetOfExactType<_CustomTheme>()!.data.changeTheme(changedTo);
  }
}

class _CustomThemeState extends State<CustomTheme> {
  ThemeData _theme = MyThemes.getTheme(MyThemesKeys.light);

  @override
  void initState() {
    super.initState();
    setInitialTheme();
  }

  void setInitialTheme() async {
    var prefs = await SharedPreferences.getInstance();
    var initialTheme = prefs.getString('theme') ?? 'light';

    if (initialTheme == 'light') {
      setState(() => _theme = MyThemes.getTheme(MyThemesKeys.light));
    } else {
      setState(() => _theme = MyThemes.getTheme(MyThemesKeys.dark));
    }
  }

  void changeTheme(MyThemesKeys themesKey) async {
    var prefs = await SharedPreferences.getInstance();

    if (themesKey == MyThemesKeys.light) {
      prefs.setString('theme', 'light');
    } else {
      prefs.setString('theme', 'dark');
    }

    setState(() {
      _theme = MyThemes.getTheme(themesKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _CustomTheme(
      data: this,
      child: widget.child,
    );
  }
}
