import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../chat_list/domain/chat_model.dart';
import '../../cubit/message_control/message_control_cubit.dart';
import 'chat_app_bar_actions.dart';
import 'chat_app_bar_leading.dart';
import 'chat_app_bar_title.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ChatModel chat;

  ChatAppBar({
    super.key,
    required this.chat,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageControlCubit, MessageControlState>(
      builder: (context, state) {
        return AppBar(
          title: ChatAppBarTitle(chatTitle: chat.chatTitle),
          centerTitle: false,
          leading: const ChatAppBarLeading(),
          actions: [
            ChatAppBarActions(
              currentChatId: chat.id,
              state: state,
            ),
          ],
        );
      },
    );
  }
}
