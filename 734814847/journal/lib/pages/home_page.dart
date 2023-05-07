import 'package:flutter/material.dart';

import '../models/chat.dart';
import 'events_page.dart';

class Journal extends StatelessWidget {
  const Journal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal project',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
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
  List<Chat> chats = [];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontSize: 18,
    );
    var numOfElements = 3;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.invert_colors),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            color: Theme.of(context).colorScheme.background,
            margin: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 30,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 40,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.smart_toy,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                Text(
                  style: style,
                  'Questionnaire Bot',
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.separated(
            itemBuilder: (context, index) {
              Chat chat;
              switch (index) {
                case 0:
                  chat = Chat(name: 'Travel', icon: Icons.airplanemode_active);
                  break;
                case 1:
                  chat = Chat(name: 'Family', icon: Icons.chair);
                  break;
                default:
                  chat = Chat(name: 'Sports', icon: Icons.fitness_center);
                  break;
              }
              chats.add(chat);
              return ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(250, 168, 105, 98),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(chat.icon, color: Colors.white),
                ),
                title: Text(chat.name),
                subtitle: const Text('No events. Click to create one'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EventsPage(chat: chat,))
                  );
                },
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(height: 5);
            },
            itemCount: numOfElements,
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.class_), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'daily'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'timeline'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'explore'),
        ],
      ),
    );
  }
}
