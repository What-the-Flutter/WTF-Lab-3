import 'package:flutter/material.dart';

import 'entities/chat.dart';
import 'entities/chat_value.dart';
import 'hovers/on_hovers_button.dart';

class ChatList extends StatelessWidget {
  ChatList({super.key});

  final List<Chat> chatList = ChatValue.listChat;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatList.length * 2 + 1,
      itemBuilder: (context, index) {
        if (index.isEven) return const Divider();
        final itemChat = chatList[index ~/ 2];
        return HoverButton(
          child: TextButton(
            onPressed: () {},
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color.fromRGBO(120, 143, 159, 1),
                foregroundColor: Colors.white,
                radius: 40,
                child: itemChat.icon,
              ),
              title: Text(
                itemChat.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              subtitle: const Text(
                'No Events. Click to create one',
              ),
            ),
          ),
        );
      },
    );
  }
}
