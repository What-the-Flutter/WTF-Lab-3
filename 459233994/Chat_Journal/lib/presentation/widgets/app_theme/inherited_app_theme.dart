import 'package:flutter/material.dart';

import 'theme.dart';
import 'theme_notifier.dart';

class InheritedAppTheme extends InheritedWidget {
  final ThemeNotifier theme;
  final Function changeTheme;
  @override
  final Widget child;

  InheritedAppTheme({
    required this.theme,
    required this.changeTheme,
    required this.child,
  }) : super(child: child);

  CustomTheme get getTheme => theme.theme;

  static InheritedAppTheme? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedAppTheme>();
  }

  @override
  bool updateShouldNotify(covariant InheritedAppTheme oldWidget) {
    return theme != oldWidget.theme;
  }
}
