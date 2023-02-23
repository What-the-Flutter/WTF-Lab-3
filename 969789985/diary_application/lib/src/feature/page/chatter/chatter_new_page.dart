import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import '../../../core/domain/models/local/chat/chat_model.dart';
import '../../../core/util/resources/icons.dart';
import '../../widget/chatter/chatter_variation.dart';

class NewChatScreen extends StatelessWidget {
  const NewChatScreen({super.key});

  @override
  Widget build(BuildContext context) => ChatVariation(
        chat: ChatModel(
          id: '0',
          chatTitle: '',
          chatIcon: possibleIcons.first,
          messages: IList(),
        ),
        isEditMode: false,
      );
}
