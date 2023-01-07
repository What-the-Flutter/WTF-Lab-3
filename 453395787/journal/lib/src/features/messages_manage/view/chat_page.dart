import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/data/chat_repository.dart';
import '../../../common/data/message_repository.dart';
import '../../message_input/view/chat_input.dart';
import '../cubit/message_manage_cubit.dart';
import '../widget/app_bar/chat_app_bar.dart';
import '../widget/message_list/chat_message_list.dart';

class ChatPage extends StatelessWidget {
  final int chatId;

  const ChatPage({
    super.key,
    required this.chatId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageManageCubit(
        repository: MessageRepository(
          chatRepository: context.read<ChatRepository>(),
          chatIndex: chatId,
        ),
      ),
      child: Scaffold(
        appBar: const ChatAppBar(),
        body: Column(
          children: [
            Expanded(child: ChatMessageList()),
            ChatInput(chatId: chatId,),
          ],
        ),
      ),
    );
  }
}
