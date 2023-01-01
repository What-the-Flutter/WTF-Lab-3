import 'package:flutter/material.dart';

import 'daily/daily_page.dart';
import 'explore/explore_page.dart';
import 'home/home_page.dart';
import 'timeline/timeline_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _pageIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    DailyPage(),
    TimelinePage(),
    ExplorePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_pageIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Daily'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Timeline'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
        ],
        currentIndex: _pageIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
