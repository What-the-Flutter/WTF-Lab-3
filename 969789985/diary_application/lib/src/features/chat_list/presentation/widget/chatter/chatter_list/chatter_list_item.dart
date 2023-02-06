import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/values/dimensions.dart';
import '../../../../data/repo/chat_repository.dart';
import '../chatter_card/chatter_card.dart';

class ChatterListItem extends StatelessWidget {
  final int listItemIndex;

  const ChatterListItem({
    super.key,
    required this.listItemIndex,
  });

  @override
  Widget build(BuildContext context) {
    final chat = RepositoryProvider.of<ChatRepository>(context)
        .chats
        .value[listItemIndex - 1];

    return chat.isArchive
        ? Container(
            width: Insets.none,
            height: Insets.none,
          )
        : ChatterCard(chat: chat, isActionsVisible: true);
  }
}
