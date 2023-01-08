import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/api/chat_repository_api.dart';
import '../../../common/data/models/message.dart';
import '../../../common/utils/insets.dart';
import '../../../common/utils/text_styles.dart';
import '../../chats_overview/widget/chat_item.dart';
import '../../navigation/cubit/navigation_cubit.dart';
import '../cubit/move_messages_cubit.dart';

class MoveMessagePage extends StatefulWidget {
  const MoveMessagePage({
    super.key,
    required this.repository,
    required this.fromChatId,
    required this.messages,
  });

  final int fromChatId;
  final IList<Message> messages;
  final ChatRepositoryApi repository;

  @override
  State<MoveMessagePage> createState() => _MoveMessagePageState();
}

class _MoveMessagePageState extends State<MoveMessagePage> {
  int? _selectedChat;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoveMessagesCubit(
        repository: widget.repository,
        fromChatId: widget.fromChatId,
        messages: widget.messages,
      ),
      child: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(Insets.large),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Move ${widget.messages.length} '
                'message${widget.messages.length == 1 ? '' : 's'} to',
                style: TextStyles.defaultMedium(context),
              ),
              ...context.read<MoveMessagesCubit>().state.chats.map(
                (chat) {
                  return context.watch<MoveMessagesCubit>().state.map(
                    initial: (initial) {
                      return ChatItem(
                        chat: chat,
                        onTap: () {
                          context.read<MoveMessagesCubit>().select(chat.id);
                        },
                        onLongPress: () {},
                      );
                    },
                    selected: (selected) {
                      return ChatItem(
                        chat: chat,
                        onTap: () {
                          context
                              .read<MoveMessagesCubit>()
                              .toggleSelection(chat.id);
                        },
                        onLongPress: () {},
                        isSelected: selected.selectedChatId == chat.id,
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
                              'Move',
                              style: TextStyles.defaultGrey(context),
                            ),
                          );
                        },
                        selected: (selected) {
                          return TextButton(
                            onPressed: () {
                              context.read<MoveMessagesCubit>().apply();
                              context.read<NavigationCubit>().back();
                            },
                            child: const Text('Move'),
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
      }),
    );
  }
}
