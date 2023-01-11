import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/data/chat_repository.dart';
import '../cubit/message_manage/message_manage_cubit.dart';
import '../data/message_repository.dart';
import '../widget/app_bar/chat_app_bar.dart';
import '../widget/chat_input/chat_input.dart';
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
          repository: context.read<ChatRepository>(),
          chatId: chatId,
        ),
      ),
      child: Scaffold(
        appBar: const ChatAppBar(),
        body: Column(
          children: [
            Expanded(
              child: ChatMessageList(),
            ),
            ChatInput(
              chatId: chatId,
            ),
          ],
        ),
      ),
    );
  }
}
