import 'package:flutter/material.dart';

import '../../domain/entities/chat.dart';

class ChatList extends StatelessWidget {
  final List<Chat> chats;
  const ChatList({
    super.key,
    required this.chats,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length * 2 - 1,
      itemBuilder: (BuildContext context, int index) {
        if (index % 2 == 1) {
          return const Divider(
            color: Colors.black,
          );
        }

        final Chat chatData = chats[index ~/ 2];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
            ),
            onPressed: () {
              // Toggle some function to open chat for
              // the current TextButton index
            },
            child: ListTile(
              leading: Icon(
                chatData.icon,
                size: 30,
              ),
              title: Text(chatData.title),
              subtitle: const Text('No events. Click to create one'),
            ),
          ),
        );
      },
    );
  }
}
