import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/screens/add_page_screen.dart';
import 'package:my_final_project/ui/widgets/main_screen/cubit/menu_cubit.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';
import 'package:my_final_project/utils/theme/theme_inherited.dart';

class MainScreenDrawer extends StatelessWidget {
  const MainScreenDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = CustomThemeInherited.of(context).isBrightnessLight();

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme ? AppColors.colorTurquoise : Colors.black,
            ),
            child: Center(
              child: Text(
                S.of(context).setting,
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<MenuCubit>().changeAddStatus();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddNewScreen(
                    textController: '',
                  ),
                ),
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.add,
                color: theme ? AppColors.colorTurquoise : Colors.white,
              ),
              title: Text(S.of(context).add_section),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: theme ? AppColors.colorTurquoise : Colors.white,
              ),
              title: Text(S.of(context).exit_the_app),
            ),
          ),
        ],
      ),
    );
  }
}
