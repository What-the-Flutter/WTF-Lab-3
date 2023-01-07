import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/data/chat_repository.dart';
import '../cubit/chat_search_cubit.dart';
import '../widget/message_items.dart';
import '../widget/search_app_bar.dart';

class ChatSearchPage extends StatelessWidget {
  const ChatSearchPage({super.key, required this.chatId});

  final int chatId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatSearchCubit(
        chatId: chatId,
        repository: context.read<ChatRepository>(),
      ),
      child: const Scaffold(
        appBar: SearchAppBar(),
        body: Align(
          alignment: Alignment.bottomCenter,
          child: MessageItems(),
        ),
      ),
    );
  }
}
