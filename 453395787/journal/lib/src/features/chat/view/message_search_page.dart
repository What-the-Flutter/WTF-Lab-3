import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/data/chat_repository.dart';
import '../cubit/message_manage/message_manage_cubit.dart';
import '../cubit/tag_selector/tags_cubit.dart';
import '../cubit/tag_selector/tags_state.dart';
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

  final int chatId;

  @override
  State<MessageSearchPage> createState() => _MessageSearchPageState();
}

class _MessageSearchPageState extends State<MessageSearchPage> {
  bool _isInputFieldShown = false;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => MessageRepository(
        chatId: widget.chatId,
        repository: context.read<ChatRepository>(),
      ),
      child: MessageSearchScope(
        child: MessageManageScope(
          child: Builder(
            builder: (context) {
              _isInputFieldShown = context.watch<MessageManageCubit>().state
                  is MessageManageEditMode;

              return TagSelectorScope(
                child: BlocListener<TagsCubit, TagsState>(
                  listener: (context, state) {
                    MessageSearchScope.of(context).onSearchTagsChanged(
                      state.map(
                        initial: (_) => null,
                        hasSelected: (hasSelected) => hasSelected.selected,
                      ),
                    );
                  },
                  child: Scaffold(
                    appBar: const _SearchAppBar(),
                    body: Column(
                      children: [
                        const TagSelector(),
                        Expanded(
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
