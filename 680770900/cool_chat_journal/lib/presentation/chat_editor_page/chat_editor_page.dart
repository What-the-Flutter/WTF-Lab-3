import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/chat.dart';
import '../home_page/home_cubit.dart';
import 'chat_editor_cubit.dart';
import 'widgets/chat_icons.dart';

class ChatEditorPage extends StatelessWidget {
  final Chat? sourceChat;

  const ChatEditorPage({
    super.key,
    this.sourceChat,
  });

  void _saveChat(BuildContext context) {
    final chatEditorCubit = context.read<ChatEditorCubit>();
    final title = chatEditorCubit.state.title;

    if (title.isNotEmpty) {
      final iconIndex = chatEditorCubit.state.iconIndex;
      final chat = Chat(
        id: sourceChat?.id,
        iconCode: ChatIcons.icons[iconIndex].codePoint,
        name: title,
        createdTime: sourceChat?.createdTime ?? DateTime.now(),
        isPinned: false,
      );

      final chatsCubit = context.read<HomeCubit>();
      if (sourceChat != null) {
        chatsCubit.editChat(chat);
      } else {
        chatsCubit.addChat(chat);
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
    final cubit = context.read<ChatEditorCubit>();

    final initialValue = sourceChat?.name;
    if (initialValue != null) {
      cubit.changeTitle(initialValue);
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
        onChanged: cubit.changeTitle,
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
              });
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
      ),
    );
  }

  Widget _createFloatingActionButton(BuildContext context) {
    return BlocBuilder<ChatEditorCubit, ChatEditorState>(
      buildWhen: (prev, current) =>
          (prev.title.isEmpty && current.title.isNotEmpty) ||
          (prev.title.isNotEmpty && current.title.isEmpty) ||
          (prev.title.isNotEmpty && prev.iconIndex != current.iconIndex),
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

class IconView extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback? onTap;
  final double? size;

  const IconView({
    super.key,
    required this.icon,
    this.isSelected = false,
    this.onTap,
    this.size,
  });

  Widget _createIconView(ColorScheme colorScheme) {
    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
      child: Icon(
        icon,
        color: colorScheme.onBackground,
        size: 45.0,
      ),
    );
  }

  Widget _createSelectionIcon(ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: colorScheme.background,
        ),
        shape: BoxShape.circle,
        color: Colors.green,
      ),
      child: Icon(
        Icons.done,
        color: colorScheme.onBackground,
        size: 25.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Stack(alignment: Alignment.bottomRight, children: [
        _createIconView(colorScheme),
        if (isSelected) _createSelectionIcon(colorScheme),
      ]),
    );
  }
}
