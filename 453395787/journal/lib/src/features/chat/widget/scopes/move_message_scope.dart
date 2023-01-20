import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/data/chat_repository.dart';
import '../../../../common/data/database/database.dart';
import '../../../../common/utils/typedefs.dart';
import '../../api/message_repository_api.dart';
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
        chatRepositoryApi: context.read<ChatRepository>(),
        messageRepositoryApi: MessageRepository(
          messageProviderApi: context.read<Database>(),
          tagProviderApi: context.read<Database>(),
          chat: context.read<Database>().chats.value.firstWhere(
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
