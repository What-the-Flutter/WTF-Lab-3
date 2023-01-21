import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/data/chat_repository.dart';
import '../../../../common/data/database/database.dart';
import '../../../../common/data/storage.dart';
import '../../../../common/models/ui/message.dart';
import '../../../../common/utils/typedefs.dart';
import '../../cubit/move_message/move_messages_cubit.dart';
import '../../data/message_repository.dart';

class MoveMessagesScope extends StatelessWidget {
  const MoveMessagesScope({
    super.key,
    required this.child,
    required this.fromChatId,
    required this.messages,
  });

  final Widget child;
  final Id fromChatId;
  final MessageList messages;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoveMessagesCubit(
        chatRepository: context.read<ChatRepository>(),
        messageRepository: MessageRepository(
          messageProvider: context.read<Database>(),
          tagProvider: context.read<Database>(),
          storageProvider: context.read<StorageProvider>(),
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
