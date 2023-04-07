import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../models/chat.dart';
import '../pages/chat/chat_page.dart';
import '../pages/home/home_cubit.dart';
import '../pages/managing_page/managing_page.dart';

class ChatListTile extends StatelessWidget {
  final dynamic _chatId;

  const ChatListTile({super.key, required chatId}) : _chatId = chatId;

  ListTile _infoOption(BuildContext context, Chat chat) {
    return ListTile(
      leading: const Icon(
        Icons.info,
        color: Colors.yellow,
        size: 24,
      ),
      title: Text(
        'Info',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white,
            ),
      ),
      onTap: () {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return _alertDialog(context, chat);
          },
        );
      },
    );
  }

  AlertDialog _alertDialog(BuildContext context, Chat chat) {
    return AlertDialog(
      title: Center(
        child: _alertDialogTitle(chat, context),
      ),
      content: _alertDialogContent(chat, context),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'OK',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontWeight: FontWeight.normal,
                ),
          ),
        ),
      ],
    );
  }

  Widget _alertDialogTitle(Chat chat, BuildContext context) {
    return Row(
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
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                )
              : icons[chat.iconId],
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          chat.title,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Theme.of(context).secondaryHeaderColor,
              ),
        ),
      ],
    );
  }

  Widget _alertDialogContent(Chat chat, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Created',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).secondaryHeaderColor,
                fontWeight: FontWeight.w500,
              ),
        ),
        Text(
          DateFormat('dd.MM.yyyy').format(chat.date!),
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).secondaryHeaderColor,
                fontWeight: FontWeight.normal,
              ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Last event',
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).secondaryHeaderColor,
                fontWeight: FontWeight.w500,
              ),
        ),
        Text(
          chat.lastEventTime != null
              ? '${DateFormat('dd.MM.yyyy').format(chat.lastEventTime!)} at ${DateFormat('hh:mm a').format(chat.lastEventTime!)}'
              : 'No events yet.',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).secondaryHeaderColor,
                fontWeight: FontWeight.normal,
              ),
        ),
      ],
    );
  }

  ListTile _pinOption(BuildContext context, Chat chat) => ListTile(
        leading: const Icon(
          Icons.attach_file,
          color: Colors.greenAccent,
          size: 24,
        ),
        title: Text(
          'Pin/Unpin Page',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white,
              ),
        ),
        onTap: () {
          Navigator.pop(context);
          context.read<HomeCubit>().togglePinState(chat.id);
        },
      );

  ListTile _editOption(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.edit,
        color: Colors.cyan,
        size: 24,
      ),
      title: Text(
        'Edit Page',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white,
            ),
      ),
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                final chat =
                    state.chats.where((Chat chat) => chat.id == _chatId).first;
                return ManagingPage(
                  editingPage: chat,
                  context: context,
                );
              },
            ),
          ),
        );
        Navigator.pop(context);
      },
    );
  }

  ListTile _deleteOption(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.delete,
        color: Colors.redAccent,
        size: 24,
      ),
      title: Text(
        'Delete Page',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white,
            ),
      ),
      onTap: () {
        context.read<HomeCubit>().deleteChat(_chatId);
        Navigator.pop(context);
      },
    );
  }

  List<ListTile> _options(BuildContext context, Chat chat) => [
        _infoOption(context, chat),
        _pinOption(context, chat),
        _editOption(context),
        _deleteOption(context),
      ];

  void _onLongPress(BuildContext context, Chat chat) {
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
          children: _options(context, chat),
        );
      },
    );
  }

  Widget? _chatTileTrailing(Chat chat, BuildContext context) {
    if (chat.lastEventTime != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: chat.isPinned
            ? [
                const Icon(
                  Icons.attach_file,
                  color: Colors.deepPurple,
                ),
                Text(
                  DateFormat('hh:mm a').format(chat.lastEventTime!),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).disabledColor,
                        fontSize: 14,
                      ),
                ),
              ]
            : [
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Text(
                    DateFormat('hh:mm a').format(chat.lastEventTime!),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).disabledColor,
                          fontSize: 14,
                        ),
                  ),
                ),
              ],
      );
    }
    return chat.isPinned
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.attach_file,
                color: Colors.deepPurple,
              ),
            ],
          )
        : null;
  }

  Widget _chatListTile(BuildContext context, Chat chat) {
    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.all(
            Radius.circular(
              Theme.of(context).textTheme.headlineLarge!.fontSize!,
            ),
          ),
        ),
        child: chat.iconId == 0
            ? Center(
                child: Text(
                  chat.title[0].toUpperCase(),
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              )
            : icons[chat.iconId],
      ),
      title: Text(
        chat.title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).secondaryHeaderColor,
            ),
      ),
      subtitle: Text(
        chat.lastEventTitle != '' ? chat.lastEventTitle : 'Label Entry',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).disabledColor,
            ),
      ),
      hoverColor: Colors.deepPurple.shade100,
      trailing: _chatTileTrailing(chat, context),
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              chatId: _chatId,
            ),
          ),
        );
      },
      onLongPress: () {
        _onLongPress(context, chat);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final index =
            state.chats.indexWhere((element) => element.id == _chatId);
        final chat = state.chats[index];
        return _chatListTile(context, chat);
      },
    );
  }
}
