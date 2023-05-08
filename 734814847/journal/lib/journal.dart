import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'EventNotifier.dart';
import 'pages/home_page.dart';

class Journal extends StatelessWidget {
  const Journal({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventsNotifier(),
      child: MaterialApp(
        title: 'Journal project',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: const HomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
