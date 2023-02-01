import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../models/chat.dart';
import '../../models/event.dart';
import '../../models/icon_map.dart';
import '../../theme/colors.dart';
import '../../theme/fonts.dart';
import '../../theme/theme_cubit.dart';
import '../../theme/theme_state.dart';
import '../../widgets/questionnaire_bot.dart';
import '../chat_page/chat_page.dart';
import '../chat_page/chat_page_cubit.dart';
import '../create_chat_page/create_chat_cubit.dart';
import '../create_chat_page/create_chat_page.dart';
import 'home_page_cubit.dart';
import 'home_page_state.dart';

final _chats = <Chat>[
  Chat(
      id: 0,
      name: 'Travel',
      iconIndex: 0,
      creationDate: DateTime.now().subtract(const Duration(days: 1)),
      events: []),
  Chat(
    id: 1,
    name: 'Family',
    iconIndex: 1,
    creationDate: DateTime.now().subtract(const Duration(days: 2)),
    events: [
      Event(
          text: 'My Family',
          dateTime: DateTime.now().subtract(const Duration(hours: 24))),
      Event(text: 'My big big family', dateTime: DateTime.now()),
    ],
  ),
  Chat(
      id: 2,
      name: 'Sport',
      iconIndex: 2,
      events: [],
      creationDate: DateTime.now().subtract(const Duration(days: 3))),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  children: [
                    QuestionnaireBotButton(),
                    Expanded(child: _journalList(context)),
                  ],
                ),
                _floatingActionButton(context),
              ],
            );
          },
        );
      },
    );
  }

  Widget _journalList(BuildContext context) {
    final homePageCubit = BlocProvider.of<HomePageCubit>(context);
    return Column(
      children: [
        _divider(),
        Flexible(
          child: ListView.builder(
            itemCount: homePageCubit.state.chats.length,
            padding: const EdgeInsets.all(0.0),
            itemBuilder: (context, i) {
              return _chatElement(i, context);
            },
          ),
        ),
      ],
    );
  }

  Widget _chatElement(int i, context) {
    final homePageCubit = BlocProvider.of<HomePageCubit>(context);
    return GestureDetector(
      onTap: () async {
        BlocProvider.of<ChatCubit>(context)
            .loadEvents(homePageCubit.state.chats[i].events);
        final Chat newChat = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(chat: homePageCubit.state.chats[i]),
          ),
        );
        homePageCubit.updateChats(newChat, i);
        homePageCubit.sortChats();
      },
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return _chatMenu(i, context);
          },
        );
      },
      child: Column(
        children: [
          ListTile(
            title: Text(
              homePageCubit.state.chats[i].name,
              style: Fonts.mainPageChatTitle,
            ),
            subtitle: Text(
              homePageCubit.state.chats[i].events.isNotEmpty
                  ? homePageCubit.state.chats[i].events.last.text
                  : 'No events, Click to create one',
            ),
            leading: _chatIcon(homePageCubit.state.chats[i], context),
          ),
          _divider(),
        ],
      ),
    );
  }

  Widget _chatIcon(chat, context) {
    final color = BlocProvider.of<ThemeCubit>(context).isLight()
        ? Colors.blueGrey
        : ChatJournalColors.lightGrey;
    return SizedBox(
      width: 50,
      height: 50,
      child: Ink(
        decoration: ShapeDecoration(
          color: color,
          shape: const CircleBorder(),
        ),
        child: Icon(
          ChatJournalIcons.chatIcons[chat.iconIndex],
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _divider() {
    return const Divider(
      color: Colors.grey,
      thickness: 1,
    );
  }

  Widget _chatMenu(int i, context) {
    final homePageCubit = BlocProvider.of<HomePageCubit>(context);
    final chat = homePageCubit.state.chats[i];
    return Container(
      height: 250,
      child: Column(
        children: [
          _infoMenuElement(chat, context),
          _chatMenuElement(
            chat,
            'Pin/Unpin Page',
            Icons.pin_drop,
            Colors.green,
          ),
          _chatMenuElement(
            chat,
            'Archive Page',
            Icons.archive,
            ChatJournalColors.accentYellow,
          ),
          _editMenuElement(i, context),
          _deleteMenuElement(chat, context),
        ],
      ),
    );
  }

  Widget _infoMenuElement(Chat chat, context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return _infoModal(chat, context);
          },
        );
      },
      child: _chatMenuElement(
        chat,
        'Info',
        Icons.info,
        ChatJournalColors.green,
      ),
    );
  }

  Widget _infoModal(Chat chat, context) {
    return AlertDialog(
      title: Row(
        children: [
          _chatIcon(chat, context),
          const SizedBox(width: 10),
          Text(
            chat.name,
            style: Fonts.createChatTitle,
          ),
        ],
      ),
      content: Container(
        constraints: const BoxConstraints(maxHeight: 150),
        child: Column(
          children: [
            _chatInfo('Created', chat.creationDate),
            _chatInfo(
              'Latest Event',
              chat.events.isNotEmpty
                  ? chat.events.last.dateTime
                  : chat.creationDate,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('OK', style: Fonts.chatMenuFont),
        ),
      ],
    );
  }

  Widget _chatInfo(String text, DateTime date) {
    return ListTile(
      title: Text(
        text,
        style: Fonts.eventFont,
      ),
      subtitle: Text(
        DateFormat.yMd().add_jm().format(date),
      ),
    );
  }

  Widget _editMenuElement(i, context) {
    final homePageCubit = BlocProvider.of<HomePageCubit>(context);
    BlocProvider.of<CreateChatCubit>(context)
        .setToEdit(homePageCubit.state.chats[i]);
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CreateChatPage(
              isCreatingMode: false,
              initialText: homePageCubit.state.chats[i].name,
              iconIndex: homePageCubit.state.chats[i].iconIndex,
            ),
          ),
        );
        if (result != null) {
          homePageCubit.updateChats(result, i);
        }
        Navigator.pop(context);
      },
      child: _chatMenuElement(
        homePageCubit.state.chats[i],
        'Edit Page',
        Icons.edit,
        Colors.blue,
      ),
    );
  }

  Widget _deleteMenuElement(Chat chat, context) {
    final homePageCubit = BlocProvider.of<HomePageCubit>(context);
    return GestureDetector(
      onTap: () {
        homePageCubit.deleteChat(chat);
        Navigator.pop(context);
      },
      child: _chatMenuElement(
        chat,
        'Delete Page',
        Icons.delete,
        ChatJournalColors.lightRed,
      ),
    );
  }

  Widget _chatMenuElement(
      Chat chat, String name, IconData iconData, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            color: color,
            size: 30,
          ),
          const SizedBox(width: 30),
          Text(
            name,
            style: Fonts.chatMenuFont,
          )
        ],
      ),
    );
  }

  Widget _floatingActionButton(context) {
    final homePageCubit = BlocProvider.of<HomePageCubit>(context);
    return AnimatedPositioned(
      child: FloatingActionButton(
        child: const Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () async {
          final newChat = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateChatPage(isCreatingMode: true),
              ));
          if (newChat != null) {
            homePageCubit.addChat(newChat);
            homePageCubit.sortChats();
          }
        },
      ),
      duration: const Duration(milliseconds: 300),
      right: 20,
      bottom: 20,
    );
  }
}
