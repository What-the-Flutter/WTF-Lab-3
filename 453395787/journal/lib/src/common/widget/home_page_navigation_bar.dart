import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';

import '../../routes.dart';
import '../utils/locale.dart' as locale;

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
    PagePaths.home.path,
    PagePaths.daily.path,
    PagePaths.timeline.path,
    PagePaths.settings.path,
  ].lock;

  final List<Widget> _destinations = [
    NavigationDestination(
      icon: const Icon(Icons.home),
      label: locale.Pages.home.i18n(),
    ),
    NavigationDestination(
      icon: const Icon(Icons.view_day_outlined),
      label: locale.Pages.daily.i18n(),
    ),
    NavigationDestination(
      icon: const Icon(Icons.timeline),
      label: locale.Pages.timeline.i18n(),
    ),
    NavigationDestination(
      icon: const Icon(Icons.settings_outlined),
      label: locale.Pages.settings.i18n(),
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
