import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/util/resources/icons.dart';
import '../../../core/util/resources/themes.dart';
import '../../cubit/theme/theme_cubit.dart';
import '../theme/theme_scope.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedIconButton(
      duration: const Duration(milliseconds: 600),
      onPressed: () {
        ThemeScope.of(context).state.isDarkMode
            ? ThemeScope.of(context).setColors(
                LightPossibleColors.main.colors[0],
                LightPossibleColors.main.colors[1],
              )
            : ThemeScope.of(context).setColors(
                DarkPossibleColors.main.colors[0],
                DarkPossibleColors.main.colors[1],
              );

        ThemeScope.of(context).changeTheme();

        _systemNavigationBarColor(
          Color(ThemeScope.of(context).state.primaryColor),
        );
      },
      icons: [
        AnimatedIconItem(icon: _icon(context)),
      ],
    );
  }

  Icon _icon(BuildContext context) {
    return Icon(
      context.watch<ThemeCubit>().state.isDarkMode
          ? Icons.sunny
          : Icons.dark_mode,
      size: IconsSize.standard,
      color: Theme.of(context).indicatorColor,
    );
  }

  void _systemNavigationBarColor(Color color) =>
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: color),
      );
}
