import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/chat.dart';
import '../../model/chat_icons.dart';
import '../../model/event.dart';
import 'cubit/edit_chat_cubit.dart';
import 'cubit/edit_chat_state.dart';
import 'widgets/icon_view.dart';

class EditChat extends StatelessWidget {
  final int? newId;
  final Chat? oldChat;

  const EditChat({
    super.key,
    this.newId,
    this.oldChat,
  });

  void _saveChat(BuildContext context) {
    assert(newId != null || oldChat != null);

    final title = context.read<EditChatCubit>().state.title;
    if (title.isNotEmpty) {
      final iconIndex = context.read<EditChatCubit>().state.iconIndex;
      final chat = Chat(
        id: oldChat?.id ?? newId!,
        icon: ChatIcons.icons[iconIndex],
        name: title,
        events: oldChat?.events ?? <Event>[],
        createdTime: oldChat?.createdTime ?? DateTime.now(),
      );
  
      Navigator.pop(context, chat);
    } else {
      Navigator.pop(context, null);
    }
  }

  Widget _createTitleField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Name of the Page',
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 3),
          ),
        ),
        onChanged: (value) => context.read<EditChatCubit>().changeTitle(value),
      ),
    );
  }

  Widget _createTitle() {
    final String titleText;
    if (oldChat == null) {
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

   Widget _createIconsView() {
    final icons = ChatIcons.icons;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.builder(
        itemCount: icons.length,
        itemBuilder: (_, index) => BlocBuilder<EditChatCubit, EditChatState>(
          builder: (context, state) {
            return IconView(
              icon: icons[index],
              isSelected: index == state.iconIndex,
              size: 80,
              onTap: () => context.read<EditChatCubit>().selectIcon(index),
            );
          }
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditChatCubit(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Column(
              children: [
                _createTitle(),
                _createTitleField(context),
                Expanded(
                  child: _createIconsView()
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: BlocBuilder<EditChatCubit, EditChatState> (
                builder: (context, state) {
                  final icon = state.title.isNotEmpty ? Icons.done : Icons.close;
                  return Icon(icon);
                },
              ),
              onPressed: () => _saveChat(context),
            ),
          );
        }
      ),
    );
  }
}