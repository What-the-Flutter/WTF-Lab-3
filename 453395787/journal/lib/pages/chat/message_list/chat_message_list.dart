import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../model/message.dart';
import '../../../utils/insets.dart';
import '../../../utils/radius.dart';
import '../chat_provider.dart';
import 'items/message_item.dart';
import 'items/time_item.dart';

part 'action_menu.dart';

class ChatMessageList extends StatelessWidget {
  ChatMessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chat, child) {
        final messagesWithDates = chat.messagesWithDates.reversed.toList();

        return ListView.builder(
          reverse: true,
          shrinkWrap: true,
          padding: const EdgeInsets.only(
            bottom: Insets.small,
          ),
          itemCount: messagesWithDates.length,
          itemBuilder: (context, index) {
            final item = messagesWithDates[index];
            if (item is String) {
              return TimeItem(text: messagesWithDates[index] as String);
            }

            return MessageItem(
              message: item as Message,
              onTap: (message, isSelected) {
                chat.hasSelected
                    ? chat.toggleSelection(message)
                    : _showActionMenu(context, message, chat);
              },
              onLongPress: (message, isSelected) {
                chat.toggleSelection(message);
              },
              isSelected: chat.isSelected(
                item,
              ),
            );
          },
        );
      },
    );
  }
}
