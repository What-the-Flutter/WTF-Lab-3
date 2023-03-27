import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    colorSchemeSeed: Colors.deepPurple,
    useMaterial3: true,
    hintColor: Colors.grey.shade400,
    highlightColor: Colors.green[100],
    focusColor: Colors.deepPurple[200],
    cardColor: Colors.deepPurple[100],
    primaryColorLight: Colors.deepPurple.shade300,
    primaryColorDark: Colors.deepPurple,
    hoverColor: Colors.deepPurple,
    disabledColor: Colors.grey[700],
    textTheme: defaultTextTheme,
    secondaryHeaderColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
  );

  static final darkTheme = ThemeData(
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.deepPurple.shade700,
    useMaterial3: true,
    focusColor: Colors.deepPurple[600],
    cardColor: Colors.deepPurple[400],
    primaryColorLight: Colors.deepPurple,
    primaryColorDark: Colors.deepPurple.shade300,
    hoverColor: Colors.grey[850],
    disabledColor: Colors.grey[700],
    textTheme: defaultTextTheme,
    secondaryHeaderColor: Colors.white,
    scaffoldBackgroundColor: Colors.black,
  );

  static final smallTextTheme = const TextTheme(
    // home
    displayLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 19.2,
    ),
    // 'questionnaire bot'
    displayMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    // title in chat page and alert dialog
    headlineLarge: TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 19.2,
    ),
    // title in chat list tile
    titleLarge: TextStyle(
      fontSize: 14.4,
    ),
    // subtitle in chat list tile
    titleMedium: TextStyle(
      fontSize: 12.8,
    ),
    // category in event card
    labelLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    // date and text of event, category in chat page
    labelMedium: TextStyle(
      fontSize: 12,
    ),
    // drawer headline
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 16,
      color: Colors.white,
    ),
    // navigation bar and modal bottom sheet
    bodyMedium: TextStyle(
      fontSize: 14.4,
    ),
  );

  static final defaultTextTheme = const TextTheme(
    // home
    displayLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 24,
    ),
    // 'questionnaire bot'
    displayMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 20,
    ),
    // title in chat page and alert dialog
    headlineLarge: TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 24,
    ),
    // title in chat list tile
    titleLarge: TextStyle(
      fontSize: 18,
    ),
    // subtitle in chat list tile
    titleMedium: TextStyle(
      fontSize: 16,
    ),
    // category in event card
    labelLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    // date and text of event, category in chat page
    labelMedium: TextStyle(
      fontSize: 15,
    ),
    // drawer headline
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 20,
      color: Colors.white,
    ),
    // navigation bar and modal bottom sheet
    bodyMedium: TextStyle(
      fontSize: 18,
    ),
  );

  static final largeTextTheme = const TextTheme(
    // home
    displayLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 28.8,
    ),
    // 'questionnaire bot'
    displayMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 24,
    ),
    // title in chat page and alert dialog
    headlineLarge: TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 28.8,
    ),
    // title in chat list tile
    titleLarge: TextStyle(
      fontSize: 21.6,
    ),
    // subtitle in chat list tile
    titleMedium: TextStyle(
      fontSize: 19.2,
    ),
    // category in event card
    labelLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 24,
    ),
    // date and text of event, category in chat page
    labelMedium: TextStyle(
      fontSize: 18,
    ),
    // drawer headline
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 24,
      color: Colors.white,
    ),
    // navigation bar and modal bottom sheet
    bodyMedium: TextStyle(
      fontSize: 21.6,
    ),
  );
}
