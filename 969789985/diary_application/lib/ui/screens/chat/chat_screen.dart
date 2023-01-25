import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../basic/models/chat_model.dart';
import '../../../basic/providers/chat_list_provider.dart';
import '../../../basic/providers/chat_provider.dart';
import '../../../widgets/chat/chat_app_bar.dart';
import '../../../widgets/chat/chat_box.dart';
import '../../../widgets/chat/chat_edit_input_field.dart';
import '../../../widgets/chat/chat_input_field.dart';

class ChatScreen extends StatelessWidget {
  final TextEditingController _chatTextFieldController =
      TextEditingController();
  final TextEditingController _editTextFieldController =
      TextEditingController();
  final TextEditingController _searchTextEditingController =
      TextEditingController();

  final ChatModel chat;

  ChatScreen({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatProvider>(
      create: (context) => ChatProvider(
        chatListProvider: Provider.of<ChatListProvider>(
          context,
          listen: false,
        ),
        chatId: chat.id,
      ),
      builder: (context, child) {
        return Consumer<ChatProvider>(
          builder: (context, provider, child) {
            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: ChatAppBar(
                textController: _editTextFieldController,
                searchTextController: _searchTextEditingController,
                provider: provider,
                chat: chat,
              ),
              bottomNavigationBar: _bottomPanel(context, provider),
              body: Chat(
                provider: provider,
                searchTextController: _searchTextEditingController,
              ),
            );
          },
        );
      },
    );
  }

  Widget _bottomPanel(BuildContext context, ChatProvider provider) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: provider.isEditMode
            ? ChatEditInputField(
                editTextFieldController: _editTextFieldController,
                provider: provider,
              )
            : ChatInputField(
                chatTextFieldController: _chatTextFieldController,
                provider: provider,
              ),
      );
}
