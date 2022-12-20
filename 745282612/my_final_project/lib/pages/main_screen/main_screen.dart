import 'package:flutter/material.dart';

import '../home_screen/home.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selected = 0;
  String _title = 'Home';
  bool _themeStatus = true;
  static const List _listTitle = ['Home', 'Daily', 'Timeline', 'Explore'];
  static const List _widgetOptions = <Widget>[
    Home(),
    Text('page'),
    Text('page'),
    Text('page'),
  ];

  void onSelected(int index) {
    if (index == _selected) return;
    setState(() {
      _selected = index;
      _title = _listTitle[index];
    });
  }

  void onInvertColors() {
    setState(() {
      _themeStatus = !_themeStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: _themeStatus
                ? const Icon(Icons.invert_colors)
                : const Icon(Icons.invert_colors_off),
            onPressed: onInvertColors,
          ),
        ],
      ),
      body: _widgetOptions[_selected],
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(255, 215, 65, 1),
        foregroundColor: Colors.black,
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selected,
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
        onTap: onSelected,
      ),
    );
  }
}
