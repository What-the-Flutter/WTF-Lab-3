import 'package:flutter/material.dart';

import 'chat_list.dart';
import 'empty_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = 0;

  final List<Widget> _pages = [
    ChatList(),
    const EmptyPage(),
    const EmptyPage(),
    const EmptyPage(),
  ];

  final List<Widget> _destinations = const [
    NavigationDestination(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.view_day_outlined),
      label: 'Daily',
    ),
    NavigationDestination(
      icon: Icon(Icons.timeline),
      label: 'Timeline',
    ),
    NavigationDestination(
      icon: Icon(Icons.explore),
      label: 'Explore',
    ),
  ];

  void _onBottomNavigationTap(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  Widget? get _floatingActionButton {
    if (_selectedPage == 0) {
      return FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (_destinations[_selectedPage] as NavigationDestination).label,
        ),
      ),
      body: _pages[_selectedPage],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _onBottomNavigationTap,
        selectedIndex: _selectedPage,
        destinations: _destinations,
      ),
      floatingActionButton: _floatingActionButton,
    );
  }
}
