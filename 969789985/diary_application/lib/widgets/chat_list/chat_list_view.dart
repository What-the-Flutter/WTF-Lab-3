import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/cupertino.dart';

import '../../../basic/models/chat_model.dart';
import 'chat_card.dart';


class HomeListView extends StatelessWidget {
  const HomeListView({super.key, required this.chatsList});

  final IList<ChatModel> chatsList;

  @override
  Widget build(BuildContext context) => Center(
    child: ListView.builder(
      itemCount: chatsList.length,
      itemBuilder: (context, index) {
        return ChatCard(
          chat: chatsList[index],
          isActionsVisible: true,
        );
      },
    ),
  );
}
