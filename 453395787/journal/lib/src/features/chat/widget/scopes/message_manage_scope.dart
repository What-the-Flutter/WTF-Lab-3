import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/models/ui/chat.dart';
import '../../cubit/message_manage/message_manage_cubit.dart';
import '../../data/chat_messages_repository.dart';

class MessageManageScope extends StatelessWidget {
  const MessageManageScope({
    super.key,
    required this.child,
    required this.chat,
  });

  final Widget child;
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageManageCubit(
        messageRepository: context.read<ChatMessagesRepository>(),
        chatId: chat.id,
        name: chat.name,
      ),
      child: child,
    );
  }

  static MessageManageCubit of(BuildContext context) {
    return context.read<MessageManageCubit>();
  }
}
