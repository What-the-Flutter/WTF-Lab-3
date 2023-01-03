import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../chat_list_provider.dart';
import 'app_bar/chat_app_bar.dart';
import 'chat_provider.dart';
import 'input_field/chat_input.dart';
import 'message_list/chat_message_list.dart';

class ChatPage extends StatelessWidget {
  final int chatId;

  const ChatPage({
    super.key,
    required this.chatId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatProvider>(
      create: (context) => ChatProvider(
        chatListProvider: Provider.of<ChatListProvider>(context, listen: false,),
        chatId: chatId,
      ),
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
