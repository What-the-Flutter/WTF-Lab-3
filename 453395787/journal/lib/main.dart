import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
      ),
      home: const HomePage(title: 'Home'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = 0;

  final List<Widget> _pages = const [
    ChatsPageBody(),
    EmptyPage(),
    EmptyPage(),
    EmptyPage(),
  ];

  final List<Widget> _destinations = const [
    NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
    NavigationDestination(icon: Icon(Icons.view_day_outlined), label: 'Daily'),
    NavigationDestination(icon: Icon(Icons.timeline), label: 'Timeline'),
    NavigationDestination(icon: Icon(Icons.explore), label: 'Explore'),
  ];

  void _onBottomNavigationTap(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _pages[_selectedPage],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _onBottomNavigationTap,
        selectedIndex: _selectedPage,
        destinations: _destinations,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ChatsPageBody extends StatelessWidget {
  const ChatsPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ChatItem(
          icon: Icon(Icons.all_inclusive_outlined),
          title: 'All',
          lastMessage: 'Last message',
          time: '12.12pm',
        ),
        const ChatItem(
          icon: Icon(Icons.message),
          title: 'First',
          lastMessage: 'Lorem ipsum',
          time: 'Mon',
        ),
        const ChatItem(
          icon: Icon(Icons.camera_outdoor),
          title: 'Second',
          lastMessage: 'Lorem ipsum',
          time: '12 Dec',
        ),
      ],
    );
  }
}

class ChatItem extends StatelessWidget {
  final Icon icon;
  final String title;
  final String lastMessage;
  final String time;

  final _timeTextStyle = const TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );

  const ChatItem({
    required this.icon,
    required this.title,
    required this.lastMessage,
    required this.time,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: icon,
        title: Text(title),
        subtitle: Text(lastMessage),
        trailing: Text(time, style: _timeTextStyle),
        onTap: () {},
      ),
    );
  }
}

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Empty page'),
    );
  }
}
