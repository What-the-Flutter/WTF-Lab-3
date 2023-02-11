import 'package:flutter/material.dart';

import 'pages/home_page/home_page.dart';
import 'theme.dart';

class CoolChatJournalApp extends StatelessWidget {  
  const CoolChatJournalApp({super.key});

  @override
  Widget build(BuildContext context) { 
    final theme = AppTheme();
    return MaterialApp(
      title: 'Cool Chat Journal',
      theme: theme.createThemeData(context),
      home: const HomePage(appName: 'Cool Chat Journal'),
    );
  }
}