import 'package:diary_application/domain/models/chat.dart';
import 'package:diary_application/domain/utils/utils.dart';
import 'package:diary_application/presentation/pages/creation/add_chat_page.dart';
import 'package:diary_application/presentation/pages/home/home_cubit.dart';
import 'package:flutter/material.dart';

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
      builder: (_) => AddChatPage(editChat: chat),
    ));
  }

  void deleteChat() {
    cubit.delete(chat.id);
    closePage(context);
  }
}
