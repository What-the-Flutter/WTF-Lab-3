import 'package:flutter/material.dart';

bool themeFlag = false;

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.purple,
  backgroundColor: Colors.purpleAccent,
  brightness: Brightness.light,
  iconTheme: const IconThemeData(
    color: Colors.pink,
  ),
);

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.deepPurple,
  backgroundColor: Colors.deepPurpleAccent,
  brightness: Brightness.dark,
  iconTheme: const IconThemeData(
    color: Colors.deepPurpleAccent,
  ),
);
