import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/data/provider/message_firebase_provider.dart';
import '../../../../common/data/provider/storage_firebase_provider.dart';
import '../../../../common/data/provider/tag_firebase_provider.dart';
import '../../../../common/data/repository/chat_repository.dart';
import '../../../../common/utils/typedefs.dart';
import '../../cubit/move_message/move_messages_cubit.dart';
import '../../data/chat_messages_repository.dart';

class MoveMessagesScope extends StatelessWidget {
  const MoveMessagesScope({
    super.key,
    required this.child,
    required this.fromChatId,
    required this.messages,
  });

  final Widget child;
  final String fromChatId;
  final MessageList messages;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoveMessagesCubit(
        chatRepository: context.read<ChatRepository>(),
        chatMessagesRepository: ChatMessagesRepository(
          messageProvider: context.read<MessageFirebaseProvider>(),
          tagProvider: context.read<TagFirebaseProvider>(),
          storageProvider: context.read<StorageFirebaseProvider>(),
          chat: context.read<ChatRepository>().chats.value.firstWhere(
                (e) => e.id == fromChatId,
              ),
        ),
        fromChatId: fromChatId,
        messages: messages,
      ),
      child: child,
    );
  }

  static MoveMessagesCubit of(BuildContext context) {
    return context.read<MoveMessagesCubit>();
  }
}
