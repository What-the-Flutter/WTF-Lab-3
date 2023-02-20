import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/resources/dimensions.dart';
import '../../../cubit/chat/message_input/message_input_cubit.dart';
import 'message_input_attach_button.dart';

class MessageInputPrefixIcon extends StatelessWidget {
  const MessageInputPrefixIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Insets.small),
      child: SizedBox(
        width: 100.0,
        child: Row(
          children: [
            const MessageInputAttachButton(),
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
