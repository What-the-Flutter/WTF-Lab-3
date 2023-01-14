import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'daily_page.dart';
import 'explore_page.dart';
import 'home_page.dart';
import 'timeline_page.dart';

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
    final local = AppLocalizations.of(context);
    return Scaffold(
      body: Center(
        child: _pages[_pageIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.book),
            label: local?.homePage,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.assignment),
            label: local?.dailyPage,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.map),
            label: local?.timelinePage,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.explore),
            label: local?.explorePage,
          ),
        ],
        currentIndex: _pageIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
