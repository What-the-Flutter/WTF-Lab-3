import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/chats_cubit.dart';
import '../../model/chat.dart';
import '../../model/chats_state.dart';
import '../../themes/custom_theme.dart';
import '../add_chat_page/add_chat_page.dart';
import 'bottom_navigation.dart';
import 'chat_card.dart';

class HomePage extends StatelessWidget {
  final String appName;

  const HomePage({super.key, required this.appName});

  List<ChatCard> _createChatCards(
    List<Chat> chats,
    Map<int, bool> pinnedChats,
  ) {
    final chatCards = <ChatCard>[];

    for (var i = 0; i < chats.length; i++) {
      final chatCard = ChatCard(
        chatIndex: i,
        isPinned: pinnedChats[i] ?? false,
      );

      if (chatCard.isPinned == true) {
        chatCards.insert(0, chatCard);
      } else {
        chatCards.add(chatCard);
      }
    }

    return chatCards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => print('Click to menu'),
        ),
        title: Text(appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.color_lens_outlined),
            onPressed: () => CustomTheme.instanceOf(context).chooseNextTheme(),
          ),
        ],
      ),
      body: BlocBuilder<ChatsCubit, ChatsState>(builder: (context, state) {
        final chatCards = _createChatCards(state.chats, state.pinnedChats);

        return ListView.builder(
          itemCount: chatCards.length,
          itemBuilder: (context, index) => chatCards[index],
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AddChatPage(),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
