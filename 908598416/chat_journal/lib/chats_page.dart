import 'package:flutter/material.dart';

class ChatsPage extends StatefulWidget {
  ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  final List<ChatItem> _items = [
    const ChatItem(
      icon: Icon(Icons.flight, size: 40),
      title: 'Travel',
      lastMessage: 'No events. Click to create one.',
      time: '',
    ),
    const ChatItem(
      icon: Icon(Icons.chair, size: 40),
      title: 'Family',
      lastMessage: 'No events. Click to create one.',
      time: '',
    ),
    const ChatItem(
      icon: Icon(Icons.sports, size: 40),
      title: 'Sports',
      lastMessage: 'No events. Click to create one.',
      time: '',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, i) {
          return ChatItem(
              icon: _items[i].icon,
              title: _items[i].title,
              lastMessage: _items[i].lastMessage,
              time: _items[i].time);
        });
  }
}

class ChatItem extends StatefulWidget {
  final Icon icon;
  final String title;
  final String lastMessage;
  final String time;

  const ChatItem(
      {required this.icon,
      required this.title,
      required this.lastMessage,
      required this.time,
      Key? key})
      : super(key: key);

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  final _timeTextStyle = const TextStyle(
    fontSize: 16,
    color: Colors.grey,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        hoverColor: Colors.green,
        leading: widget.icon,
        title: Text(widget.title),
        subtitle: Text(widget.lastMessage),
        trailing: Text(widget.time, style: _timeTextStyle),
        onTap: () {},
      ),
      onHover: (val) {
        setState(() {});
      },
    );
  }
}
