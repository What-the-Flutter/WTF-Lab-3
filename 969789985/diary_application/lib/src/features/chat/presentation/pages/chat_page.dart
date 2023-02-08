import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/database/chat_database.dart';
import '../../../chat_list/data/repo/chat_repository.dart';
import '../../../chat_list/domain/chat_model.dart';
import '../../data/repo/message_repository.dart';
import '../cubit/message_control/message_control_cubit.dart';
import '../cubit/message_input/message_input_cubit.dart';
import '../cubit/search_control/message_search_cubit.dart';
import '../widget/app_bar/chat_app_bar.dart';
import '../widget/bottom_panel/bottom_panel.dart';
import '../widget/chat_box/chat_body.dart';

class ChatPage extends StatelessWidget {
  final ChatModel chat;

  ChatPage({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MessageControlCubit(
            provider: MessageRepository(
              provider: context.read<ChatDatabase>(),
              chatId: chat.id,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => MessageSearchCubit(
            repository: MessageRepository(
              provider: context.read<ChatDatabase>(),
              chatId: chat.id,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => MessageInputCubit(
            provider: MessageRepository(
              provider: context.read<ChatDatabase>(),
              chatId: chat.id,
            ),
          ),
        ),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: ChatAppBar(
          chat: chat,
        ),
        bottomNavigationBar: BottomPanel(chatId: chat.id),
        body: const ChatBody(),
      ),
    );
  }

  static MessageControlCubit ofControl(BuildContext context) =>
      context.read<MessageControlCubit>();

  static MessageInputCubit ofInput(BuildContext context) =>
      context.read<MessageInputCubit>();

  static MessageSearchCubit ofSearch(BuildContext context) =>
      context.read<MessageSearchCubit>();
}
