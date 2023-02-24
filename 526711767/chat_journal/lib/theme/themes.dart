import 'package:flutter/material.dart';

class ThemeVariants {
  static final ThemeData darkMode = ThemeData(
    drawerTheme: const DrawerThemeData(backgroundColor: Colors.black),
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black12,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white54,
        selectedIconTheme: IconThemeData(
          color: Colors.amber,
        ),
        unselectedIconTheme: IconThemeData(color: Colors.white54)),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.amber,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
            inherit: false,
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        primary: Colors.grey.shade800,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    primaryIconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        inherit: false,
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        inherit: false,
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        inherit: false,
        color: Colors.white54,
        fontSize: 16,
        fontWeight: FontWeight.w300,
      ),
      labelLarge: TextStyle(
        inherit: false,
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w300,
        textBaseline: TextBaseline.alphabetic,
      ),
    ),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
    cardColor: Colors.grey.shade900,
  );

  static final ThemeData lightMode = ThemeData(
    primaryColor: Colors.teal,
    drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
    brightness: Brightness.light,
    // scaffoldBackgroundColor: Colors.white70,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white70,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: IconThemeData(
          color: Colors.teal,
        ),
        unselectedIconTheme: IconThemeData(color: Colors.grey)),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.amber,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
            inherit: false,
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        primary: Colors.greenAccent.shade100,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.grey),
    primaryIconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        inherit: false,
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        inherit: false,
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        inherit: false,
        color: Colors.grey,
        fontSize: 16,
        fontWeight: FontWeight.w300,
      ),
      labelLarge: TextStyle(
          inherit: false,
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w300,
          textBaseline: TextBaseline.alphabetic),
    ),
    cardColor: Colors.grey.shade300,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.teal),
  );
}
