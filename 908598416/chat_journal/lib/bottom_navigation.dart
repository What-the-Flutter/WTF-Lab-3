import 'package:flutter/material.dart';

import 'chats_page.dart';

class BottomNavigation extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _BottomNavigationState();
}

class TabChanged extends Notification {
  Widget val = _BottomNavigationState().getWidgetOptions().elementAt(0);
  TabChanged(this.val);
}

class _BottomNavigationState extends State<BottomNavigation> {

  int _selectedIndex = 0;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
    TabChanged(_widgetOptions.elementAt(_selectedIndex)).dispatch(context);
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> get _widgetOptions => <Widget>[
    ChatsPage(),
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
      selectedItemColor: Colors.amber[800],
      unselectedItemColor: Colors.white,
      onTap: _onItemTapped,
    );
  }
}
