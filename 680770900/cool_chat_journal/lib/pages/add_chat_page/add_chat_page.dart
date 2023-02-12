import 'package:flutter/material.dart';

import '../../model/chat.dart';
import 'chat_icons.dart';
import 'icon_view.dart';

class AddChatPage extends StatefulWidget {
  final void Function(Chat)? onAddNewChat;
  
  const AddChatPage({super.key, this.onAddNewChat});

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

  void _onAddChat() {    
    if (_hasTitle) {
      widget.onAddNewChat?.call(
        Chat.withoutEvents(
          icon: Icon(ChatIcons.icons[_selectedIconIndex]),
          name: _titleController.text,
          createdTime: DateTime.now(),
        ),
      );
    }

    Navigator.pop(context);
  }

  void _onSelectIcon(int index) {
    setState(() {
      _selectedIconIndex = index;
    });
  }

  Widget _createTitle() {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          'Create a new page',
          style: TextStyle(
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
            borderSide: BorderSide(
              width: 3, color: Colors.greenAccent
            ), //<-- SEE HERE
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
        onPressed: _onAddChat,
      ),
    );
  }
}