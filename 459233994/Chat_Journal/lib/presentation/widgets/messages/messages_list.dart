import 'package:flutter/material.dart';
import '../../../domain/entities/packed_message.dart';
import 'message.dart';

class MessagesList extends StatelessWidget {
  final List<PackedMessage> _messages;
  final bool _isFavoritesMode;

  MessagesList({
    required messages,
    required isFavoritesMode,
  })  : _messages = messages,
        _isFavoritesMode = isFavoritesMode;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: (() {
              if (_isFavoritesMode) {
                if (_messages[index].isFavorite) {
                  return Message(
                    packedMessage: _messages[index],
                  );
                }
              } else {
                return Message(
                  packedMessage: _messages[index],
                );
              }
            }()),
          );
        },
      ),
    );
  }
}
