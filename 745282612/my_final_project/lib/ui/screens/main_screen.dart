import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/ui/widgets/main_screen/cubit/bottom_cubit.dart';
import 'package:my_final_project/ui/widgets/main_screen/cubit/bottom_state.dart';
import 'package:my_final_project/ui/widgets/main_screen/main_screen_appbar.dart';
import 'package:my_final_project/ui/widgets/main_screen/main_screen_body.dart';
import 'package:my_final_project/ui/widgets/main_screen/main_screen_bottom.dart';
import 'package:my_final_project/ui/widgets/main_screen/main_screen_floating_button.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        final indexing = state.index;
        return Scaffold(
          appBar: MainScreenAppBar(index: indexing),
          body: MainScreenBody(index: indexing),
          floatingActionButton: const MainScreenFloatingButton(),
          bottomNavigationBar: MainScreenBottomNavigation(
            index: indexing,
            selected: context.read<MenuCubit>().changeIndex,
          ),
        );
      },
    );
  }
}
