import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/data/storage.dart';
import '../../api/message_repository_api.dart';
import '../../cubit/message_input/message_input_cubit.dart';
import '../../data/message_repository.dart';

class MessageInputScope extends StatelessWidget {
  const MessageInputScope({
    super.key,
    required this.child,
    this.repository,
  });

  final Widget child;
  final MessageRepositoryApi? repository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageInputCubit(
        messageRepository: repository ?? context.read<MessageRepository>(),
        storageProvider: context.read<StorageProvider>(),
      ),
      child: child,
    );
  }

  static MessageInputCubit of(BuildContext context) {
    return context.read<MessageInputCubit>();
  }
}
