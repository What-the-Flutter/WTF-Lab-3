import 'package:flutter/material.dart';

import '../chat_repository.dart';
import 'chat/chat_page.dart';

class ChatList extends StatelessWidget {
  ChatList({Key? key}) : super(key: key);

  final repo = ChatRepository();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: repo.chats.length,
      itemBuilder: (_, index) => ChatItem(
        chat: repo.chats[index],
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  final Chat chat;

  const ChatItem({
    required this.chat,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: ListTile(
        leading: Icon(
          chat.icon,
        ),
        title: Text(
          chat.name,
        ),
        subtitle: Text(
          chat.lastMessage.text,
        ),
        trailing: Text(
          chat.lastMessage.time,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChatPage(chat: chat),
            ),
          );
        },
      ),
    );
  }
}
