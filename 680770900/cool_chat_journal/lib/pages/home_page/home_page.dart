import 'package:flutter/material.dart';

import '../../model/chat.dart';
import '../add_chat_page/add_chat_page.dart';
import 'bottom_navigation.dart';
import 'chat_card.dart';

class HomePage extends StatefulWidget {
  
  final String appName;
  
  const HomePage({super.key, required this.appName});  

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _pinnedChats = <Chat>[];
  final _chats = <Chat>[];

  void _addNewChat(Chat newChat) {
    setState(() {
      _chats.add(newChat);
    });
  }

  void _deleteChat(Chat deletedChat) {
    setState(() {
      _chats.remove(deletedChat);
    });
  }

  void _editChat(Chat oldChat, Chat newChat) {
    final index = _chats.indexOf(oldChat);

    setState(() {
      _chats[index] = newChat;
    });
  }

  void _pinChat(Chat chat) {
    setState(() {
      if (_pinnedChats.contains(chat)) {
        _pinnedChats.remove(chat);
      } else {
        _pinnedChats.add(chat);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final unpinnedChats = _chats.
      where((chat) => !_pinnedChats.contains(chat)).
      toList();

    final chats = <Chat>[..._pinnedChats, ...unpinnedChats];



    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => print('Click to menu'),
        ),
        title: Text(widget.appName),
      ),
      body:ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) => ChatCard(
          chat: chats[index],
          isPinned: _pinnedChats.contains(chats[index]),
          onPin: () => _pinChat(chats[index]),
          onDelete: () => _deleteChat(chats[index]),
          onEdit: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddChatPage(
                oldChat: chats[index],
                onEditChat: _editChat,
              )),
            );
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddChatPage(
            onAddNewChat: _addNewChat,
          )),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}