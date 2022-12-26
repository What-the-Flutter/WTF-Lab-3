import 'package:flutter/material.dart';

import 'ui/screens/main_screen.dart';
import 'utils/theme/app_theme.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();

  static _MainAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MainAppState>()!;
}

class _MainAppState extends State<MainApp> {
  ThemeMode _themeMode = ThemeMode.system;
  void changeTheme(ThemeMode themeMode) {
    setState(
      () {
        _themeMode = themeMode;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Journal',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      home: const Menu(),
    );
  }
}
