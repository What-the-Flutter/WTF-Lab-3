import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../themes/cubit/theme_cubit.dart';
import '../themes/themes/themes.dart';
import '../themes/widget/theme_scope.dart';
import '../values/icons.dart';

class ThemeSwitcher extends StatelessWidget {
  ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedIconButton(
      duration: const Duration(milliseconds: 500),
      onPressed: () {
        ThemeScope.of(context).changeTheme();
        context.read<ThemeCubit>().state.isDarkMode
            ? _systemNavigationBarColor(
                const Color(AppColors.primaryDark),
              )
            : _systemNavigationBarColor(
                const Color(AppColors.primaryLight),
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
