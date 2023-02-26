import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/typedefs.dart';
import '../../../cubit/chat/message_control/message_control_cubit.dart';
import '../message_edit_input_field/message_edit_input_field.dart';
import '../message_input_field/message_input_field.dart';

class ChatBottomPanel extends StatelessWidget {
  final FId chatId;

  const ChatBottomPanel({
    super.key,
    required this.chatId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageControlCubit, MessageControlState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: state.isEditMode
              ? MessageEditInputField(editText: state.message.messageText)
              : MessageInputField(chatId: chatId),
        );
      },
    );
  }
}
