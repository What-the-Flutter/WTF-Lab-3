import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'presentation/pages/home_page/home_page.dart';
import 'themes/custom_theme.dart';

class CoolChatJournalApp extends StatefulWidget {
  final User? user;

  const CoolChatJournalApp({
    super.key,
    required this.user,
  });

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
          home: HomePage(user: widget.user),
        );
      }),
    );
  }
}
