import 'package:chats_repository/chats_repository.dart' show ChatsRepository;
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
      create: (_) => ChatsCubit(context.read<ChatsRepository>()),
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
      body: BlocConsumer<ChatsCubit, ChatsState>(
        listener: (_, state) {
          if (state.status.isInitial) {
            context.read<ChatsCubit>().fetchChats();
          }
        },
        builder: (_, state) {
          if (state.status.isSuccess) {
            final chats = state.chats;
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) => ChatCard(
                chat: chats[index],
                onOpenManagePanel: () =>
                  _openManagePanel(context, chats[index]),
                onOpenChat: () => Navigator.of(context).push<void>(
                  ChatPage.route(
                    chatsCubit: context.read<ChatsCubit>(),
                    chat: chats[index],
                  ),
                ),
              ),
            );
          } else if (state.status.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status.isInitial) {
            return Center(
              child: ElevatedButton(
                child: const Text('Click me'),
                onPressed: () => context.read<ChatsCubit>().fetchChats(),
              ),
            );
          } else {
            return const Center(child: Text('Ooops! Something wrong.'));
          }
          
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