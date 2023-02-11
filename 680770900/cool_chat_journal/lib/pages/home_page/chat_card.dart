import 'package:flutter/material.dart';

import '../../model/chat.dart';
import '../../model/event.dart';
import '../events_page/chat_page.dart';

class ChatCard extends StatefulWidget {

  final Icon icon;
  final String title;
  final String subtitle;

  const ChatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  late Chat _chat;

  @override
  void initState() {
    super.initState();
    _chat = Chat(
      name: widget.title,
      events: <Event>[],
      createdTime: DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap:() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(_chat)
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
            child: widget.icon,
          ),
          title: Text(widget.title),
          subtitle: Text(widget.subtitle),
        ),
      ),
    );
  }
}