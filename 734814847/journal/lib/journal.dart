import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'notifiers/event_notifier.dart';
import 'pages/home_page.dart';
import 'themes/theme.dart';

class Journal extends StatefulWidget {
  const Journal({super.key});

  @override
  State<Journal> createState() => _JournalState();

  static _JournalState of(BuildContext context) =>
      context.findAncestorStateOfType<_JournalState>()!;
}

class _JournalState extends State<Journal> {
  ThemeMode _themeMode = ThemeMode.system;

  void changeTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventsNotifier(),
      child: MaterialApp(
        title: 'Journal project',
        theme: lightTheme(),
        darkTheme: darkTheme(),
        themeMode: _themeMode,
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
