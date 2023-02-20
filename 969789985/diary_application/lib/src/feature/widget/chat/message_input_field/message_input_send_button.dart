import 'package:flutter/material.dart';

import '../../../../core/util/resources/dimensions.dart';
import '../../../cubit/chat/message_input/message_input_cubit.dart';

class MessageInputSendButton extends StatelessWidget {
  final MessageInputState state;
  final void Function() action;

  MessageInputSendButton({
    super.key,
    required this.state,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Insets.medium),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 150),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: IconButton(
          key: ValueKey<String>(
            state.message.messageText.isNotEmpty ? 'Send' : 'Mic',
          ),
          icon: Icon(
            state.message.messageText.isEmpty && state.message.images.isEmpty
                ? Icons.mic
                : Icons.send,
          ),
          onPressed: action.call,
        ),
      ),
    );
  }
}
