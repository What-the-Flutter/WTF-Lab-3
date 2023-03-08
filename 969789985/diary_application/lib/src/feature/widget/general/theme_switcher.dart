import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../core/util/resources/dimensions.dart';
import '../../../core/util/resources/themes.dart';
import '../../cubit/theme/theme_cubit.dart';
import '../theme/theme_scope.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher>
    with SingleTickerProviderStateMixin {
  late final AnimationController _lottieController;

  @override
  void initState() {
    _lottieController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    super.initState();
  }

  @override
  void dispose() {
    _lottieController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return IconButton(
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

            if (ThemeScope.of(context).state.isDarkMode) {
              _lottieController.animateTo(1.0);
            } else {
              _lottieController.animateTo(0.0);
            }
          },
          icon: Lottie.asset(
            'assets/day_night_mode.json',
            controller: _lottieController,
            repeat: false,
            onLoaded: (composition) {
              ThemeScope.of(context).state.isDarkMode
                  ? _lottieController.value = 1.0
                  : _lottieController.value = 0.0;
            },
            width: 24.0,
            height: 24.0,
          ),
        );
      },
    );
  }

  void _systemNavigationBarColor(Color color) =>
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: color),
      );
}
