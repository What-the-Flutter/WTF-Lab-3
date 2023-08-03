import 'package:carbon_icons/carbon_icons.dart';
import 'package:diary_app/data/all_icons.dart';
import 'package:diary_app/data/repositories/local_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import 'package:diary_app/custom_theme.dart';
import 'package:diary_app/domain/entities/chat.dart';
import 'package:diary_app/presentation/pages/chat_page/chat_cubit.dart';
import 'package:diary_app/presentation/pages/chat_page/chat_page.dart';
import 'package:diary_app/presentation/pages/create_chat/create_chat.dart';
import 'package:diary_app/presentation/pages/home_page/chat_list_cubit.dart';
import 'package:diary_app/presentation/pages/home_page/chat_list_state.dart';
import 'package:diary_app/presentation/widgets/question_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _content(context),
        _fab(context),
      ],
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      children: [
        QuestionButton(
          onPressed: () {},
        ),
        Expanded(
          child: NotificationListener<UserScrollNotification>(
            onNotification: ((notification) {
              final ScrollDirection direction = notification.direction;
              if (direction == ScrollDirection.reverse) {
                if (_isVisible == true) {
                  setState(() => _isVisible = false);
                }
              } else if (direction == ScrollDirection.forward) {
                if (_isVisible == false) {
                  setState(() => _isVisible = true);
                }
              }
              return true;
            }),
            child: _chats(),
          ),
        ),
      ],
    );
  }

  Widget _chats() {
    return BlocBuilder<ChatListCubit, ChatListChanged>(
      builder: (context, state) {
        final chats = state.chats;

        return ListView.separated(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            final chatData = chats[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                ),
                onLongPress: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => _bottomSheet(index, BlocProvider.of<ChatListCubit>(context)),
                  );
                },
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return BlocProvider(
                        create: (context) => ChatCubit(
                          chatData.id,
                          GetIt.I.get<LocalRepository>(),
                        ),
                        child: ChatPage(
                          chats: state.chats,
                          title: chatData.title,
                          chatId: chatData.id,
                        ),
                      );
                    }),
                  );
                },
                child: _chatContent(chatData),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.black,
            );
          },
        );
      },
    );
  }

  Widget _chatContent(Chat chatData) {
    return ListTile(
      leading: Icon(
        chatData.icon,
        size: 30,
      ),
      title: Text(
        chatData.title + (chatData.isPinned ? ' 📌' : ''),
        style: TextStyle(
          color:
              CustomTheme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
        ),
      ),
      subtitle: Text(
        chatData.lastMessage ?? 'No events. Click to create one',
        style: TextStyle(
          color:
              CustomTheme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
        ),
      ),
      trailing: Text(
        chatData.updatedAt != null
            ? DateFormat('hh:mm a').format(chatData.updatedAt!).toString()
            : '',
        style: TextStyle(
          color:
              CustomTheme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _bottomSheet(int index, ChatListCubit bloc) {
    return Wrap(
      children: [
        _infoButton(index, bloc),
        _pinUnpinButton(index, bloc),
        _archiveButton(index, bloc),
        _editButton(index, bloc),
        _deleteButton(index, bloc),
      ],
    );
  }

  Widget _infoButton(int index, ChatListCubit bloc) {
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<ChatListCubit, ChatListChanged>(
        builder: (context, state) {
          return TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
            ),
            onPressed: () {
              final chat = state.chats[index];
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return _dialog(chat);
                },
              );
            },
            child: ListTile(
              leading: const Icon(CarbonIcons.information),
              title: Text(
                'Info',
                style: TextStyle(
                  color: CustomTheme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _dialog(Chat chat) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(chat.icon),
          const SizedBox(width: 7),
          Text(
            chat.title,
            style: TextStyle(
              color: CustomTheme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ],
      ),
      content: _dialogContent(chat),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }

  Widget _dialogContent(Chat chat) {
    return Wrap(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Created at:\n${DateFormat('hh:mm a').format(chat.createdAt)}',
              style: TextStyle(
                color: CustomTheme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Last updated at:\n${chat.updatedAt != null ? DateFormat('hh:mm a').format(chat.updatedAt!) : 'No messages yet'}',
              style: TextStyle(
                color: CustomTheme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _pinUnpinButton(int index, ChatListCubit bloc) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
      ),
      onPressed: () async {
        await bloc.pinUnpinChat(index);
        if (mounted) Navigator.of(context).pop();
      },
      child: ListTile(
        leading: const Icon(
          CarbonIcons.pin,
          color: Colors.green,
        ),
        title: Text(
          'Pin/Unpin Chat',
          style: TextStyle(
            color:
                CustomTheme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _archiveButton(int index, ChatListCubit bloc) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
      ),
      onPressed: () => Navigator.of(context).pop(),
      child: ListTile(
        leading: const Icon(
          CarbonIcons.save,
          color: Colors.orange,
        ),
        title: Text(
          'Archive Chat',
          style: TextStyle(
            color:
                CustomTheme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _editButton(int index, ChatListCubit bloc) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
      ),
      onPressed: () async {
        final chatData = bloc.getChatData(index);

        Chat? result = await Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => CreateChat(
                  prevChatIcon: chatData.icon,
                  prevChatName: chatData.title,
                  title: 'Edit chat',
                ))) as Chat?;

        if (!mounted) return;

        await bloc.editChat(result, index);
        if (mounted) Navigator.of(context).pop();
      },
      child: ListTile(
        leading: const Icon(
          CarbonIcons.edit,
          color: Colors.blue,
        ),
        title: Text(
          'Edit Chat',
          style: TextStyle(
            color:
                CustomTheme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _deleteButton(int index, ChatListCubit bloc) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
      ),
      onPressed: () async {
        await bloc.removeChat(index);
        if (mounted) Navigator.of(context).pop();
      },
      child: ListTile(
        leading: const Icon(
          CarbonIcons.trash_can,
          color: Colors.red,
        ),
        title: Text(
          'Delete Chat',
          style: TextStyle(
            color:
                CustomTheme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _fab(BuildContext context) {
    return AnimatedPositioned(
      right: _isVisible ? 15 : -100,
      bottom: 15,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: FloatingActionButton(
        splashColor: Colors.yellowAccent,
        backgroundColor: Colors.yellow.shade700,
        onPressed: () async {
          Chat? result = await Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => CreateChat(
                    prevChatIcon: allIcons[0],
                    prevChatName: '',
                    title: 'Create new chat',
                  ))) as Chat?;

          if (!mounted) return;
          await BlocProvider.of<ChatListCubit>(context).addChat(result);
        },
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.black,
        ),
      ),
    );
  }
}
