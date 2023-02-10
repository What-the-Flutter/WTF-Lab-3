import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/message_control/message_control_cubit.dart';
import '../chat_edit_input/chat_edit_input_field.dart';
import '../chat_input/chat_input_bottom_panel.dart';
import '../chat_input/chat_input_field.dart';

class BottomPanel extends StatelessWidget {
  final int chatId;

  const BottomPanel({
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
              ? ChatEditInputField(editText: state.message.messageText)
              : ChatInputBottomPanel(chatId: chatId),
        );
      },
    );
  }
}
