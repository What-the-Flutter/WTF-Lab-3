import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/values/dimensions.dart';
import '../../../../../common/values/icons.dart';
import '../../cubit/message_input/message_input_cubit.dart';

class ChatInputSendButton extends StatelessWidget {
  final MessageInputState state;
  final void Function() action;

  ChatInputSendButton({
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
            context.read<MessageInputCubit>().sendIcon.toString(),
          ),
          icon: Icon(
            IconData(
              context.read<MessageInputCubit>().sendIcon,
              fontFamily: AppIcons.material,
            ),
          ),
          onPressed: action.call,
        ),
      ),
    );
  }
}
