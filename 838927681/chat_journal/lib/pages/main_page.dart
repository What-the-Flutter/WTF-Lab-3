import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../pages/home.dart';
import '../theme/colors.dart';
import '../theme/themes.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../widgets/theme_button.dart';

class ChatJournal extends StatefulWidget {
  const ChatJournal({super.key});

  @override
  State<ChatJournal> createState() => _ChatJournalState();
// This widget is the root of your application.

}

class _ChatJournalState extends State<ChatJournal> {
  final _title = 'Home';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: Themes.light,
      home: _mainPage(),
    );
  }

  Widget _mainPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
        actions: const [
          ThemeButton(),
        ],
      ),
      drawer: _drawer(),
      body: const HomePage(),
      bottomNavigationBar: const BottomNavigation(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: ChatJournalColors.primaryColor,
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                DateFormat('MMM d, y').format(DateTime.now()),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const ListTile(
            title: Text('Help spread the word'),
            leading: Icon(Icons.card_giftcard),
          ),
          const ListTile(
            title: Text('Search'),
            leading: Icon(Icons.search),
          ),
          const ListTile(
            title: Text('Notifications'),
            leading: Icon(Icons.notifications),
          ),
          const ListTile(
            title: Text('Statistics'),
            leading: Icon(Icons.analytics),
          ),
          const ListTile(
            title: Text('Settings'),
            leading: Icon(Icons.settings),
          ),
          const ListTile(
            title: Text('Feedback'),
            leading: Icon(Icons.feedback),
          )
        ],
      ),
    );
  }
}
