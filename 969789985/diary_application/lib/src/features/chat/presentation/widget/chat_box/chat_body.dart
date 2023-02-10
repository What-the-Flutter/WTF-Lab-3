import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/utils/strings.dart';
import '../../cubit/message_control/message_control_cubit.dart';
import '../../cubit/search_control/message_search_cubit.dart';
import 'empty_message.dart';
import 'message_list.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageControlCubit, MessageControlState>(
      builder: (context, state) {
        return state.messages.isEmpty
            ? const EmptyMessage(message: Strings.chatEmptyMessage)
            : BlocBuilder<MessageSearchCubit, MessageSearchState>(
                builder: (context, state) {
                  return MessageList(messages: state.messages);
                },
              );
      },
    );
  }
}
