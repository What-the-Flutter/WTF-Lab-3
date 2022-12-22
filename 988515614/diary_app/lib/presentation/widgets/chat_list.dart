import 'package:diary_app/presentation/pages/event_page.dart';
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
    return ListView.separated(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chatData = chats[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return const EventPage();
                }),
              );
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
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.black,
        );
      },
    );
  }
}
