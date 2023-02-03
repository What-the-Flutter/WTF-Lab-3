import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../../common/values/dimensions.dart';
import '../../../../../common/widget/custom_dialog.dart';
import '../../../../../utils/strings.dart';
import '../../../domain/message_model.dart';
import '../../cubit/message_control/message_control_cubit.dart';
import '../message/message_card.dart';

class MessageListItem extends StatelessWidget {
  final MessageModel message;

  const MessageListItem({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: message.id,
      duration: const Duration(milliseconds: 200),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Align(
            alignment: Alignment.centerRight,
            child: Slidable(
              endActionPane: ActionPane(
                motion: const BehindMotion(),
                extentRatio: 0.35,
                children: [
                  SlidableAction(
                    spacing: 0.0,
                    borderRadius: BorderRadius.circular(Radii.circle),
                    onPressed: (_) {
                      context
                          .read<MessageControlCubit>()
                          .startEditModeFromDismissible(message);
                    },
                    icon: Icons.edit,
                  ),
                  const SizedBox(width: Insets.small),
                  SlidableAction(
                    spacing: 0.0,
                    borderRadius: BorderRadius.circular(Radii.circle),
                    onPressed: (_) {
                      showDialog(
                        context: context,
                        builder: (_) => CustomDialog(
                          dialogTitle: Strings.deleteSelectedMessagesTitle,
                          dialogDescription: const Text(
                            Strings.deleteSelectedMessagesDescription,
                          ),
                          completeAction: () {
                            context
                                .read<MessageControlCubit>()
                                .removeOne(message);
                          },
                          cancelVisible: true,
                        ),
                      );
                    },
                    icon: Icons.delete,
                  ),
                ],
              ),
              closeOnScroll: true,
              child: MessageCard(
                message: message,
                longPressAction: () {
                  context.read<MessageControlCubit>().selectOne(message);
                },
                pressedAction: () {
                  context.read<MessageControlCubit>().state.isSelectMode
                      ? context.read<MessageControlCubit>().selectOne(message)
                      : {};
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
