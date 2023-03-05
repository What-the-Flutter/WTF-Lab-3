import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/pages/event_page.dart';
import 'package:graduation_project/providers/events_provider.dart';
import 'package:provider/provider.dart';

import '../models/chat_model.dart';

class EventListTile extends StatelessWidget {
  final ChatModel chat;

  const EventListTile({super.key, required this.chat});

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
        child: icons[chat.iconId],
      ),
      title: Text(chat.title),
      subtitle: Consumer<EventsProvider>(
        builder: (context, provider, child) => Text(chat.lastEventTitle),
      ),
      hoverColor: Colors.deepPurple.shade100,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventPage(
              chat: chat,
            ),
          ),
        );
      },
    );
  }
}
