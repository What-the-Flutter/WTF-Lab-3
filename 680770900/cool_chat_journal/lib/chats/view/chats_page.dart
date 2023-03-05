import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../chat/models/chat.dart';
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
        onEditChat: () => throw UnimplementedError(),
      )
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
          //final chats = state.chats;
          final chats = <Chat>[
            Chat.empty,
            Chat.empty,
            Chat.empty,
          ];

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) => ChatCard(
              chat: chats[index],
              onOpenManagePanel: () => _openManagePanel(context, chats[index]),
              // onOpenChat: () => Navigator.of(context).push<void>(
              //   ChatPage.route(
              //     context.read<ChatsCubit>(),
              //   ),
              // ),
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: null,
        // onPressed: () => Navigator.of(context).push<void>(
        //   ChatEditorPage.route(
        //     context.read<ChatsCubit>(),
        //   ),
        // ), 
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
  
}