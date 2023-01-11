import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePageNavigationBar extends StatefulWidget {
  const HomePageNavigationBar({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<HomePageNavigationBar> createState() => _HomePageNavigationBarState();
}

class _HomePageNavigationBarState extends State<HomePageNavigationBar> {
  int _selectedPage = 0;

  final IList<String> _pageRoutes = [
    '/home',
    '/daily',
    '/timeline',
    '/explore',
  ].lock;

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

  void _onBottomNavigationTap(BuildContext context, int index) {
    setState(() {
      _selectedPage = index;
    });
    context.go(_pageRoutes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          _onBottomNavigationTap(context, index);
        },
        selectedIndex: _selectedPage,
        destinations: _destinations,
      ),
    );
  }
}
