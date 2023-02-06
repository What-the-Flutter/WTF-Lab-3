import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/data/provider/message_firebase_provider.dart';
import '../../../common/data/provider/storage_firebase_provider.dart';
import '../../../common/data/provider/tag_firebase_provider.dart';
import '../../../common/data/repository/chat_repository.dart';
import '../cubit/message_manage/message_manage_cubit.dart';
import '../data/chat_messages_repository.dart';
import '../widget/app_bar/chat_app_bar.dart';
import '../widget/chat_input/chat_input.dart';
import '../widget/message_list/chat_message_list.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    super.key,
    required this.chatId,
  });

  final String chatId;

  @override
  Widget build(BuildContext context) {
    final chat = context.read<ChatRepository>().chats.value.firstWhere(
          (chat) => chat.id == chatId,
        );

    return BlocProvider(
      create: (context) => MessageManageCubit(
        chatMessagesRepository: ChatMessagesRepository(
          messageProvider: context.read<MessageFirebaseProvider>(),
          tagProvider: context.read<TagFirebaseProvider>(),
          storageProvider: context.read<StorageFirebaseProvider>(),
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
