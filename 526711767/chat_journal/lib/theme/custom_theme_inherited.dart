import 'package:flutter/material.dart';

class CustomThemeInherited extends InheritedWidget {
  final ThemeData mode;

  const CustomThemeInherited({
    Key? key,
    required this.mode,
    required Widget child,
  }) : super(key: key, child: child);

  static CustomThemeInherited of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<CustomThemeInherited>();
    assert(result != null, 'No CustomTheme found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(CustomThemeInherited oldWidget) {
    return mode != oldWidget.mode;
  }
}
