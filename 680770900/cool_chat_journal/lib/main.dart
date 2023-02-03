import 'package:flutter/material.dart';

import 'pages/home_page/home_page.dart';

void main() {
  runApp(const CoolChatJournalApp());
}

class CoolChatJournalApp extends StatelessWidget {
  const CoolChatJournalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cool Chat Journal',
      theme: theme,
      home: const HomePage(appName: 'Cool Chat Journal'),
    );
  }
}