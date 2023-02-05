import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/ui/widgets/main_screen/cubit/menu_cubit.dart';
import 'package:my_final_project/ui/widgets/main_screen/cubit/menu_state.dart';
import 'package:my_final_project/ui/widgets/main_screen/main_screen_appbar.dart';
import 'package:my_final_project/ui/widgets/main_screen/main_screen_body.dart';
import 'package:my_final_project/ui/widgets/main_screen/main_screen_bottom.dart';
import 'package:my_final_project/ui/widgets/main_screen/main_screen_drawer.dart';
import 'package:my_final_project/ui/widgets/main_screen/main_screen_floating_button.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        final changeIndex = context.read<MenuCubit>().changeIndex;
        return Scaffold(
          appBar: MainScreenAppBar(index: state.index),
          body: MainScreenBody(index: state.index),
          drawer: const MainScreenDrawer(),
          floatingActionButton: MainScreenFloatingButton(menuStatus: state.menuStatus),
          bottomNavigationBar: MainScreenBottomNavigation(
            index: state.index,
            selected: changeIndex,
          ),
        );
      },
    );
  }
}
