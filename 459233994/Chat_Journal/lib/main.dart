import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'presentation/screens/main.dart';

void main() {
  runApp(const ChatJournal());
}

class ChatJournal extends StatelessWidget {
  const ChatJournal({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}
