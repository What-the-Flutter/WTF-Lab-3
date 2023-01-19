import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/ui/widgets/main_screen/cubit/menu_cubit.dart';
import 'package:my_final_project/ui/widgets/main_screen/cubit/menu_state.dart';
import 'package:my_final_project/ui/widgets/main_screen/main_screen_appbar.dart';
import 'package:my_final_project/ui/widgets/main_screen/main_screen_body.dart';
import 'package:my_final_project/ui/widgets/main_screen/main_screen_bottom.dart';
import 'package:my_final_project/ui/widgets/main_screen/main_screen_drawer.dart';
import 'package:my_final_project/ui/widgets/main_screen/main_screen_floating_button.dart';
import 'package:my_final_project/utils/theme/theme_cubit.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ThemeCubit>(context).initializer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        final changeIndex = context.read<MenuCubit>().changeIndex;
        return Scaffold(
          appBar: MainScreenAppBar(index: state.index),
          body: MainScreenBody(index: state.index),
          drawer: const MainScreenDrawer(),
          floatingActionButton: const MainScreenFloatingButton(),
          bottomNavigationBar: MainScreenBottomNavigation(
            index: state.index,
            selected: changeIndex,
          ),
        );
      },
    );
  }
}
