import 'package:flutter/material.dart';
import 'colors.dart';

class Themes {
  static const _floatingActionButtonTheme = FloatingActionButtonThemeData(
    backgroundColor: ChatJournalColors.accentYellow,
  );

  static final lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      color: ChatJournalColors.green,
    ),
    floatingActionButtonTheme: _floatingActionButtonTheme,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: ChatJournalColors.green,
      unselectedItemColor: Colors.blueGrey,
      backgroundColor: ChatJournalColors.white,
    ),
    primaryColor: ChatJournalColors.green,
    backgroundColor: ChatJournalColors.white,
    brightness: Brightness.light,
    textTheme: normalTextTheme,
  );

  static final darkTheme = ThemeData(
    primaryColor: ChatJournalColors.black,
    backgroundColor: ChatJournalColors.black,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      color: ChatJournalColors.black,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: ChatJournalColors.accentYellow,
      unselectedItemColor: ChatJournalColors.iconGrey,
      backgroundColor: ChatJournalColors.black,
    ),
    floatingActionButtonTheme: _floatingActionButtonTheme,
    textTheme: normalTextTheme,
  );

  static TextTheme normalTextTheme = const TextTheme(
    headline1: TextStyle(
      fontSize: 24,
    ),
    headline2: TextStyle(
      fontSize: 22,
    ),
    headline3: TextStyle(
      fontSize: 20,
    ),
    headline4: TextStyle(
      fontSize: 18,
    ),
    bodyText1: TextStyle(
      fontSize: 16,
    ),
    bodyText2: TextStyle(
      fontSize: 18,
    ),
  );

  static TextTheme smallTextTheme = const TextTheme(
    headline1: TextStyle(
      fontSize: 22,
    ),
    headline2: TextStyle(
      fontSize: 20,
    ),
    headline3: TextStyle(
      fontSize: 18,
    ),
    headline4: TextStyle(
      fontSize: 16,
    ),
    bodyText1: TextStyle(
      fontSize: 14,
    ),
    bodyText2: TextStyle(
      fontSize: 16,
    ),
  );

  static TextTheme largeTextTheme = const TextTheme(
    headline1: TextStyle(
      fontSize: 26,
    ),
    headline2: TextStyle(
      fontSize: 24,
    ),
    headline3: TextStyle(
      fontSize: 22,
    ),
    headline4: TextStyle(
      fontSize: 20,
    ),
    bodyText1: TextStyle(
      fontSize: 18,
    ),
    bodyText2: TextStyle(
      fontSize: 20,
    ),
  );
}
