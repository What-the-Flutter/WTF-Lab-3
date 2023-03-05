import 'package:flutter/material.dart';
import 'package:graduation_project/providers/events_provider.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';

class ChatJournal extends StatelessWidget {
  const ChatJournal({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EventsProvider(),
      child: MaterialApp(
        title: 'Chat Journal',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (_) => const HomePage(),
        },
      ),
    );
  }
}
