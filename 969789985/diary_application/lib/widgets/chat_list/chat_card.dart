import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../basic/models/chat_model.dart';
import '../../ui/screens/chat_screen.dart';

class ChatCard extends StatefulWidget {
  ChatCard({
    super.key,
    required this.chat,
    required this.isActionsVisible,
  });

  final ChatModel chat;
  final bool isActionsVisible;

  @override
  State<StatefulWidget> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  final String _firstPopupSelection = 'first_popup_selection';
  final String _secondPopupSelection = 'second_popup_selection';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      margin: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
      child: MaterialButton(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        onPressed: widget.isActionsVisible ? _navigateToChatPage : () {},
        child: Padding(
          padding: const EdgeInsets.only(
              top: 30.0, bottom: 30.0, right: 15.0, left: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _chatIcon(),
                  const SizedBox(width: 15.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chat.chatTitle,
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        DateFormat.yMMMMd().format(widget.chat.creationDate),
                      ),
                    ],
                  ),
                  const Spacer(),
                  _popupMenu(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _popupMenu() => Visibility(
    visible: widget.isActionsVisible,
    child: Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: _firstPopupSelection,
            child: Row(
              children: [
                const Icon(Icons.edit),
                const SizedBox(
                  // sized box with width 10
                  width: 10,
                ),
                const Text('Edit'),
              ],
            ),
          ),
          PopupMenuItem(
            value: _secondPopupSelection,
            child: Row(
              children: [
                const Icon(Icons.delete),
                const SizedBox(
                  // sized box with width 10
                  width: 10,
                ),
                const Text('Delete'),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _chatIcon() => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50.0),
    ),
    width: 52.0,
    height: 52.0,
    child: Icon(
      widget.chat.chatIcon,
      key: ValueKey<String>(widget.chat.chatTitle),
      size: 52.0,
      color: Colors.black,
    ),
  );

  void _navigateToChatPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatScreen(chat: widget.chat),
      ),
    );
  }
}
