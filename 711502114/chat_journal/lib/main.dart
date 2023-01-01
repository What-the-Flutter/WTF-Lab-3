import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme/colors.dart';
import 'theme/theme_model.dart';
import 'ui/bottom_nav_bar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeNotifier.isDark
                ? CustomTheme.darkTheme
                : CustomTheme.lightTheme,
            home: const BottomNavBar(),
          );
        },
      ),
    );
  }
}
