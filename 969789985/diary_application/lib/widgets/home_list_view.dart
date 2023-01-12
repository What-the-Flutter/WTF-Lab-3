import 'package:flutter/cupertino.dart';

import '../../basic/models/chat_model.dart';
import 'home_list_view_card.dart';

class HomeListView extends StatelessWidget{
  const HomeListView({super.key, required this.chatsList});

  final List<ChatModel> chatsList;

  @override
  Widget build(BuildContext context) => Center(
    child: ListView.builder(
      itemCount: chatsList.length,
      itemBuilder: (context, index) {
        return HomeListViewCard(chat: chatsList[index]);
      },
    ),
  );
}
