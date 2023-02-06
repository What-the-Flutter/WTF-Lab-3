import 'package:flutter/material.dart';
import 'colors.dart';

enum _Themes {
  _light,
  _dark,
}

class Themes {
  static final eventColor = ChatJournalColors.lightGreen;
  static final selectedEventColor = ChatJournalColors.accentLightGreen;
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
  );
}
