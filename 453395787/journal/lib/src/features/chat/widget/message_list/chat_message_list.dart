import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../common/models/ui/message.dart';
import '../../../../common/utils/insets.dart';
import '../../cubit/message_manage/message_manage_cubit.dart';
import '../scopes/message_manage_scope.dart';
import 'items/message_item.dart';
import 'items/slideable_message_container.dart';
import 'items/time_item.dart';

class ChatMessageList extends StatelessWidget {
  const ChatMessageList({
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
                  editModeState: (_) => true,
                  orElse: () => false,
                ),
                onEdit: () {
                  state.mapOrNull(
                    defaultModeState: (_) {
                      MessageManageScope.of(context).startEditMode(item);
                    },
                    editModeState: (_) {
                      MessageManageScope.of(context).endEditMode();
                    },
                  );
                },
                onDelete: () {
                  MessageManageScope.of(context).remove(item);
                },
                child: MessageItem(
                  message: item as Message,
                  tags: item.tags,
                  onTap: (message, isSelected) {
                    state.mapOrNull(
                      defaultModeState: (defaultModeState) {
                        if (message.isFavorite) {
                          MessageManageScope.of(context).removeFromFavorites(message);
                        } else {
                          MessageManageScope.of(context).addToFavorites(message);
                        }
                      },
                      selectionModeState: (selectionModeState) {
                        if (selectionModeState.selected.contains(message.id)) {
                          MessageManageScope.of(context).select(message);
                        } else {
                          MessageManageScope.of(context).unselect(message);
                        }
                      },
                    );
                  },
                  onLongPress: (message, isSelected) {
                    state.mapOrNull(
                      defaultModeState: (defaultModeState) {
                        MessageManageScope.of(context).select(message);
                      },
                      selectionModeState: (selectionModeState) {
                        if (selectionModeState.selected.contains(message.id)) {
                          MessageManageScope.of(context).unselect(message);
                        } else {
                          MessageManageScope.of(context).select(message);
                        }
                      },
                    );
                  },
                  isSelected: state.maybeMap(
                    selectionModeState: (selectionModeState) {
                      return selectionModeState.selected.contains(item.id);
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
