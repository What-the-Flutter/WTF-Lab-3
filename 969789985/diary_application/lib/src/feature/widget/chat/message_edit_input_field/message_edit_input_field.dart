import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/resources/dimensions.dart';
import '../../../cubit/chat/message_control/message_control_cubit.dart';
import '../../../cubit/chat/message_input/message_input_cubit.dart';

class MessageEditInputField extends StatefulWidget {
  final String editText;

  MessageEditInputField({
    super.key,
    required this.editText,
  });

  @override
  State<MessageEditInputField> createState() => _MessageEditInputFieldState();
}

class _MessageEditInputFieldState extends State<MessageEditInputField> {
  late final TextEditingController _editTextFieldController;

  @override
  void initState() {
    _editTextFieldController = TextEditingController();
    _editTextFieldController.text = widget.editText;

    super.initState();
  }

  @override
  void dispose() {
    _editTextFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageControlCubit, MessageControlState>(
      builder: (inContext, state) {
        return AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(Radii.appConstant),
              topLeft: Radius.circular(Radii.appConstant),
            ),
            color: Theme.of(context).cardColor,
          ),
          duration: const Duration(milliseconds: 200),
          child: TextField(
            controller: _editTextFieldController,
            autofocus: true,
            minLines: 1,
            maxLines: 5,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                vertical: Insets.appConstantLarge,
                horizontal: Insets.appConstantMedium,
              ),
              prefixIcon: _prefixIcon(),
              suffixIcon: _suffixIcon(inContext),
            ),
          ),
        );
      },
    );
  }

  Widget _prefixIcon() => Padding(
        padding: const EdgeInsets.only(
          left: Insets.small,
          right: Insets.small,
        ),
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.new_label_outlined),
        ),
      );

  Widget _suffixIcon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Insets.medium),
      child: IconButton(
        onPressed: () {
          context
              .read<MessageControlCubit>()
              .editMessage(_editTextFieldController.text);
          _editTextFieldController.clear();
          context.read<MessageControlCubit>().unselectAll();
        },
        icon: const Icon(Icons.check),
      ),
    );
  }
}
