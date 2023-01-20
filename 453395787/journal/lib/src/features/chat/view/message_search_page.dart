import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/data/chat_repository.dart';
import '../../../common/data/database/database.dart';
import '../../../common/data/storage.dart';
import '../../../common/utils/typedefs.dart';
import '../cubit/message_manage/message_manage_cubit.dart';
import '../cubit/tag_selector/tags_cubit.dart';
import '../data/message_repository.dart';
import '../widget/chat_input/chat_input.dart';
import '../widget/message_list/chat_message_list.dart';
import '../widget/scopes/message_manage_scope.dart';
import '../widget/scopes/message_search_scope.dart';
import '../widget/scopes/tags_scope.dart';
import '../widget/tag_selector/tag_selector.dart';

part '../widget/app_bar/search_app_bar.dart';

class MessageSearchPage extends StatefulWidget {
  const MessageSearchPage({
    super.key,
    required this.chatId,
  });

  final Id chatId;

  @override
  State<MessageSearchPage> createState() => _MessageSearchPageState();
}

class _MessageSearchPageState extends State<MessageSearchPage> {
  bool _isInputFieldShown = false;

  @override
  Widget build(BuildContext context) {
    final chat = context.read<ChatRepository>().chats.value.firstWhere(
          (chat) => chat.id == widget.chatId,
        );
    return RepositoryProvider(
      create: (context) => MessageRepository(
        messageProviderApi: context.read<Database>(),
        tagProviderApi: context.read<Database>(),
        chat: chat,
      ),
      child: MessageSearchScope(
        child: MessageManageScope(
          chat: chat,
          child: Builder(
            builder: (context) {
              _isInputFieldShown = context.watch<MessageManageCubit>().state
                  is MessageManageEditModeState;

              return TagSelectorScope(
                child: BlocListener<TagsCubit, TagsState>(
                  listener: (context, state) {
                    MessageSearchScope.of(context).onSearchTagsChanged(
                      state.map(
                        initial: (_) => null,
                        hasSelectedState: (hasSelectedState) => hasSelectedState
                            .tags
                            .where(
                              (tag) =>
                                  hasSelectedState.selected.contains(tag),
                            )
                            .toIList(),
                      ),
                    );
                  },
                  child: Scaffold(
                    appBar: const _SearchAppBar(),
                    body: Column(
                      children: [
                        const TagSelector(),
                        const Expanded(
                          child: ChatMessageList(),
                        ),
                        Visibility(
                          visible: _isInputFieldShown,
                          maintainState: true,
                          child: ChatInput(
                            chatId: widget.chatId,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
