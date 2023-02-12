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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => print('Click to menu'),
        ),
        title: Text(widget.appName),
      ),
      body:ListView.builder(
        itemCount: _chats.length,
        itemBuilder: (context, index) => ChatCard(
          chat: _chats[index],
          onDelete: () => _deleteChat(_chats[index]),
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