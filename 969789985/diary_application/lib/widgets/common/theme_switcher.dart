import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../basic/themes/app_theme.dart';
import '../../ui/utils/icons.dart';
import '../../ui/utils/themes.dart';

class ThemeSwitcher extends StatefulWidget {
  ThemeSwitcher({super.key});

  @override
  State<StatefulWidget> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  late IconData _themeChangerIcon;

  @override
  Widget build(BuildContext context) {
    final appTheme = ThemeChanger.of(context).appTheme;

    _themeChangerIcon =
        appTheme.isDarkMode ? Icons.sunny : Icons.nightlight_round_outlined;

    return AnimatedIconButton(
      duration: const Duration(milliseconds: 300),
      onPressed: () {
        appTheme.changeTheme();
        setState(
          () => appTheme.isDarkMode
              ? _themeChangerIcon = Icons.sunny
              : _themeChangerIcon = Icons.nightlight_round_outlined,
        );
        appTheme.isDarkMode
            ? _systemNavigationBarColor(
                const Color(AppColors.primaryDark),
              )
            : _systemNavigationBarColor(
                const Color(AppColors.primaryLight),
              );
      },
      icons: [
        AnimatedIconItem(
          icon: Icon(
            _themeChangerIcon,
            size: IconsSize.standard,
          ),
        ),
      ],
    );
  }

  void _systemNavigationBarColor(Color color) =>
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: color),
      );
}
