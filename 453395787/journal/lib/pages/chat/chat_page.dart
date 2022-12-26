import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../chat_repository.dart';
import 'chat_app_bar.dart';
import 'chat_input_field.dart';
import 'chat_message_list.dart';
import 'chat_provider.dart';

class ChatPage extends StatelessWidget {
  final Chat chat;

  const ChatPage({
    required this.chat,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatProvider>(
      create: (_) => ChatProvider(chat),
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
