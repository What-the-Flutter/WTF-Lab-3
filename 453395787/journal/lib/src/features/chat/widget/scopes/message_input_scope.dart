import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/data/provider/storage_firebase_provider.dart';
import '../../../text_tags/text_tags.dart';
import '../../api/chat_messages_repository_api.dart';
import '../../cubit/message_input/message_input_cubit.dart';
import '../../data/chat_messages_repository.dart';

class MessageInputScope extends StatelessWidget {
  const MessageInputScope({
    super.key,
    required this.child,
    this.repository,
  });

  final Widget child;
  final ChatMessagesRepositoryApi? repository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageInputCubit(
        chatMessagesRepository: repository ?? context.read<ChatMessagesRepository>(),
        storageProvider: context.read<StorageFirebaseProvider>(),
        textTagRepository: context.read<TextTagRepository>(),
      ),
      child: child,
    );
  }

  static MessageInputCubit of(BuildContext context) {
    return context.read<MessageInputCubit>();
  }
}
