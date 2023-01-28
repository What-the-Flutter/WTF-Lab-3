import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../common/features/settings/data/settings_repository_api.dart';
import '../../../../common/features/settings/settings.dart';
import '../../../../common/models/ui/message.dart';
import '../../../../common/utils/insets.dart';
import '../../cubit/message_manage/message_manage_cubit.dart';
import '../scopes/message_manage_scope.dart';
import 'items/message_item.dart';
import 'items/slideable_message_container.dart';
import 'items/time_item.dart';
import 'with_background_image.dart';

class ChatMessageList extends StatelessWidget {
  const ChatMessageList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageManageCubit, MessageManageState>(
      builder: (context, state) {
        final List<Object> messages;
        if (context.read<SettingsCubit>().state.isCenterDateBubbleShown) {
          messages = state.messagesWithDates.reversed.toList();
        } else {
          messages = state.messages.reversed.toList();
        }

        return SlidableAutoCloseBehavior(
          child: WithBackgroundImage(
            child: ListView.builder(
              reverse: true,
              shrinkWrap: true,
              padding: const EdgeInsets.only(
                bottom: Insets.small,
              ),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final item = messages[index];
                if (item is DateTime) {
                  return TimeItem(
                    dateTime: messages[index] as DateTime,
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
                    alignment:
                        context.read<SettingsCubit>().state.messageAlignment ==
                                MessageAlignment.right
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
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
          ),
        );
      },
    );
  }
}
