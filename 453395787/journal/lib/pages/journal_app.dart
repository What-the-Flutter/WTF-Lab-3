import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../chat_list_provider.dart';
import '../utils/theme.dart';
import 'home_page.dart';

class JournalApp extends StatelessWidget {
  const JournalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      child: Builder(builder: (internalContext) {
        var appTheme = ThemeChanger.of(internalContext).appTheme;

        return ChangeNotifierProvider<ChatListProvider>(
          create: (_) => ChatListProvider(),
          child: MaterialApp(
            title: 'Journal',
            theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: appTheme.color,
              brightness:
                  appTheme.isDarkMode ? Brightness.dark : Brightness.light,
            ),
            home: const HomePage(
              title: 'Home',
            ),
            debugShowCheckedModeBanner: false,
          ),
        );
      }),
    );
  }
}
