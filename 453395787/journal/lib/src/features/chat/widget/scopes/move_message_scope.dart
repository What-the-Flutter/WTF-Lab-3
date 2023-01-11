import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/data/chat_repository.dart';
import '../../../../common/models/message.dart';
import '../../cubit/move_message/move_messages_cubit.dart';

class MoveMessagesScope extends StatelessWidget {
  const MoveMessagesScope({
    super.key,
    required this.child,
    required this.fromChatId,
    required this.messages,
  });

  final Widget child;
  final int fromChatId;
  final IList<Message> messages;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoveMessagesCubit(
        repository: context.read<ChatRepository>(),
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
