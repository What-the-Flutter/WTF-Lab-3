import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';

import '../../../common/utils/insets.dart';
import '../../../common/utils/locale.dart' as locale;
import '../../../common/utils/text_styles.dart';
import '../../../common/utils/typedefs.dart';
import '../../chat_overview/chats_overview.dart';
import '../cubit/move_message/move_messages_cubit.dart';
import '../widget/scopes/move_message_scope.dart';

class MoveMessagePage extends StatefulWidget {
  const MoveMessagePage({
    super.key,
    required this.fromChatId,
    required this.messages,
  });

  final String fromChatId;
  final MessageList messages;

  @override
  State<MoveMessagePage> createState() => _MoveMessagePageState();
}

class _MoveMessagePageState extends State<MoveMessagePage> {
  int? _selectedChat;

  @override
  Widget build(BuildContext context) {
    return MoveMessagesScope(
      fromChatId: widget.fromChatId,
      messages: widget.messages,
      child: Builder(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(
              Insets.large,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.messages.length == 1
                      ? locale.Info.move
                          .i18n([widget.messages.length.toString()])
                      : locale.Info.movePlural
                          .i18n([widget.messages.length.toString()]),
                  style: TextStyles.defaultMedium(context),
                ),
                ...MoveMessagesScope.of(context).state.chats.map(
                  (chat) {
                    return context.watch<MoveMessagesCubit>().state.map(
                      initial: (initial) {
                        return ChatItem(
                          chat: chat,
                          onTap: () {
                            MoveMessagesScope.of(context).select(chat.id);
                          },
                        );
                      },
                      hasSelectedState: (hasSelectedState) {
                        return ChatItem(
                          chat: chat,
                          onTap: () {
                            MoveMessagesScope.of(context).toggleSelection(
                              chat.id,
                            );
                          },
                          isSelected: hasSelectedState.selectedChatId == chat.id,
                        );
                      },
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Builder(
                      builder: (context) {
                        return context.watch<MoveMessagesCubit>().state.map(
                          initial: (initial) {
                            return TextButton(
                              onPressed: null,
                              child: Text(
                                locale.Actions.move.i18n(),
                                style: TextStyles.defaultGrey(context),
                              ),
                            );
                          },
                          hasSelectedState: (hasSelectedState) {
                            return TextButton(
                              onPressed: () {
                                MoveMessagesScope.of(context).move();
                                context.pop();
                              },
                              child: Text(
                                locale.Actions.move.i18n(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
