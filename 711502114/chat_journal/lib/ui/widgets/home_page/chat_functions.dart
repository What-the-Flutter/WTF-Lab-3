import 'package:flutter/material.dart';

import '../../../cubit/home/home_cubit.dart';
import '../../../models/chat.dart';
import '../../../utils/utils.dart';
import '../../pages/add_chat_page.dart';
import 'info_chat_dialog.dart';

class ChatFunctions {
  final BuildContext context;
  final HomeCubit cubit;
  final Chat chat;

  ChatFunctions({
    required this.context,
    required this.cubit,
    required this.chat,
  });

  void showChatInfo() {
    closePage(context);
    showDialog(
      context: context,
      builder: (_) => InfoChatDialog(chat: chat),
    );
  }

  void pinChat() {
    cubit.changePin(chat.id);
    closePage(context);
  }

  void archiveChat() {
    cubit.archive(chat.id);
    closePage(context);
  }

  void editChat() {
    closePage(context);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => AddChatPage(chat: chat),
    ));
  }

  void deleteChat() {
    cubit.delete(chat.id);
    closePage(context);
  }
}
