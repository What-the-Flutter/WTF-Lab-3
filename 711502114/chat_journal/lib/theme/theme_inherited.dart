import 'package:flutter/material.dart';

import 'custom_user_theme.dart';

class ThemeInherited extends InheritedWidget {
  final ThemeData themeData;
  final CustomUserThemeState state;

  ThemeInherited({
    super.key,
    required super.child,
    required this.themeData,
    required this.state,
  });

  static CustomUserThemeState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ThemeInherited>()!.state;

  @override
  bool updateShouldNotify(ThemeInherited oldWidget) => true;
}
