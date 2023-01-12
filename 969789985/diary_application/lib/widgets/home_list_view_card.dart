import 'package:flutter/material.dart';

import '../../basic/models/chat_model.dart';

class HomeListViewCard extends StatefulWidget {
  HomeListViewCard({super.key, required this.chat});

  final ChatModel chat;

  @override
  State<StatefulWidget> createState() => _HomeListViewCardState();
}

class _HomeListViewCardState extends State<HomeListViewCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
      child: InkWell(
        radius: 25.0,
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              buildAvatar(widget.chat.id),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      widget.chat.chatTitle,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.chat.chatDescription,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //TODO:
  Widget buildAvatar(int index) {
    switch (index) {
      case 0:
        return Card(
          elevation: 0,
          color: Colors.grey[100]!,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: const SizedBox (
            width: 85.0,
            height: 85.0,
            child: Icon(Icons.chat),
          ),
        );
      case 1:
        return Card(
          elevation: 0,
          color: Colors.grey[100]!,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: const SizedBox (
            width: 80,
            height: 80,
            child: Icon(Icons.factory),
          ),
        );
      case 2:
        return Card(
          elevation: 0,
          color: Colors.grey[100]!,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: const SizedBox (
            width: 80,
            height: 80,
            child: Icon(Icons.safety_check),
          ),
        );
      default:
        return Card(
          elevation: 0,
          color: Colors.grey[100]!,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: const SizedBox (
            width: 80,
            height: 80,
            child: Icon(Icons.favorite),
          ),
        );
    }
  }
}
