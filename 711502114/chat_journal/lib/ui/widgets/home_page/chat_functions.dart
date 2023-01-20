import 'package:flutter/material.dart';

import '../../../provider/chat_provider.dart';
import '../../../utils/utils.dart';
import '../../pages/add_chat_page.dart';
import 'info_chat_dialog.dart';

class ChatFunctions {
  final BuildContext context;
  final ChatProvider provider;
  final int index;

  ChatFunctions({
    required this.context,
    required this.provider,
    required this.index,
  });

  void showChatInfo() {
    closePage(context);
    showDialog(
      context: context,
      builder: (_) => InfoChatDialog(chat: provider.chats[index]),
    );
  }

  void pinChat() {
    provider.changePin(index);
    closePage(context);
  }

  void archiveChat() {
    provider.archive(index);
    closePage(context);
  }

  void editChat() {
    closePage(context);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => AddChatPage(
        chat: provider.chats[index],
        chatIndex: index,
      ),
    ));
  }

  void deleteChat() {
    provider.delete(index);
    closePage(context);
  }
}
