import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/data/chat_repository.dart';
import '../../../common/data/message_repository.dart';
import '../../../common/utils/insets.dart';
import '../../message_input/view/chat_input.dart';
import '../../messages_manage/cubit/message_manage_cubit.dart';
import '../../messages_manage/widget/message_list/chat_message_list.dart';
import '../cubit/message_search_cubit.dart';

class MessageSearchPage extends StatefulWidget {
  const MessageSearchPage({super.key, required this.id});

  final int id;

  @override
  State<MessageSearchPage> createState() => _MessageSearchPageState();
}

class _MessageSearchPageState extends State<MessageSearchPage> {
  bool _isInputFieldShown = false;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => MessageRepository(
        chatIndex: widget.id,
        repository: context.read<ChatRepository>(),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MessageSearchCubit(
              repository: context.read<MessageRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => MessageManageCubit(
              repository: context.read<MessageRepository>(),
            ),
          ),
        ],
        child: Builder(builder: (context) {
          _isInputFieldShown = context.watch<MessageManageCubit>().state
              is MessageManageEditMode;
          return Scaffold(
            appBar: const _SearchAppBar(),
            body: Column(
              children: [
                Expanded(child: ChatMessageList()),
                Visibility(
                  visible: _isInputFieldShown,
                  maintainState: true,
                  child: ChatInput(
                    chatId: widget.id,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const _SearchAppBar({Key? key}) : super(key: key);

  @override
  _SearchAppBarState createState() => _SearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends State<_SearchAppBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextFormField(
        controller: _controller,
        autofocus: true,
        onChanged: (value) {
          context.read<MessageSearchCubit>().search(value);
        },
      ),
    );
  }
}
