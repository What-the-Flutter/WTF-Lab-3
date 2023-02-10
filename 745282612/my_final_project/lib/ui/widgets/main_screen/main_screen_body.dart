import 'package:flutter/material.dart';

import 'package:my_final_project/ui/screens/home_screen.dart';
import 'package:my_final_project/ui/screens/timeline_screen.dart';

class MainScreenBody extends StatelessWidget {
  final int index;
  final List _widgetOptions = const <Widget>[
    HomeScreen(),
    Text('Daily'),
    TimelineScreen(),
    Text('Explore'),
  ];

  const MainScreenBody({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return _widgetOptions[index];
  }
}
