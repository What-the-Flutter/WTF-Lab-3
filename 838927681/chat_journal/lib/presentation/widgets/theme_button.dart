import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/settings_page/settings_cubit.dart';

class ThemeButton extends StatefulWidget {
  const ThemeButton({super.key});

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = context.watch<SettingsCubit>().state.isLightTheme;
    var iconData = isLight ? Icons.light_mode : Icons.dark_mode;
    return IconButton(
      icon: ThemeButtonAnimation(
        child: Icon(iconData),
        controller: _controller,
      ),
      onPressed: () {
        setState(
          () {
            if (_controller.isCompleted) {
              _controller.reverse();
            } else {
              _controller.forward();
            }
            BlocProvider.of<SettingsCubit>(context).changeTheme();
          },
        );
      },
    );
  }
}

class ThemeButtonAnimation extends AnimatedWidget {
  final Widget _child;

  const ThemeButtonAnimation({
    required Widget child,
    required AnimationController controller,
  })  : _child = child,
        super(listenable: controller);

  Animation<double> get _progress => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _progress.value * 2 * 3.14,
      child: _child,
    );
  }
}
