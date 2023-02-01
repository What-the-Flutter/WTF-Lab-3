import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/message_input/message_input_cubit.dart';
import 'photo_placer/chat_input_float_bottom_sheet.dart';

class ChatInputAttachButton extends StatefulWidget {
  const ChatInputAttachButton({super.key});

  @override
  State<ChatInputAttachButton> createState() => _ChatInputAttachButtonState();
}

class _ChatInputAttachButtonState extends State<ChatInputAttachButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageInputCubit, MessageInputState>(
      builder: (blocContext, state) {
        return AnimatedScale(
          duration: const Duration(milliseconds: 200),
          scale: _scale,
          child: IconButton(
            onPressed: () => _showFloatBottomSheet(context, blocContext),
            icon: const Icon(Icons.attach_file),
          ),
        );
      },
    );
  }

  void _showFloatBottomSheet(BuildContext context, BuildContext blocContext) {
    setState(() => _scale = 0.0);

    showModalBottomSheet(
      context: context,
      elevation: 0,
      barrierColor: Colors.transparent,
      builder: (context) => ChatInputFloatBottomSheet(
        blocContext: blocContext,
      ),
    ).whenComplete(() => setState(() => _scale = 1.0));
  }
}
