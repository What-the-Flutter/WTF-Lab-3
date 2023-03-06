import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/cubits/events_cubit.dart';
import 'package:graduation_project/pages/event_page.dart';

class EventListTile extends StatelessWidget {
  final dynamic chatId;

  const EventListTile({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsCubit, EventsState>(
      builder: (context, state) {
        final index = state.chats.indexWhere((element) => element.id == chatId);
        final chat = state.chats[index];

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
          subtitle: Text(chat.lastEventTitle),
          hoverColor: Colors.deepPurple.shade100,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventPage(
                  chatId: chatId,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
