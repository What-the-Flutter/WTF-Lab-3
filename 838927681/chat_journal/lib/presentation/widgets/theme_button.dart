import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../theme/theme_cubit.dart';

class ThemeButton extends StatefulWidget {
  const ThemeButton({super.key});

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton> {
  @override
  Widget build(BuildContext context) {
    final isLight = BlocProvider.of<ThemeCubit>(context).isLight();
    var iconData = isLight ? Icons.light_mode : Icons.dark_mode;
    return IconButton(
      icon: Icon(iconData),
      onPressed: () {
        setState(() {
          BlocProvider.of<ThemeCubit>(context).changeTheme();
        });
      },
    );
  }
}
