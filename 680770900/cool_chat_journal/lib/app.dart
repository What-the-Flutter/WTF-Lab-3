import 'package:flutter/material.dart';

import 'presentation/pages/home_page/home_page.dart';
import 'themes/custom_theme.dart';

class CoolChatJournalApp extends StatefulWidget {
  const CoolChatJournalApp({super.key});

  @override
  State<CoolChatJournalApp> createState() => _CoolChatJournalAppState();
}

class _CoolChatJournalAppState extends State<CoolChatJournalApp> {  
  @override
  Widget build(BuildContext context) {
    return CustomTheme(
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Cool Chat Journal',
          theme: CustomTheme.of(context),
          home: const HomePage(),
        );
      }),
    );
  }
}
