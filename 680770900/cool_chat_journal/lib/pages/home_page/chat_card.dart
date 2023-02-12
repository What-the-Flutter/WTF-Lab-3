import 'package:flutter/material.dart';

import '../../model/chat.dart';
import '../../model/event.dart';
import '../events_page/chat_page.dart';

class ChatCard extends StatefulWidget {

  final Chat chat;

  const ChatCard({
    super.key,
    required this.chat,
  });

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap:() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(widget.chat)
            ),
          );
        },
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.background,
            ),
            child: widget.chat.icon,
          ),
          title: Text(widget.chat.name),
          subtitle: const Text('Fix me!'),
        ),
      ),
    );
  }
}