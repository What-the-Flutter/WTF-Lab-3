import 'package:flutter/material.dart';
import 'pages/main_screen/main_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Journal',
      theme: ThemeData(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: Color.fromRGBO(0, 103, 102, 1),
            unselectedItemColor: Colors.grey,
          ),
          appBarTheme: const AppBarTheme(
            color: Color.fromRGBO(0, 103, 102, 1),
          )),
      home: const Menu(),
    );
  }
}
