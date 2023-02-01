import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/values/dimensions.dart';
import '../../../../../chat_list/domain/chat_model.dart';
import '../../../cubit/message_resend/message_resend_cubit.dart';

class ChatSelectionCheckbox extends StatelessWidget {
  final MessageResendState state;
  final ChatModel chat;

  const ChatSelectionCheckbox({
    super.key,
    required this.state,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Insets.small),
      child: Checkbox(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.medium),
        ),
        value: state.selectedChats.containsKey(chat.id)
            ? state.selectedChats[chat.id]
            : false,
        onChanged: (value) {
          context.read<MessageResendCubit>().updateChatSelection(chat.id);
        },
      ),
    );
  }
}
