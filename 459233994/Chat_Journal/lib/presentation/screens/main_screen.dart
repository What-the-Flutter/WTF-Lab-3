import 'package:flutter/material.dart';

import '../widgets/app_theme/inherited_app_theme.dart';
import '../widgets/daily.dart';
import '../widgets/explore.dart';
import '../widgets/time_line.dart';
import 'home/home.dart';


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
      backgroundColor: InheritedAppTheme.of(context)?.getTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: InheritedAppTheme.of(context)?.getTheme.themeColor,
        leading: InkWell(
          child: Icon(
            Icons.list,
            color: InheritedAppTheme.of(context)?.getTheme.keyColor,
          ),
        ),
        title: Center(
          child: Text(
            _screens[_index].title,
            style: TextStyle(
              color: InheritedAppTheme.of(context)?.getTheme.keyColor,
            ),
          ),
        ),
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              child: Icon(
                Icons.contrast,
                color: InheritedAppTheme.of(context)?.getTheme.keyColor,
              ),
              onTap: () {
                setState(() {
                  InheritedAppTheme.of(context)?.changeTheme();
                });
              },
            ),
          )
        ],
      ),
      body: SizedBox.expand(
        child: Container(
          child: _screens[_index],
          color: InheritedAppTheme.of(context)?.getTheme.backgroundColor,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        selectedItemColor: InheritedAppTheme.of(context)?.getTheme.iconColor,
        unselectedItemColor: InheritedAppTheme.of(context)?.getTheme.iconColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.home,
            ),
            backgroundColor: InheritedAppTheme.of(context)?.getTheme.backgroundColor,
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: const Icon(
                Icons.assignment,
              ),
              backgroundColor: InheritedAppTheme.of(context)?.getTheme.backgroundColor,
              label: 'Daily'),
          BottomNavigationBarItem(
              icon: const Icon(
                Icons.timeline,
              ),
              backgroundColor: InheritedAppTheme.of(context)?.getTheme.backgroundColor,
              label: 'TimeLine',),
          BottomNavigationBarItem(
              icon: const Icon(
                Icons.explore,
              ),
              backgroundColor: InheritedAppTheme.of(context)?.getTheme.backgroundColor,
              label: 'Explore'),
        ],
        onTap: (index) {
          setState(() => _index = index);
        },
      ),
    );
  }
}
