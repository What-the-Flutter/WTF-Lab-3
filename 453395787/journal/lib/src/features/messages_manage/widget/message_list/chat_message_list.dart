import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../../common/data/models/message.dart';
import '../../../../common/utils/confirmation_dialog.dart';
import '../../../../common/utils/floating_bottom_sheet.dart';
import '../../../../common/utils/insets.dart';
import '../../../../common/utils/radius.dart';
import '../../../move_messages/view/move_message.dart';
import '../../../theme/theme.dart';
import '../../cubit/message_manage_cubit.dart';
import 'items/message_item.dart';
import 'items/time_item.dart';

part 'action_menu.dart';

class ChatMessageList extends StatelessWidget {
  ChatMessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageManageCubit, MessageManageState>(
      builder: (context, state) {
        final messagesWithDates = state.messagesWithDates.reversed.toList();

        return ListView.builder(
          reverse: true,
          shrinkWrap: true,
          padding: const EdgeInsets.only(
            bottom: Insets.small,
          ),
          itemCount: messagesWithDates.length,
          itemBuilder: (context, index) {
            final item = messagesWithDates[index];
            if (item is DateTime) {
              return TimeItem(dateTime: messagesWithDates[index] as DateTime);
            }

            return SwipeTo(
              iconOnLeftSwipe: Icons.edit_outlined,
              onLeftSwipe: () {
                context.read<MessageManageCubit>().startEditMode(item);
              },
              iconOnRightSwipe: Icons.delete_outline,
              onRightSwipe: () {
                context.read<MessageManageCubit>().remove(item);
              },
              child: MessageItem(
                message: item as Message,
                onTap: (message, isSelected) {
                  state.maybeMap(
                    selectionMode: (selectionMode) {
                      if (selectionMode.selected.contains(message.id)) {
                        context.read<MessageManageCubit>().unselect(message);
                      } else {
                        context.read<MessageManageCubit>().select(message);
                      }
                    },
                    orElse: () {
                      _showActionMenu(context, message);
                    },
                  );
                },
                onLongPress: (message, isSelected) {
                  state.maybeMap(
                    defaultMode: (defaultMode) {
                      context.read<MessageManageCubit>().select(message);
                    },
                    selectionMode: (selectionMode) {
                      if (selectionMode.selected.contains(message.id)) {
                        context.read<MessageManageCubit>().unselect(message);
                      } else {
                        context.read<MessageManageCubit>().select(message);
                      }
                    },
                    orElse: () {},
                  );
                },
                isSelected: state.maybeMap(
                  selectionMode: (selectionMode) {
                    return selectionMode.selected.contains(item.id);
                  },
                  orElse: () => false,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
