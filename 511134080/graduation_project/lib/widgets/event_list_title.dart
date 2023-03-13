import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/pages/chat/chat_page.dart';
import 'package:graduation_project/pages/managing_page/managing_page.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../models/chat_model.dart';
import '../pages/home/home_cubit.dart';

class EventListTile extends StatelessWidget {
  final dynamic chatId;

  const EventListTile({super.key, required this.chatId});

  List<ListTile> _createOptions(BuildContext context, ChatModel chat) {
    return [
      ListTile(
        leading: const Icon(
          Icons.info,
          color: Colors.yellow,
          size: 24,
        ),
        title: const Text(
          'Info',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (_) {
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
                      const SizedBox(
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
                    const Text(
                      'Created',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      DateFormat('dd.MM.yyyy').format(chat.date!),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Last event',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      chat.cards.isNotEmpty
                          ? '${DateFormat('dd.MM.yyyy').format(chat.cards.last.time)} at ${DateFormat('hh:mm a').format(chat.cards.last.time)}'
                          : 'No events yet.',
                      style: const TextStyle(
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
                    child: const Text(
                      'OK',
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.attach_file,
          color: Colors.greenAccent,
          size: 24,
        ),
        title: const Text(
          'Pin/Unpin Page',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
          context.read<HomeCubit>().togglePinState(chat.id);
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    final chat = state.chats
                        .where((ChatModel chat) => chat.id == chatId)
                        .first;

                    return ManagingPage(
                      isCreatingNewPage: false,
                      editingPage: chat,
                    );
                  },
                );
              },
            ),
          );
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
          context.read<HomeCubit>().deleteChat(chatId);
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
      backgroundColor: Theme.of(context).primaryColorLight,
      context: context,
      builder: (context) {
        return ListView(
          children: _createOptions(context, chat),
        );
      },
    );
  }

  Widget? _createTrailing(ChatModel chat) {
    return chat.cards.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: chat.isPinned
                ? [
                    const Icon(
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
            ? const Column(
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
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final index = state.chats.indexWhere((element) => element.id == chatId);
        final chat = state.chats[index];

        return ListTile(
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
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
                builder: (context) => ChatPage(
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
