import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../basic/providers/chat_list_provider.dart';
import 'screens/start_screen.dart';
import '../basic/themes/app_theme.dart';
import 'utils/themes.dart';

class DiaryApp extends StatelessWidget {
  const DiaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTheme(
      child: Builder(
        builder: (internalContext) {
          final appTheme = ThemeChanger.of(internalContext).appTheme;

          return ChangeNotifierProvider<ChatListProvider>(
            create: (_) => ChatListProvider(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: appTheme.isDarkMode
                  ? Themes.getThemeFromKey(ThemeKeys.dark)
                  : Themes.getThemeFromKey(ThemeKeys.light),
              home: const StartScreen(),
            ),
          );
        },
      ),
    );
  }
}
