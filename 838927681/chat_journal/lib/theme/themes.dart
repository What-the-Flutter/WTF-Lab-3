import 'package:flutter/material.dart';
import '../theme/colors.dart';

enum _Themes {
  _light,
  _dark,
}

class Themes {
  static final light = ThemeData(
    appBarTheme: const AppBarTheme(
      color: ChatJournalColors.primaryColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ChatJournalColors.fabColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(ChatJournalColors.questionnaireBotColor),
      ),
    ),
    primaryColor: ChatJournalColors.primaryColor,
    backgroundColor: ChatJournalColors.backgroundColor,
    drawerTheme: const DrawerThemeData(
      backgroundColor: ChatJournalColors.backgroundColor,
    ),
  );
}
