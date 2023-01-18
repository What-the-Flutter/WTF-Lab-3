import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/data/chat_repository.dart';
import '../../../common/data/database/chat_database.dart';
import '../cubit/message_manage/message_manage_cubit.dart';
import '../data/message_repository.dart';
import '../widget/app_bar/chat_app_bar.dart';
import '../widget/chat_input/chat_input.dart';
import '../widget/message_list/chat_message_list.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    super.key,
    required this.chatId,
  });

  final int chatId;

  @override
  Widget build(BuildContext context) {
    final chat = context.read<ChatRepository>().chats.value.firstWhere(
          (chat) => chat.id == chatId,
        );

    return BlocProvider(
      create: (context) => MessageManageCubit(
        messageRepository: MessageRepository(
          repository: context.read<ChatDatabase>(),
          chat: chat,
        ),
        chatId: chatId,
        name: chat.name,
      ),
      child: Scaffold(
        appBar: const ChatAppBar(),
        body: Column(
          children: [
            const Expanded(
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
