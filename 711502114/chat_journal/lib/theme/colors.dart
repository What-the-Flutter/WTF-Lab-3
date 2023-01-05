import 'package:flutter/material.dart';

const botBackgroundColor = Color.fromRGBO(49, 162, 225, 0.05);
const circleMessageColor = Color.fromRGBO(77, 157, 206, 0.7);
const hoverElementColor = Color.fromRGBO(161, 161, 161, 0.05);
Color iconColor = Colors.white;

const _mainColor = Color.fromRGBO(49, 162, 225, 1);
const _elementsColor = Color.fromRGBO(94, 163, 222, 1);

const _mainDarkColor = Color.fromRGBO(33, 45, 59, 1);
const _elementsDarkColor = Color.fromRGBO(23, 34, 44, 1);

class CustomTheme {
  static ThemeData get lightTheme {
    iconColor = Colors.black;
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: _mainColor,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(color: _mainColor),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _elementsColor,
        foregroundColor: Colors.black,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: _mainColor,
        elevation: 0.0,
      ),
    );
  }

  static ThemeData get darkTheme {
    iconColor = Colors.white;
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: _mainDarkColor,
      scaffoldBackgroundColor: _elementsDarkColor,
      appBarTheme: const AppBarTheme(color: _mainDarkColor),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _elementsColor,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: _elementsDarkColor,
        selectedItemColor: _mainColor,
        elevation: 0.0,
      ),
    );
  }
}
