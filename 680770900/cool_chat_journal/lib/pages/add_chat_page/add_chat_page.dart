import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/chats_cubit.dart';
import '../../model/chat.dart';
import '../../model/chat_icons.dart';
import '../../model/event.dart';
import 'icon_view.dart';

class AddChatPage extends StatefulWidget {
  final int? oldChatIndex;

  const AddChatPage({
    super.key,
    this.oldChatIndex,
  });

  @override
  State<AddChatPage> createState() => _AddChatPageState();
}

class _AddChatPageState extends State<AddChatPage> {
  final _titleController = TextEditingController();
  bool _hasTitle = false;
  int _selectedIconIndex = 0;

  void _onChangeTitle() {
    setState(() {
      _hasTitle = _titleController.text.isNotEmpty;
    });
  }

  void _saveChat(BuildContext context) {
    if (_hasTitle) {
      final Chat? oldChat;
      if (widget.oldChatIndex != null) {
        oldChat = context.read<ChatsCubit>().state.chats[widget.oldChatIndex!];
      } else {
        oldChat = null;
      }

      final chat = Chat(
        icon: ChatIcons.icons[_selectedIconIndex],
        name: _titleController.text,
        events: oldChat?.events ?? <Event>[],
        createdTime: oldChat?.createdTime ?? DateTime.now(),
      );

      if (widget.oldChatIndex == null) {
        context.read<ChatsCubit>().addNewChat(chat);
      } else {
        context.read<ChatsCubit>().editChat(widget.oldChatIndex!, chat);
      }
    }

    Navigator.pop(context);
  }

  void _onSelectIcon(int index) {
    setState(() {
      _selectedIconIndex = index;
    });
  }

  Widget _createTitle() {
    final String titleText;
    if (widget.oldChatIndex == null) {
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

  Widget _createTitleField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: _titleController,
        decoration: const InputDecoration(
          labelText: 'Name of the Page',
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 3),
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
        itemBuilder: (context, index) => IconView(
          icon: icons[index],
          isSelected: index == _selectedIconIndex,
          size: 80,
          onTap: () => _onSelectIcon(index),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _titleController.addListener(_onChangeTitle);

    if (widget.oldChatIndex != null) {
      final oldChat =
          context.read<ChatsCubit>().state.chats[widget.oldChatIndex!];

      _titleController.text = oldChat.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonIcon = _hasTitle ? Icons.done : Icons.close;

    return Scaffold(
      body: Column(
        children: [
          _createTitle(),
          _createTitleField(),
          Expanded(
            child: _createIconsView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(buttonIcon),
        onPressed: () => _saveChat(context),
      ),
    );
  }
}
