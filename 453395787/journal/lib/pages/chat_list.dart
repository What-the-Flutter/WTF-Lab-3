import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ChatItem(
          icon: Icon(Icons.all_inclusive_outlined),
          title: 'All',
          lastMessage: 'Last message',
          time: '12.12pm',
        ),
        const ChatItem(
          icon: Icon(Icons.message),
          title: 'First',
          lastMessage: 'Lorem ipsum',
          time: 'Mon',
        ),
        const ChatItem(
          icon: Icon(Icons.camera_outdoor),
          title: 'Second',
          lastMessage: 'Lorem ipsum',
          time: '12 Dec',
        ),
      ],
    );
  }
}

class ChatItem extends StatelessWidget {
  final Icon icon;
  final String title;
  final String lastMessage;
  final String time;

  const ChatItem({
    required this.icon,
    required this.title,
    required this.lastMessage,
    required this.time,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: icon,
        title: Text(title),
        subtitle: Text(lastMessage),
        trailing: Text(time,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
