import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:my_final_project/entities/provider_chat.dart';
import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/screens/main_screen.dart';
import 'package:my_final_project/utils/theme/theme_inherited.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomTheme(
      child: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChatProvider()),
      ],
      child: MaterialApp(
        theme: CustomThemeInherited.of(context).themeData,
        title: 'Chat Journal',
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        initialRoute: '/',
        routes: {
          '/': (context) => const Menu(),
        },
      ),
    );
  }
}
