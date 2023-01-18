import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/screens/setting_screen.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';
import 'package:my_final_project/utils/theme/theme_cubit.dart';

class MainScreenDrawer extends StatelessWidget {
  const MainScreenDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = context.watch<ThemeCubit>().isLight();

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: isLight ? AppColors.colorTurquoise : Colors.black,
            ),
            child: Center(
              child: Text(
                S.of(context).account,
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingScreen(),
                ),
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.settings,
                color: isLight ? AppColors.colorTurquoise : Colors.white,
              ),
              title: Text(S.of(context).setting_title),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: isLight ? AppColors.colorTurquoise : Colors.white,
              ),
              title: Text(S.of(context).exit_the_app),
            ),
          ),
        ],
      ),
    );
  }
}
