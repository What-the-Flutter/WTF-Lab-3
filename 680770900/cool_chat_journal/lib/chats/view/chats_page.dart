import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../chat/chat.dart';
import '../../chat_editor/chat_editor.dart';
import '../../themes/custom_theme.dart';
import '../cubit/chats_cubit.dart';
import '../widgets/widgets.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatsCubit(),
      child: const ChatsView(),
    );
  }
}

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

  void _openManagePanel(BuildContext context, Chat chat) {
    final cubit = context.read<ChatsCubit>();

    showModalBottomSheet(
      context: context,
      builder: (context) => ManagePanelDialog(
        chat: chat,
        onDeleteChat: () => cubit.deleteChat(chat.id),
        onSwitchChatPinning: () => cubit.switchChatPinning(chat.id),
        onEditChat: () => Navigator.of(context).push<void>(
          ChatEditorPage.route(
            chatsCubit: cubit,
            sourceChat: chat,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => print('Click to menu'),
        ),
        title: const Text('Cool Chat Journal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.color_lens_outlined),
            onPressed: () => CustomTheme.instanceOf(context).chooseNextTheme(),
          ),
        ],
      ),
      body: BlocBuilder<ChatsCubit, ChatsState>(
        builder: (_, state) {
          final chats = state.chats;
          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) => ChatCard(
              chat: chats[index],
              onOpenManagePanel: () => _openManagePanel(context, chats[index]),
              onOpenChat: () => Navigator.of(context).push<void>(
                ChatPage.route(
                  chatsCubit: context.read<ChatsCubit>(),
                  chat: chats[index],
                ),
              ),
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push<void>(
            ChatEditorPage.route(
              chatsCubit: context.read<ChatsCubit>(),
            ),
          );
        }
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
  
}