import 'package:flutter/material.dart';

import '../widgets/daily.dart';
import '../widgets/explore.dart';
import '../widgets/home/home.dart';
import '../widgets/time_line.dart';

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
      appBar: AppBar(
        backgroundColor: const Color(0xffB1CC74),
        leading: const Icon(Icons.list),
        title: Center(
          child: Text(_screens[_index].title),
        ),
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 16.0),
            child: const Icon(Icons.contrast),
          )
        ],
      ),
      body: _screens[_index],
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffD0F4EA),
        onPressed: () => {},
        child: const Icon(
          Icons.add,
          color: Color(0xff829399),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color(0xff829399),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.assignment,
                color: Color(0xff829399),
              ),
              label: 'Daily'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.timeline,
                color: Color(0xff829399),
              ),
              label: 'TimeLine'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.explore,
                color: Color(0xff829399),
              ),
              label: 'Explore'),
        ],
        onTap: (index) {
          setState(() => _index = index);
        },
      ),
    );
  }
}
