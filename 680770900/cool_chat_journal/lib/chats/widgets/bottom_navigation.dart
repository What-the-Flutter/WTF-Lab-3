import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final labelSize = Theme.of(context).textTheme.bodyMedium?.fontSize ?? 12.0;

    return BottomNavigationBar(
      currentIndex: _currentIndex,
      unselectedFontSize: labelSize,
      selectedFontSize: labelSize + 2.0,
      onTap: (value) {
        setState(() {
          _currentIndex = value;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          label: 'Daily',
        ),
      ],
    );
  }
}
