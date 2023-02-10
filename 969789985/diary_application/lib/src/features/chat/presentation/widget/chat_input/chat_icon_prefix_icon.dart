import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/values/dimensions.dart';
import '../../cubit/message_input/message_input_cubit.dart';
import 'chat_input_attach_button.dart';

class ChatInputPrefixIcon extends StatelessWidget {
  const ChatInputPrefixIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Insets.small),
      child: SizedBox(
        width: 100.0,
        child: Row(
          children: [
            const ChatInputAttachButton(),
            IconButton(
              onPressed: () =>
                  context.read<MessageInputCubit>().updateTagVisible(),
              icon: const Icon(Icons.tag_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
