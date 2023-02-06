import 'package:chat_journal/pages/chat_page.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500);
    var pages = <Page>[
      Page(name: 'Travel', icon: const Icon(Icons.wallet_travel)),
      Page(name: 'Family', icon: const Icon(Icons.family_restroom)),
      Page(name: 'Sports', icon: const Icon(Icons.sports_kabaddi_outlined)),
    ];
    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true, actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search_rounded),
          tooltip: 'Search',
          onPressed: () {},
        ),
      ]),
      drawer: const JournalDrawer(),
      body: ListView(
        children: [
          const QuestionnaireBotButton(),
          const Divider(color: Colors.grey),
          for (var page in pages)
            ListTile(
              leading: page.icon,
              title: Text(
                page.name,
                style: style,
              ),
              subtitle: Text(page.recentRecord),
              iconColor: Colors.grey,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(title: page.name),
                  ),
                );
              },
            ),
        ],
      ),
      // bottomNavigationBar: const JournalNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
    );
  }
}

class JournalNavigationBar extends StatefulWidget {
  const JournalNavigationBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _JournalNavigationBarState();
}

class _JournalNavigationBarState extends State<JournalNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.document_scanner),
          label: 'Daily',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.map,
          ),
          label: 'Timeline',
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class QuestionnaireBotButton extends StatelessWidget {
  const QuestionnaireBotButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500);
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: ElevatedButton(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.sentiment_neutral,
                color: Colors.black,
              ),
              Text(' Questionnaire Bot', style: style),
            ],
          ),
        ),
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            primary: Colors.greenAccent[100]),
      ),
    );
  }
}

class Page {
  String name;
  Icon icon;
  String recentRecord = 'No events. Click to create one';

  Page({required this.name, required this.icon});
}

class JournalDrawer extends StatelessWidget {
  const JournalDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const headerTextStyle = TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600);
    const elementsTextStyle = TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 114.0,
            child: DrawerHeader(
              child: Text(
                'Chat Journal',
                style: headerTextStyle,
              ),
              decoration: BoxDecoration(color: Colors.teal),
            ),
          ),
          ListTile(
            title: const Text('All Pages', style: elementsTextStyle),
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Statistics', style: elementsTextStyle),
            leading: const Icon(Icons.auto_graph),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Search', style: elementsTextStyle),
            leading: const Icon(Icons.search),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Settings', style: elementsTextStyle),
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}