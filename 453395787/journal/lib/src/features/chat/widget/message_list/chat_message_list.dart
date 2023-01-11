import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../common/models/message.dart';
import '../../../../common/utils/insets.dart';
import '../../cubit/message_manage/message_manage_cubit.dart';
import '../scopes/message_manage_scope.dart';
import 'items/message_item.dart';
import 'items/slideable_message_container.dart';
import 'items/time_item.dart';

class ChatMessageList extends StatelessWidget {
  ChatMessageList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageManageCubit, MessageManageState>(
      builder: (context, state) {
        final messagesWithDates = state.messagesWithDates.reversed.toList();

        return SlidableAutoCloseBehavior(
          child: ListView.builder(
            reverse: true,
            shrinkWrap: true,
            padding: const EdgeInsets.only(
              bottom: Insets.small,
            ),
            itemCount: messagesWithDates.length,
            itemBuilder: (context, index) {
              final item = messagesWithDates[index];
              if (item is DateTime) {
                return TimeItem(
                  dateTime: messagesWithDates[index] as DateTime,
                );
              }

              return SlidableMessageContainer(
                valueKey: ValueKey(item),
                isEditMode: state.maybeMap(
                  editMode: (_) => true,
                  orElse: () => false,
                ),
                onEdit: () {
                  state.mapOrNull(
                    defaultMode: (defaultMode) {
                      MessageManageScope.of(context).startEditMode(item);
                    },
                    editMode: (editMode) {
                      MessageManageScope.of(context).endEditMode();
                    },
                  );
                },
                onDelete: () {
                  MessageManageScope.of(context).remove(item);
                },
                child: MessageItem(
                  message: item as Message,
                  onTap: (message, isSelected) {
                    state.mapOrNull(
                      selectionMode: (selectionMode) {
                        if (selectionMode.selected.contains(message.id)) {
                          MessageManageScope.of(context).select(message);
                        } else {
                          MessageManageScope.of(context).unselect(message);
                        }
                      },
                    );
                  },
                  onLongPress: (message, isSelected) {
                    state.mapOrNull(
                      defaultMode: (defaultMode) {
                        MessageManageScope.of(context).select(message);
                      },
                      selectionMode: (selectionMode) {
                        if (selectionMode.selected.contains(message.id)) {
                          MessageManageScope.of(context).unselect(message);
                        } else {
                          MessageManageScope.of(context).select(message);
                        }
                      },
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
          ),
        );
      },
    );
  }
}
