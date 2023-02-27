import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../core/data/repository/theme/theme_repository.dart';
import '../../../../core/domain/models/local/message/message_model.dart';
import '../../../../core/util/resources/dimensions.dart';
import '../../../../core/util/resources/strings.dart';
import '../../../cubit/chat/message_control/message_control_cubit.dart';
import '../../general/custom_dialog.dart';
import '../../theme/theme_scope.dart';
import '../message/message_card.dart';

class MessageListItem extends StatelessWidget {
  final MessageModel message;
  final int index;

  const MessageListItem({
    super.key,
    required this.message,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 300),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Align(
            alignment: Alignment.centerRight,
            child: Slidable(
              startActionPane: ThemeScope.of(context).state.messageAlignment ==
                      BubbleAlignments.start.alignment
                  ? _messageActionPane(context)
                  : null,
              endActionPane: ThemeScope.of(context).state.messageAlignment !=
                      BubbleAlignments.start.alignment
                  ? _messageActionPane(context)
                  : null,
              closeOnScroll: true,
              child: MessageCard(
                message: message,
                longPressAction: () {
                  context.read<MessageControlCubit>().selectOne(message);
                },
                pressedAction: () {
                  context.read<MessageControlCubit>().state.isSelectMode
                      ? context.read<MessageControlCubit>().selectOne(message)
                      : {
                          //TODO: open popup menu with actions for selected message
                        };
                },
                isExample: false,
              ),
            ),
          ),
        ),
      ),
    );
  }

  ActionPane _messageActionPane(BuildContext context) {
    return ActionPane(
      motion: const BehindMotion(),
      extentRatio: 0.35,
      children: [
        SlidableAction(
          spacing: 0.0,
          borderRadius: BorderRadius.circular(Radii.circle),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).indicatorColor,
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
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).indicatorColor,
          onPressed: (_) {
            showDialog(
              context: context,
              builder: (_) => CustomDialog(
                dialogTitle: Strings.deleteSelectedMessagesTitle,
                dialogDescription: const Text(
                  Strings.deleteSelectedMessagesDescription,
                ),
                completeAction: () {
                  context.read<MessageControlCubit>().removeOne(message);
                },
                cancelVisible: true,
              ),
            );
          },
          icon: Icons.delete,
        ),
      ],
    );
  }
}
