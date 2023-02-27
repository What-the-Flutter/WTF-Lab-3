import 'package:flutter/material.dart';

import '../../../../../core/domain/models/local/chat/chat_model.dart';
import '../../../../../core/util/resources/dimensions.dart';
import '../chatter_list_item/chatter_card.dart';

class ChatterListItem extends StatelessWidget {
  final ChatModel chat;

  const ChatterListItem({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return chat.isArchive
        ? Container(
            width: Insets.none,
            height: Insets.none,
          )
        : ChatterCard(chat: chat, isActionsVisible: true);
  }
}
