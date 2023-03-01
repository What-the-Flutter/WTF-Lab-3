import 'package:flutter/material.dart';
import 'package:graduation_project/pages/event_page.dart';
import 'package:graduation_project/providers/events_provider.dart';
import 'package:provider/provider.dart';

import '../models/chat_model.dart';

class EventListTile extends StatelessWidget {
  final Icon icon;

  final String title;

  final String subtitle;

  ChatModel chat;

  EventListTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required Key super.key,
  }) : chat = ChatModel(id: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade300,
          borderRadius: const BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        child: icon,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      hoverColor: Colors.deepPurple.shade100,
      onTap: () {
        context.read<EventsProvider>().addChat(chat);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventPage(
              title: title,
              chat: chat,
            ),
          ),
        );
      },
    );
  }
}
