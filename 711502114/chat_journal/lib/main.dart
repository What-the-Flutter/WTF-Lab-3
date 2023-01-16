import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'l10n/l10n.dart';
import 'models/chat_provider.dart';
import 'pages/bottom_nav_bar.dart';
import 'theme/custom_user_theme.dart';
import 'theme/theme_inherited.dart';

void main() async {
  runApp(const CustomUserTheme(child: ChatJournalApplication()));
}

class ChatJournalApplication extends StatelessWidget {
  const ChatJournalApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: MaterialApp(
        theme: ThemeInherited.of(context).themeData,
        debugShowCheckedModeBanner: false,
        supportedLocales: L10n.all,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: const BottomNavBar(),
      ),
    );
  }
}
