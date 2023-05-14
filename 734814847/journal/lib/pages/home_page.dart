import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../journal.dart';
import '../models/chat.dart';
import '../notifiers/event_notifier.dart';
import 'add_chat_page.dart';
import 'events_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Chat> chats = [];

  @override
  void initState() {
    super.initState();
    chats = Provider.of<EventsNotifier>(context, listen: false).chats;
  }

  Future<void> _navigateAndDisplay(BuildContext context) async{
    final chat = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddChatPage(),
      ),
    );
    chats.add(chat);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontSize: 18,
    );
    final numOfElements = chats.length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Journal.of(context).changeTheme();
            },
            icon: const Icon(Icons.invert_colors),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            color: theme.colorScheme.background,
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
                return Consumer<EventsNotifier>(
                  builder: (context, provider, child) =>
                      Material(child: buildListTile(chats[index], context)),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(height: 5);
              },
              itemCount: numOfElements,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateAndDisplay(context);
        },
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

  ListTile buildListTile(Chat chat, BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          shape: BoxShape.circle,
        ),
        child: chat.icon,
      ),
      title: Text(chat.name),
      subtitle: const Text('No events. Click to create one'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventsPage(
              chat: chat,
            ),
          ),
        );
      },
    );
  }
}
