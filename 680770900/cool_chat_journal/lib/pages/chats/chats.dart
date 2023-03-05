import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/chat.dart';
import '../../themes/custom_theme.dart';
import '../chat/cubit/chat_cubit.dart';
import '../edit_chat/edit_chat.dart';
import 'cubit/chats_cubit.dart';
import 'cubit/chats_state.dart';
import 'widgets/bottom_navigation.dart';
import 'widgets/chat_card.dart';

class Chats extends StatefulWidget {
  final String appName;

  const Chats({super.key, required this.appName});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {

  AppBar _createAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () => print('Click to menu'),
      ),
      title: Text(widget.appName),
      actions: [
        IconButton(
          icon: const Icon(Icons.color_lens_outlined),
          onPressed: () => CustomTheme.instanceOf(context).chooseNextTheme(),
        ),
      ],
    );
  }

  Widget _createBody(BuildContext context) {
    final chatCubit = context.read<ChatCubit>();
    return BlocBuilder<ChatsCubit, ChatsState>(
      builder: (_, state) {
        final chats = state.chats;
        return BlocProvider.value(
          value: chatCubit,
          child: ListView.builder(
            itemCount: chats.length,
            itemBuilder: (_, index) => ChatCard(
              chat: chats[index],
            ),
          ),
        );
      }
    );
  }

  Widget _createFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () async {
        final chat = await Navigator.push<Chat>(
          context,
          MaterialPageRoute(
            builder: (_) => EditChat(
              newId: context.read<ChatsCubit>().state.nextId,
            ),
          ),
        );

        if (chat != null) {
          context.read<ChatsCubit>().addNewChat(chat);
        }
      } 
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatsCubit>(
      create: (_) => ChatsCubit(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: _createAppBar(context),
            body: BlocBuilder<ChatsCubit, ChatsState>(
              builder: (_, state) {
                final chats = state.chats;
                return ListView.builder(
                  itemCount: chats.length,
                  itemBuilder: (_, index) => ChatCard(
                    chat: chats[index],
                  ),
                );
              }
            ),
            floatingActionButton: _createFloatingActionButton(context),
            bottomNavigationBar: const BottomNavigation(),
          );
        }
      ),
    );
  }
}
