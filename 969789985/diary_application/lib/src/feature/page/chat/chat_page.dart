import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/data/datasource/source/message_source.dart';
import '../../../core/data/datasource/source/storage_source.dart';
import '../../../core/data/datasource/source/tag_source.dart';
import '../../../core/data/repository/message/message_repository.dart';
import '../../../core/data/repository/storage/storage_repository.dart';
import '../../../core/data/repository/tag/tag_repository.dart';
import '../../../core/domain/models/local/chat/chat_model.dart';
import '../../cubit/chat/message_control/message_control_cubit.dart';
import '../../cubit/chat/message_input/message_input_cubit.dart';
import '../../cubit/chat/message_search/message_search_cubit.dart';
import '../../widget/chat/app_bar/chat_app_bar.dart';
import '../../widget/chat/bottom_panel/chat_bottom_panel.dart';
import '../../widget/chat/chat_box/chat_body.dart';

class ChatPage extends StatelessWidget {
  final ChatModel chat;

  ChatPage({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return _InitCubits(
      chat: chat,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: ChatAppBar(
          chat: chat,
        ),
        bottomNavigationBar: ChatBottomPanel(chatId: chat.id),
        body: const ChatBody(),
      ),
    );
  }
}

class _InitCubits extends StatelessWidget {
  final ChatModel chat;
  final Widget child;

  const _InitCubits({
    super.key,
    required this.child,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MessageControlCubit(
            repository: MessageRepository(
              provider: RepositoryProvider.of<MessageSource>(context),
              storageProvider: RepositoryProvider.of<StorageSource>(context),
              tagProvider: RepositoryProvider.of<TagSource>(context),
              currentChat: chat,
            ),
            tagRepository: TagRepository(
              provider: RepositoryProvider.of<TagSource>(context),
            ),
            chatId: chat.id,
          ),
        ),
        BlocProvider(
          create: (context) => MessageSearchCubit(
            repository: MessageRepository(
              provider: RepositoryProvider.of<MessageSource>(context),
              storageProvider: RepositoryProvider.of<StorageSource>(context),
              tagProvider: RepositoryProvider.of<TagSource>(context),
              currentChat: chat,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => MessageInputCubit(
            repository: MessageRepository(
              provider: RepositoryProvider.of<MessageSource>(context),
              storageProvider: RepositoryProvider.of<StorageSource>(context),
              tagProvider: RepositoryProvider.of<TagSource>(context),
              currentChat: chat,
            ),
            tagRepository: TagRepository(
              provider: RepositoryProvider.of<TagSource>(context),
            ),
            storageRepository: StorageRepository(
              provider: RepositoryProvider.of<StorageSource>(context),
            ),
          ),
        ),
      ],
      child: child,
    );
  }
}
