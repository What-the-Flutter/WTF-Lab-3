import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/settings_page/settings_cubit.dart';

class ThemeButton extends StatefulWidget {
  const ThemeButton({super.key});

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton> {
  @override
  Widget build(BuildContext context) {
    final isLight = BlocProvider.of<SettingsCubit>(context).isLight();
    var iconData = isLight ? Icons.light_mode : Icons.dark_mode;
    return IconButton(
      icon: Icon(iconData),
      onPressed: () {
        setState(() {
          BlocProvider.of<SettingsCubit>(context).changeTheme();
        });
      },
    );
  }
}
