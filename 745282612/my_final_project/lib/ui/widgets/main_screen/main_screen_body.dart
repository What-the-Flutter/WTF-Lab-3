import 'package:flutter/material.dart';

import '../../screens/home_screen.dart';

class MainScreenBody extends StatelessWidget {
  const MainScreenBody({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    const List _widgetOptions = <Widget>[
      HomeScreen(),
      Text('Daily'),
      Text('Timeline'),
      Text('Explore'),
    ];
    return _widgetOptions[index];
  }
}
