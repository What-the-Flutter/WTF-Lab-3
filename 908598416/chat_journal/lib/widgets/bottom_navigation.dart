import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class BottomNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> get _widgetOptions => <Widget>[
    const Text(
      'Home',
      style: optionStyle,
    ),
    const Text(
      'Daily',
      style: optionStyle,
    ),
    const Text(
      'Timeline',
      style: optionStyle,
    ),
    const Text(
      'Explore',
      style: optionStyle,
    ),
  ];

  List<Widget> getWidgetOptions() {
    return _widgetOptions;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.task),
          label: 'Daily',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Timeline',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.compass_calibration),
          label: 'Explore',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: ColorConstants.primaryColor,
      unselectedItemColor: ColorConstants.themeColor,
      onTap: _onItemTapped,
    );
  }
}
