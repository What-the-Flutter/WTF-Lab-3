import 'package:flutter/material.dart';

import 'pages/home_page/home_page.dart';
import 'themes/custom_theme.dart';

class CoolChatJournalApp extends StatelessWidget {
  const CoolChatJournalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTheme(
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Cool Chat Journal',
            theme: CustomTheme.of(context),
            home: const HomePage(appName: 'Cool Chat Journal'),
          );
        },
      ),
    );
  }
}
