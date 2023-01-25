import 'package:flutter/material.dart';

import '../../../basic/models/chat_model.dart';
import '../../../widgets/chat_list/chat_variation.dart';

class EditChatScreen extends StatelessWidget {
  final ChatModel chat;

  EditChatScreen({super.key, required this.chat});

  @override
  Widget build(BuildContext context) => ChatVariation(
        chat: chat,
        isEditMode: true,
      );
}
