import 'package:flutter/material.dart';

import '../widget/chatter/chatter_variation.dart';
import '../../domain/chat_model.dart';

class EditChatScreen extends StatelessWidget {
  final ChatModel chat;

  EditChatScreen({super.key, required this.chat});

  @override
  Widget build(BuildContext context) => ChatVariation(
        chat: chat,
        isEditMode: true,
      );
}
