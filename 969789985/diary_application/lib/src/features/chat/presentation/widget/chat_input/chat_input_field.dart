import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/values/dimensions.dart';
import '../../cubit/message_input/message_input_cubit.dart';
import '../../cubit/search_control/message_search_cubit.dart';
import 'chat_icon_prefix_icon.dart';
import 'photo_placer/chat_input_photo_placer.dart';
import 'chat_input_send_button.dart';
import 'tag/tag_selector.dart';

class ChatInputField extends StatefulWidget {
  final int chatId;

  ChatInputField({super.key, required this.chatId});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  late final TextEditingController _chatTextFieldController;

  @override
  void initState() {
    _chatTextFieldController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _chatTextFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageInputCubit, MessageInputState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            ChatInputPhotoPlacer(state: state),
            TagSelector(state: state),
            AnimatedContainer(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(Radii.appConstant),
                  topLeft: Radius.circular(Radii.appConstant),
                ),
                color: Theme.of(context).primaryColorLight,
              ),
              duration: const Duration(milliseconds: 200),
              child: TextField(
                controller: _chatTextFieldController,
                onChanged: (value) =>
                    context.read<MessageInputCubit>().onChanged(value),
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: Insets.appConstantLarge,
                    horizontal: Insets.appConstantMedium,
                  ),
                  prefixIcon: const ChatInputPrefixIcon(),
                  suffixIcon: ChatInputSendButton(
                    state: state,
                    action: () {
                      final text = _chatTextFieldController.text;
                      _chatTextFieldController.clear();
                      context.read<MessageInputCubit>().sendMessage(text);
                    },
                  ),
                  hintText: 'Message',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
