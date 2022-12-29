import 'package:flutter/material.dart';

import 'package:my_final_project/ui/widgets/main_screen/main_screen_appbar.dart';
import 'package:my_final_project/ui/widgets/main_screen/main_screen_body.dart';
import 'package:my_final_project/ui/widgets/main_screen/main_screen_bottom.dart';
import 'package:my_final_project/ui/widgets/main_screen/main_screen_floating_button.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selected = 0;

  void onSelected(int index) {
    if (index == _selected) return;
    setState(
      () => _selected = index,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainScreenAppBar(index: _selected),
      body: MainScreenBody(index: _selected),
      floatingActionButton: const MainScreenFloatingButton(),
      bottomNavigationBar: MainScreenBottomNavigation(
        index: _selected,
        selected: onSelected,
      ),
    );
  }
}
