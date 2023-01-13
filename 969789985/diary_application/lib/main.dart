import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ui/screens/start_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(systemNavigationBarColor: Color(0x8ccfd8dc)));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        drawerTheme: const DrawerThemeData(
          backgroundColor: Color(0xD9f5f5f5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                  topRight: Radius.circular(20.0))),
        ),
        useMaterial3: true,
        primarySwatch: Colors.grey,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: const Color(0xFFcfd8dc),
            elevation: 5,
            sizeConstraints:
            const BoxConstraints(minWidth: 60.0, minHeight: 60.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
        appBarTheme: const AppBarTheme(
            centerTitle: true, backgroundColor: Color(0x80cfd8dc)),
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const StartScreen(),
    );
  }
}
