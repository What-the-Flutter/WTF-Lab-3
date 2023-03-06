import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../chat/chat.dart';
import '../../chats/chats.dart';
import '../cubit/chat_editor_cubit.dart';
import '../widgets/chat_icons.dart';
import '../widgets/icon_view.dart';

class ChatEditorPage extends StatelessWidget {
  final Chat? sourceChat;

  ChatEditorPage._({
    super.key,
    this.sourceChat,
  });

  static Route<void> route({
    Key? key,
    required ChatsCubit chatsCubit,
    Chat? sourceChat,
  }) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: chatsCubit,
        child: ChatEditorPage._(
          key: key,
          sourceChat: sourceChat,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatEditorCubit(),
      child: ChatEditorView(sourceChat: sourceChat),
    );
  }
}

class ChatEditorView extends StatelessWidget {
  final Chat? sourceChat;

  const ChatEditorView({
    super.key,
    this.sourceChat,
  });
  
  void _saveChat(BuildContext context) {
    final title = context.read<ChatEditorCubit>().state.title;
    if (title.isNotEmpty) {
      final chatsCubit = context.read<ChatsCubit>();
      final iconIndex = context.read<ChatEditorCubit>().state.iconIndex;
      final chat = Chat(
        id: sourceChat?.id ?? 0,
        icon: ChatIcons.icons[iconIndex],
        name: title,
        events: sourceChat?.events ?? <Event>[],
        createdTime: sourceChat?.createdTime ?? DateTime.now(),
      );

      if (sourceChat != null) {
        chatsCubit.editChat(sourceChat!.id, chat);
      } else {
        chatsCubit.addNewChat(chat);
      }
    }
      
    Navigator.pop(context);
  }

  Widget _createTitle() {
    final String titleText;
    if (sourceChat == null) {
      titleText = 'Create a new page';
    } else {
      titleText = 'Edit Page';
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          titleText,
          style: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _createTitleField(BuildContext context) {
    final initialValue = sourceChat?.name;
    if (initialValue != null) {
      context.read<ChatEditorCubit>().changeTitle(initialValue);
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: const InputDecoration(
          labelText: 'Name of the Page',
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 3),
          ),
        ),
        onChanged: (value) =>
          context.read<ChatEditorCubit>().changeTitle(value),
      ),
    );
  }

  Widget _createIconsView() {
    final icons = ChatIcons.icons;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.builder(
        itemCount: icons.length,
        itemBuilder: (_, index) {
          return BlocBuilder<ChatEditorCubit, ChatEditorState>(
            buildWhen: (previous, current) =>
                previous.iconIndex != current.iconIndex,
            builder: (context, state) {
              return IconView(
                icon: icons[index],
                isSelected: index == state.iconIndex,
                size: 80,
                onTap: () =>
                  context.read<ChatEditorCubit>().selectIcon(index),
              );
            }
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
      ),
    );
  }

  Widget _createFloatingActionButton(BuildContext context) {
    return BlocBuilder<ChatEditorCubit, ChatEditorState>(
      buildWhen: (prev, curr) =>
        (prev.title.isEmpty && curr.title.isNotEmpty) ||
        (prev.title.isNotEmpty && curr.title.isEmpty) ||
        (prev.title.isNotEmpty && prev.iconIndex != curr.iconIndex),
      builder: (context, state) {
        final icon = state.title.isNotEmpty ? Icons.done : Icons.close;
        return FloatingActionButton(
          child: Icon(icon),
          onPressed: () => _saveChat(context),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _createTitle(),
          _createTitleField(context),
          Expanded(child: _createIconsView()),
        ],
      ),
      floatingActionButton: _createFloatingActionButton(context),
    );
  }
}
