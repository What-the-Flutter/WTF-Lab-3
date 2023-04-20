import 'package:flutter/material.dart';

import 'theme.dart';

class InheritedAppTheme extends InheritedWidget {
  final CustomTheme themeData;

  InheritedAppTheme({
    required this.themeData,
    required Widget child,
  }) : super(child: child);

  static InheritedAppTheme? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedAppTheme>();
  }

  @override
  bool updateShouldNotify(InheritedAppTheme oldWidget) {
    return themeData != oldWidget.themeData;
  }
}
