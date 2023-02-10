import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/animation_duration.dart';
import '../theme.dart';

class AnimatedThemeIcon extends StatefulWidget {
  const AnimatedThemeIcon({
    super.key,
  });

  @override
  State<AnimatedThemeIcon> createState() => _AnimatedThemeIconState();
}

class _AnimatedThemeIconState extends State<AnimatedThemeIcon>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AnimationDuration.large,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ThemeCubit, ThemeState>(
      listener: (context, state) {
        if (state.isDarkMode) {
          _animationController.animateBack(0);
        } else {
          _animationController.animateTo(0.5);
        }
      },
      child: Builder(
        builder: (context) {
          return Lottie.asset(
            'assets/animations/light_dark_mode.json',
            controller: _animationController,
            onLoaded: (_) {
              if (ThemeScope.of(context).state.isDarkMode) {
                _animationController.value = 0;
              } else {
                _animationController.value = 0.5;
              }
            },
          );
        },
      ),
    );
  }
}
