import 'package:flutter/material.dart';

import 'pages/home_page/home_page.dart';

void main() {
  runApp(const CoolChatJournalApp());
}

class CoolChatJournalApp extends StatelessWidget {
  const CoolChatJournalApp({super.key});

  @override
  Widget build(BuildContext context) {

    var colorScheme = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 212, 243, 234),
      primary: const Color.fromARGB(255, 159, 207, 199),
      background: const Color.fromARGB(255, 212, 243, 234),
      onBackground: const Color.fromARGB(255, 255, 234, 222),
    );   

    var theme = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,

      // Fonts.
      fontFamily: 'Open Sans',
      textTheme: Theme.of(context).textTheme.apply(
        fontSizeFactor: 1.3, 
      ),

      // Scaffold elements.
      appBarTheme: AppBarTheme(
        color: colorScheme.background,
      ),
      scaffoldBackgroundColor: colorScheme.background,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.onBackground,
        shape: const CircleBorder(),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: colorScheme.primary,
      ),
    );

    return MaterialApp(
      title: 'Cool Chat Journal',
      theme: theme,
      home: const HomePage(appName: 'Cool Chat Journal'),
    );
  }
}