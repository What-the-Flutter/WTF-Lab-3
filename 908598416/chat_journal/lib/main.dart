import 'dart:core';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal Chat',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        brightness: Brightness.dark
      ),
      home: const HomePage(title: 'Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    ChatsPageBody(),
    const Text(
      'Daily',
      style: optionStyle,
    ),
    const Text(
      'Timeline',
      style: optionStyle,
    ),
    const Text(
      'Explore',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addListItem() {
    setState(() {
      Navigator.push(context, MaterialPageRoute<void>(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add tab'),
            ),
            body: const Center(
              child: Text(
                'Enter a name for new tab',
                style: TextStyle(fontSize: 24),
              ),
            ),
          );
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Journal'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.invert_colors),
            tooltip: 'Switch color scheme',
            onPressed: () {

            },
          ),
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addListItem,
        tooltip: 'Add new category',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    bottomNavigationBar: BottomNavigationBar(
      unselectedItemColor: Colors.white,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.task),
          label: 'Daily',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Timeline',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.compass_calibration),
          label: 'Explore',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
      )
    );
  }
}

class ChatsPageBody extends StatefulWidget {
  ChatsPageBody({Key? key}) : super(key: key);

  @override
  State<ChatsPageBody> createState() => _ChatsPageBodyState();
}

class _ChatsPageBodyState extends State<ChatsPageBody> {
  List<ChatItem> items = [
    const ChatItem(
      icon: Icon(Icons.flight,size: 40),
      title: 'Travel',
      lastMessage: 'No events. Click to create one.',
      time: '',
    ),
    const ChatItem(
      icon: Icon(Icons.chair,size: 40),
      title: 'Family',
      lastMessage: 'No events. Click to create one.',
      time: '',
    ),
    const ChatItem(
      icon: Icon(Icons.sports,size: 40),
      title: 'Sports',
      lastMessage: 'No events. Click to create one.',
      time: '',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, i) {
        return ChatItem(icon: items[i].icon, title: items[i].title, lastMessage: items[i].lastMessage, time: items[i].time);
      }
    );
  }
}

class ChatItem extends StatefulWidget {
  final Icon icon;
  final String title;
  final String lastMessage;
  final String time;


  const ChatItem({
    required this.icon,
    required this.title,
    required this.lastMessage,
    required this.time,
    Key? key
  }) : super(key: key);

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  final _timeTextStyle = const TextStyle(
    fontSize: 16,
    color: Colors.grey,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        hoverColor: Colors.green,
        leading: widget.icon,
        title: Text(widget.title),
        subtitle: Text(widget.lastMessage),
        trailing: Text(widget.time, style: _timeTextStyle),
        onTap: () { },
      ),
      onHover: (val) {
        setState(() {

        });
      },
    );
  }
}
