import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat_app_bar.dart';
import 'chat_input_field.dart';
import 'chat_message_list.dart';
import 'chat_provider.dart';

class ChatPage extends StatelessWidget {
  final int chatId;

  const ChatPage({
    required this.chatId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatProvider>(
      create: (_) => ChatProvider(chatId),
      child: Scaffold(
        appBar: const ChatAppBar(),
        body: Column(
          children: [
            Expanded(child: ChatMessageList()),
            ChatInput(),
          ],
        ),
      ),
    );
  }
}
