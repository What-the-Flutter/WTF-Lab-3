import 'package:flutter/material.dart';
import 'inherited_list.dart';
import 'message.dart';

class MessagesList extends StatefulWidget {
  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  @override
  Widget build(BuildContext context) {
    var messages = InheritedList.of(context)?.events;
    var favoritesMode = InheritedList.of(context)?.favoritesMode;
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: messages!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: (() {
              if (favoritesMode!) {
                if (messages[index].isFavorite) {
                  return Message(
                    packedMessage: messages[index],
                  );
                }
              } else {
                return Message(
                  packedMessage: messages[index],
                );
              }
            }()),
          );
        },
      ),
    );
  }
}
