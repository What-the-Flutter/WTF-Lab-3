import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/models/local/message/message_model.dart';
import '../../../../core/util/resources/dimensions.dart';
import '../../../cubit/chat/message_control/message_control_cubit.dart';

class MessageSelectionCheckbox extends StatelessWidget {
  final MessageModel message;

  const MessageSelectionCheckbox({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageControlCubit, MessageControlState>(
      builder: (context, state) {
        return AnimatedSlide(
          duration: const Duration(milliseconds: 200),
          offset: state.isSelectMode && !state.isEditMode
              ? const Offset(0.0, 0.0)
              : const Offset(-1.0, 0.0),
          curve: state.isSelectMode ? Curves.decelerate : Curves.fastOutSlowIn,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: state.isSelectMode && !state.isEditMode ? 1 : 0,
            child: Visibility(
              visible: state.selectionVisible,
              child: Checkbox(
                value: state.selected.containsKey(message.id)
                    ? state.selected[message.id]
                    : false,
                onChanged: (value) =>
                    context.read<MessageControlCubit>().selectOne(message),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Radii.medium),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
