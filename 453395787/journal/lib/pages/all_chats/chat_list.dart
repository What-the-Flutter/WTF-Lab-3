import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../chat_list_provider.dart';
import '../../chat_repository.dart';
import '../../utils/styles.dart';
import '../chat/chat_page.dart';
import 'bottom_action_sheet.dart';

class ChatList extends StatelessWidget {
  ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatListProvider>(
      builder: (context, chatList, child) => ListView.builder(
        itemCount: chatList.repository.chats.length,
        itemBuilder: (_, index) => ChatItem(
          chat: chatList.repository.orderedChats[index],
        ),
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  final Chat chat;

  const ChatItem({
    required this.chat,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Insets.small,
        horizontal: Insets.large,
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radius.large),
        ),
        tileColor: chat.isPinned
            ? Theme.of(context).colorScheme.primary.withOpacity(0.15)
            : null,
        leading: Icon(
          chat.icon,
        ),
        title: Text(
          chat.name,
        ),
        subtitle: chat.lastMessage != null
            ? Text(
                chat.lastMessage!.text,
              )
            : null,
        trailing: chat.lastMessage != null
            ? Text(
                chat.lastMessage!.time,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              )
            : null,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChatPage(
                chatId: chat.id,
              ),
            ),
          );
        },
        onLongPress: () {
          showFloatingModalBottomSheet(
            context: context,
            builder: ((context) {
              return BottomActionSheet(
                chat: chat,
              );
            }),
          );
        },
      ),
    );
  }
}
