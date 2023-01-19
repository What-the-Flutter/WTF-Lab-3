import 'package:flutter/material.dart';

class ThemeButton extends StatefulWidget {
  const ThemeButton({super.key});

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton> {
  bool _isDark = false;

  void _onThemeIconTap() {
    setState(() {
      _isDark = !_isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    var iconData = _isDark ? Icons.light_mode : Icons.dark_mode;
    return IconButton(
      icon: Icon(iconData),
      onPressed: _onThemeIconTap,
    );
  }
}
