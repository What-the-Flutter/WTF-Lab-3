import 'package:flutter/material.dart';

import 'package:my_final_project/generated/l10n.dart';

class MainScreenBottomNavigation extends StatelessWidget {
  final int index;
  final Function(int) selected;

  const MainScreenBottomNavigation({
    super.key,
    required this.index,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: index,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.class_),
          label: S.of(context).home_label,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.assessment),
          label: S.of(context).daily_label,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.map),
          label: S.of(context).timeline_label,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.explore),
          label: S.of(context).explore_label,
        ),
      ],
      onTap: selected,
    );
  }
}
