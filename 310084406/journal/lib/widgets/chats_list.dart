import 'package:flutter/material.dart';

import '../pages/travel.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //const SizedBox(),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Search',
                    suffixIcon: Icon(Icons.search_rounded),
                    border: OutlineInputBorder(),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.label_important),
                  title: const Text('Travel'),
                  subtitle: const Text('No events. Click to create one'),
                  shape: const Border(bottom: BorderSide()),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TravelPage()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.local_grocery_store),
                  title: const Text('Groceries'),
                  subtitle: const Text('No events. Click to create one'),
                  shape: const Border(bottom: BorderSide()),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.light_mode),
                  title: const Text('Days history'),
                  subtitle: const Text('No events. Click to create one'),
                  shape: const Border(bottom: BorderSide()),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
