import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/cubits/events_cubit.dart';
import 'package:graduation_project/pages/edit_or_create_page.dart';
import 'package:graduation_project/pages/event_page.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../models/chat_model.dart';

class EventListTile extends StatelessWidget {
  final dynamic chatId;

  const EventListTile({super.key, required this.chatId});

  List<ListTile> _createOptions(BuildContext context, ChatModel chat) {
    return [
      ListTile(
        leading: Icon(
          Icons.info,
          color: Colors.yellow,
          size: 24,
        ),
        title: Text(
          'Info',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade300,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(24),
                            ),
                          ),
                          child: chat.iconId == 0
                              ? Center(
                                  child: Text(
                                    chat.title[0].toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                    ),
                                  ),
                                )
                              : icons[chat.iconId],
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(chat.title),
                      ],
                    ),
                  ),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Created',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        '${DateFormat('dd.MM.yyyy').format(chat.date)}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Last event',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        chat.cards.isNotEmpty
                            ? '${DateFormat('dd.MM.yyyy').format(chat.cards.last.time)} at ${DateFormat('hh:mm a').format(chat.cards.last.time)}'
                            : 'No events yet.',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'OK',
                      ),
                    ),
                  ],
                );
              });
        },
      ),
      ListTile(
        leading: Icon(
          Icons.attach_file,
          color: Colors.greenAccent,
          size: 24,
        ),
        title: Text(
          'Pin/Unpin Page',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
          context.read<EventsCubit>().togglePinState(chat.id);
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.edit,
          color: Colors.cyan,
          size: 24,
        ),
        title: const Text(
          'Edit Page',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BlocBuilder<EventsCubit, EventsState>(
              builder: (context, state) {
                return CreatingPage(
                  isCreatingNewPage: false,
                  editingPage: state.getChatById(chatId),
                );
              },
            );
          }));
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.delete,
          color: Colors.redAccent,
          size: 24,
        ),
        title: const Text(
          'Delete Page',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onTap: () {
          context.read<EventsCubit>().deleteChat(chatId);
          Navigator.pop(context);
        },
      ),
    ];
  }

  void onLongPress(BuildContext context, ChatModel chat) {
    showModalBottomSheet(
        constraints: BoxConstraints.loose(
          const Size.fromHeight(
            240,
          ),
        ),
        backgroundColor: Colors.deepPurple.shade400,
        context: context,
        builder: (context) {
          return ListView(
            children: _createOptions(context, chat),
          );
        });
  }

  Widget? _createTrailing(ChatModel chat) {
    return chat.cards.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: chat.isPinned
                ? [
                    Icon(
                      Icons.attach_file,
                      color: Colors.deepPurple,
                    ),
                    Text(
                      DateFormat('hh:mm a').format(chat.cards.last.time),
                    ),
                  ]
                : [
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: Text(
                        DateFormat('hh:mm a').format(chat.cards.last.time),
                      ),
                    ),
                  ],
          )
        : chat.isPinned
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.attach_file,
                    color: Colors.deepPurple,
                  ),
                ],
              )
            : null;
  }

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
            child: chat.iconId == 0
                ? Center(
                    child: Text(
                      chat.title[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  )
                : icons[chat.iconId],
          ),
          title: Text(chat.title),
          subtitle: chat.cards.isNotEmpty
              ? Text(chat.cards.last.title)
              : const Text('No events. Click here to create one.'),
          hoverColor: Colors.deepPurple.shade100,
          trailing: _createTrailing(chat),
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
          onLongPress: () {
            onLongPress(context, chat);
          },
        );
      },
    );
  }
}
