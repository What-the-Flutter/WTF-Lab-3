import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/values/dimensions.dart';
import '../../../domain/message_model.dart';
import '../../cubit/message_control/message_control_cubit.dart';

class MessageCheckbox extends StatelessWidget {
  final MessageModel message;

  const MessageCheckbox({
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
        );
      },
    );
  }
}
