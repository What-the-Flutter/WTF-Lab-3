import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/models/local/chat/chat_model.dart';
import '../../../../../core/util/resources/dimensions.dart';
import '../../../../cubit/chat/message_resend/message_resend_cubit.dart';

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
        value: state.selectedChats.containsKey(int.tryParse(chat.id)!)
            ? state.selectedChats[int.tryParse(chat.id)!]
            : false,
        onChanged: (value) {
          context.read<MessageResendCubit>().updateChatSelection(int.tryParse(chat.id)!);
        },
      ),
    );
  }
}
