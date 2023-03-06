import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/resources/dimensions.dart';
import '../../../../core/util/typedefs.dart';
import '../../../cubit/chat/message_input/message_input_cubit.dart';
import '../../theme/theme_scope.dart';
import 'image_placer/image_placer_box.dart';
import 'message_input_prefix_icon.dart';
import 'message_input_send_button.dart';
import 'tags_placer/tag_selector.dart';

class MessageInputField extends StatefulWidget {
  final FId chatId;

  MessageInputField({super.key, required this.chatId});

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
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
            ImagePlacerBox(state: state),
            TagSelector(
              state: state,
              tags: state.tags,
            ),
            AnimatedContainer(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                    ThemeScope.of(context).state.imagePath == ''
                        ? Radii.appConstant
                        : Radii.none,
                  ),
                  topLeft: Radius.circular(
                    ThemeScope.of(context).state.imagePath == ''
                        ? Radii.appConstant
                        : Radii.none,
                  ),
                ),
                color: Color(ThemeScope.of(context).state.primaryColor),
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
                  prefixIcon: const MessageInputPrefixIcon(),
                  suffixIcon: MessageInputSendButton(
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
