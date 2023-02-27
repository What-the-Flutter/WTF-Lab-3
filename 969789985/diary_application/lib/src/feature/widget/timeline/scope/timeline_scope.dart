import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/datasource/source/chat_source.dart';
import '../../../../core/data/datasource/source/message_source.dart';
import '../../../../core/data/datasource/source/storage_source.dart';
import '../../../../core/data/datasource/source/tag_source.dart';
import '../../../../core/data/repository/chat/chat_repository.dart';
import '../../../../core/data/repository/message/message_repository.dart';
import '../../../../core/domain/models/local/chat/chat_model.dart';
import '../../../cubit/timeline/timeline_cubit.dart';

class TimelineScope extends StatelessWidget {
  final Widget child;

  const TimelineScope({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimelineCubit(
        repository: MessageRepository(
          provider: RepositoryProvider.of<MessageSource>(context),
          storageProvider: RepositoryProvider.of<StorageSource>(context),
          tagProvider: RepositoryProvider.of<TagSource>(context),
          currentChat: ChatModel(chatIcon: 0),
        ),
        chatRepository: ChatRepository(
          provider: RepositoryProvider.of<ChatSource>(context),
        ),
      ),
      child: child,
    );
  }

  static TimelineCubit of(BuildContext context) =>
      context.read<TimelineCubit>();
}
