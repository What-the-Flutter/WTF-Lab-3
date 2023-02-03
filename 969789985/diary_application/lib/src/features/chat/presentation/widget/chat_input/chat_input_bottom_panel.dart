import 'package:flutter/material.dart';

import 'chat_input_field.dart';

class ChatInputBottomPanel extends StatelessWidget {
  final int chatId;

  const ChatInputBottomPanel({
    super.key,
    required this.chatId,
  });

  @override
  Widget build(BuildContext context) => ChatInputField(chatId: chatId);
}
