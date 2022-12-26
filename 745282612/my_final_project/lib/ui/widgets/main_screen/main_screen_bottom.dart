import 'package:flutter/material.dart';

class MainScreenBottomNavigation extends StatelessWidget {
  const MainScreenBottomNavigation({
    super.key,
    required this.index,
    required this.selected,
  });
  final int index;
  final Function(int) selected;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: index,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.class_),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assessment),
          label: 'Daily',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Timeline',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Explore',
        ),
      ],
      onTap: selected,
    );
  }
}
