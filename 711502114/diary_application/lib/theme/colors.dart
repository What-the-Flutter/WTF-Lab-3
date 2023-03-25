import 'package:flutter/material.dart';

const _mainColor = Color.fromRGBO(49, 162, 225, 1);
const _elementsColor = Color.fromRGBO(94, 163, 222, 1);

const _mainDarkColor = Color.fromRGBO(33, 45, 59, 1);
const _elementsDarkColor = Color.fromRGBO(23, 34, 44, 1);

const botBackgroundColor = Color.fromRGBO(49, 162, 225, 0.3);

const circleMessageColor = Color.fromRGBO(77, 157, 206, 0.7);
const circleMessageSelectedColor = Color.fromRGBO(77, 157, 206, 0.35);

const hoverElementColor = Color.fromRGBO(161, 161, 161, 0.05);

Color iconColor = Colors.white;

Color messageBlocColor = const Color.fromRGBO(37, 47, 57, 1);

Color addChatColor = botBackgroundColor;
Color addTextColor = Colors.black;

Color dialogBackgroundColor = _mainDarkColor;
Color dialogOkButton = _mainColor;

Color pinIconColor = Colors.black;

Color editColor = const Color.fromRGBO(164, 157, 26, 0.5);
Color deleteColor = const Color.fromRGBO(159, 25, 25, 0.5);

class CustomTheme {
  static ThemeData get lightTheme {
    iconColor = Colors.black;
    messageBlocColor = circleMessageColor;
    dialogBackgroundColor = const Color.fromARGB(255, 76, 104, 135);
    dialogOkButton = _mainColor;
    addChatColor = _elementsColor;
    addTextColor = Colors.black;
    pinIconColor = Colors.black;
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: _mainColor,
      scaffoldBackgroundColor: const Color.fromARGB(224, 239, 238, 238),
      appBarTheme: const AppBarTheme(color: _mainColor),
      hoverColor: hoverElementColor,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _elementsColor,
        foregroundColor: Colors.black,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: _mainColor,
        elevation: 0.0,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      fontFamily: 'Roboto-Bold',
      dialogTheme: const DialogTheme(
        backgroundColor: _elementsColor,
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
      ),
    );
  }

  static ThemeData get darkTheme {
    iconColor = Colors.white;
    messageBlocColor = const Color.fromRGBO(37, 47, 57, 1);
    dialogBackgroundColor = _mainDarkColor;
    dialogOkButton = _mainColor;
    addChatColor = botBackgroundColor;
    addTextColor = Colors.white;
    pinIconColor = Colors.white;
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: _mainDarkColor,
      scaffoldBackgroundColor: _elementsDarkColor,
      appBarTheme: const AppBarTheme(color: _mainDarkColor),
      hoverColor: hoverElementColor,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _elementsColor,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: _elementsDarkColor,
        selectedItemColor: _mainColor,
        elevation: 0.0,
      ),
      fontFamily: 'Roboto-Bold',
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: _elementsDarkColor,
      ),
    );
  }

  static TextTheme defaultTextTheme = const TextTheme(
    headline1: TextStyle(fontSize: 24),
    headline2: TextStyle(fontSize: 22),
    headline3: TextStyle(fontSize: 20),
    headline4: TextStyle(fontSize: 18),
    bodyText1: TextStyle(fontSize: 16),
    bodyText2: TextStyle(fontSize: 18),
  );

  static TextTheme smallTextTheme = const TextTheme(
    headline1: TextStyle(fontSize: 22),
    headline2: TextStyle(fontSize: 20),
    headline3: TextStyle(fontSize: 18),
    headline4: TextStyle(fontSize: 16),
    bodyText1: TextStyle(fontSize: 14),
    bodyText2: TextStyle(fontSize: 16),
  );

  static TextTheme largeTextTheme = const TextTheme(
    headline1: TextStyle(fontSize: 26),
    headline2: TextStyle(fontSize: 24),
    headline3: TextStyle(fontSize: 22),
    headline4: TextStyle(fontSize: 20),
    bodyText1: TextStyle(fontSize: 18),
    bodyText2: TextStyle(fontSize: 20),
  );
}
