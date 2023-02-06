import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'presentation/screens/main.dart';
import 'presentation/widgets/app_theme/app_theme.dart';

void main() {
  runApp(const ChatJournal());
}

class ChatJournal extends StatelessWidget {
  const ChatJournal({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return AppTheme(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
