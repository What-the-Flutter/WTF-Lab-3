import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/chat.dart';
import '../../../domain/entities/icon_map.dart';
import '../../../theme/colors.dart';
import '../../../theme/themes.dart';
import '../../widgets/questionnaire_bot.dart';
import '../chat_page/chat_page.dart';
import '../create_chat_page/create_chat_cubit.dart';
import '../create_chat_page/create_chat_page.dart';
import '../settings_page/settings_cubit.dart';
import '../settings_page/settings_state.dart';
import 'home_page_cubit.dart';
import 'home_page_state.dart';

class HomePage extends StatelessWidget {
  final SettingsState settingsState;

  const HomePage({required this.settingsState, super.key});

  TextTheme textTheme(BuildContext context) {
    final fontSize = context.read<SettingsCubit>().state.fontSize;
    switch (fontSize) {
      case 1:
        return Themes.largeTextTheme;
      case -1:
        return Themes.smallTextTheme;
      default:
        return Themes.normalTextTheme;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        return Stack(
          children: [
            Column(
              children: [
                QuestionnaireBotButton(),
                Expanded(
                    child: _journalList(
                        context.watch<HomePageCubit>().state, context)),
              ],
            ),
            _floatingActionButton(context),
          ],
        );
      },
    );
  }

  Widget _journalList(HomePageState state, BuildContext context) {
    return Column(
      children: [
        _divider(),
        Flexible(
          child: ListView.builder(
            itemCount: state.chats.length,
            padding: const EdgeInsets.all(0.0),
            itemBuilder: (context, i) {
              return _chatElement(i, state, context);
            },
          ),
        ),
      ],
    );
  }

  Widget _chatElement(int i, HomePageState state, BuildContext context) {
    final homePageCubit = BlocProvider.of<HomePageCubit>(context);
    final chat = state.chats[i];
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(chat: chat),
          ),
        );
        homePageCubit.updateChats();
      },
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return _chatMenu(i, state, context);
          },
        );
      },
      child: Column(
        children: [
          ListTile(
            title: Text(
              state.chats[i].name,
              style: textTheme(context)
                  .headline4!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              state.chats[i].lastMessage,
              style: textTheme(context).bodyText1!,
            ),
            leading: _chatIcon(state.chats[i], context),
          ),
          _divider(),
        ],
      ),
    );
  }

  Widget _chatIcon(chat, context) {
    final color = BlocProvider.of<SettingsCubit>(context).state.isLightTheme
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

  Widget _chatMenu(int i, HomePageState state, BuildContext context) {
    final chat = state.chats[i];
    return Container(
      height: 250,
      child: Column(
        children: [
          _infoMenuElement(chat, context),
          _chatMenuElement(
              chat, 'Pin/Unpin Page', Icons.pin_drop, Colors.green, context),
          _chatMenuElement(
            chat,
            'Archive Page',
            Icons.archive,
            ChatJournalColors.accentYellow,
            context,
          ),
          _editMenuElement(i, state, context),
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
          chat, 'Info', Icons.info, ChatJournalColors.green, context),
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
            style: textTheme(context).bodyText1!,
          ),
        ],
      ),
      content: Container(
        constraints: const BoxConstraints(maxHeight: 150),
        child: Column(
          children: [
            _chatInfo('Created', chat.creationDate, context),
            _chatInfo(
              'Latest Event',
              chat.lastDate,
              context,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('OK', style: textTheme(context).headline4!),
        ),
      ],
    );
  }

  Widget _chatInfo(String text, DateTime date, BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: textTheme(context).bodyText1!,
      ),
      subtitle: Text(
        DateFormat.yMd().add_jm().format(date),
        style: textTheme(context).bodyText1!,
      ),
    );
  }

  Widget _editMenuElement(i, HomePageState state, BuildContext context) {
    final homePageCubit = BlocProvider.of<HomePageCubit>(context);
    BlocProvider.of<CreateChatCubit>(context).setToEdit(state.chats[i]);
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CreateChatPage(
              chat: state.chats[i],
            ),
          ),
        );
        Navigator.pop(context);
        homePageCubit.updateChats();
      },
      child: _chatMenuElement(
          state.chats[i], 'Edit Page', Icons.edit, Colors.blue, context),
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
        context,
      ),
    );
  }

  Widget _chatMenuElement(
      Chat chat, String name, IconData iconData, Color color, context) {
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
            style: textTheme(context).bodyText1!,
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
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateChatPage(),
            ),
          );
          await homePageCubit.updateChats();
        },
      ),
      duration: const Duration(milliseconds: 300),
      right: 20,
      bottom: 20,
    );
  }
}
