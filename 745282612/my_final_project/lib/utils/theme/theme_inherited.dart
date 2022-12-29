import 'package:flutter/material.dart';
import 'package:my_final_project/utils/theme/app_theme.dart';

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

  void changeTheme() {
    setState(
      () {
        if (themeData == AppTheme.lightTheme) {
          themeData = AppTheme.darkTheme;
        } else {
          themeData = AppTheme.lightTheme;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomThemeInherited(
      themeData: themeData,
      child: widget.child,
      state: this,
    );
  }
}
