import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import '../../../../common/values/icons.dart';
import '../../application/chatter_variation.dart';
import '../../domain/chat_model.dart';

class NewChatScreen extends StatelessWidget {
  const NewChatScreen({super.key});

  @override
  Widget build(BuildContext context) => ChatVariation(
        chat: ChatModel(
          id: 0,
          chatTitle: '',
          chatIcon: possibleIcons.first,
          messages: IList(),
        ),
        isEditMode: false,
      );
}
