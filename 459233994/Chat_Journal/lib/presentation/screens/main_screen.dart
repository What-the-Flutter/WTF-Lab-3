import 'package:flutter/material.dart';

import '../widgets/app_theme/inherited_theme.dart';
import '../widgets/daily.dart';
import '../widgets/explore.dart';
import 'home/home.dart';
import 'time_line/time_line.dart';

class MainScreen extends StatefulWidget {
  const MainScreen();

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;

  final _screens = [
    Home(),
    Daily(),
    TimeLine(),
    Explore(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InheritedAppTheme.of(context)!.themeData.backgroundColor,
      body: SizedBox.expand(
        child: Container(
          child: _screens[_index],
          color: InheritedAppTheme.of(context)!.themeData.backgroundColor,
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _index,
      selectedItemColor: InheritedAppTheme.of(context)!.themeData.iconColor,
      unselectedItemColor: InheritedAppTheme.of(context)!.themeData.iconColor,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.home,
          ),
          backgroundColor:
              InheritedAppTheme.of(context)!.themeData.backgroundColor,
          label: 'Home',
        ),
        BottomNavigationBarItem(
            icon: const Icon(
              Icons.assignment,
            ),
            backgroundColor:
                InheritedAppTheme.of(context)!.themeData.backgroundColor,
            label: 'Daily'),
        BottomNavigationBarItem(
          icon: const Icon(
            Icons.timeline,
          ),
          backgroundColor:
              InheritedAppTheme.of(context)!.themeData.backgroundColor,
          label: 'TimeLine',
        ),
        BottomNavigationBarItem(
            icon: const Icon(
              Icons.explore,
            ),
            backgroundColor:
                InheritedAppTheme.of(context)!.themeData.backgroundColor,
            label: 'Explore'),
      ],
      onTap: (index) {
        setState(() => _index = index);
      },
    );
  }
}
