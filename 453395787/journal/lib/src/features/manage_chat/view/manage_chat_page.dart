import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';

import '../../../common/data/chat_repository.dart';
import '../../../common/models/chat_view.dart';
import '../../../common/utils/icons.dart';
import '../../../common/utils/insets.dart';
import '../../../common/utils/locale.dart' as locale;
import '../cubit/manage_chat_cubit.dart';
import '../widgets/manage_chat_scope.dart';

part '../widgets/chat_icons.dart';

part '../widgets/selectable_icon.dart';

class ManageChatPage extends StatefulWidget {
  const ManageChatPage({
    super.key,
    this.chatId,
  });

  final int? chatId;

  @override
  State<ManageChatPage> createState() => _ManageChatPageState();
}

class _ManageChatPageState extends State<ManageChatPage> {
  final TextEditingController _textEditingController = TextEditingController();
  ChatView? chatForEdit;

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.chatId != null) {
      chatForEdit = context.read<ChatRepository>().chats.value.firstWhere(
            (chat) => chat.id == widget.chatId,
          );
      _textEditingController.text = chatForEdit!.name;
    }
    return ManageChatScope(
      manageChatState: chatForEdit == null
          ? const ManageChatState.addModeState()
          : ManageChatState.editModeState(
              name: chatForEdit!.name,
              chat: chatForEdit!,
              selectedIcon: JournalIcons.icons.indexOf(
                chatForEdit!.icon,
              ),
            ),
      child: BlocBuilder<ManageChatCubit, ManageChatState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                state.isAddMode
                    ? locale.Pages.addChat.i18n()
                    : locale.Pages.editChat.i18n(),
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Insets.large,
                    horizontal: Insets.large,
                  ),
                  child: TextFormField(
                    controller: _textEditingController,
                    maxLength: 30,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: locale.Hints.inputChatName.i18n(),
                      counterText: '${_textEditingController.text.length}/30',
                    ),
                    onChanged: (value) {
                      ManageChatScope.of(context).onNameChanged(value);
                    },
                  ),
                ),
                const Expanded(
                  child: ChatIconsGrid(),
                ),
              ],
            ),
            floatingActionButton:
                state.selectedIcon != null && state.name.isNotEmpty
                    ? FloatingActionButton(
                        child: Icon(
                          state.isAddMode ? Icons.add : Icons.edit,
                        ),
                        onPressed: () {
                          ManageChatScope.of(context).applyChanges();
                          context.pop();
                        },
                      )
                    : null,
          );
        },
      ),
    );
  }
}
