import 'dart:math';

import 'package:flutter/material.dart';

import '../../chat/models/chat.dart';

class ChatCard extends StatelessWidget {
  final Chat chat;
  final VoidCallback? onOpenManagePanel;
  final VoidCallback? onOpenChat;

  const ChatCard({
    super.key,
    required this.chat,
    this.onOpenManagePanel,
    this.onOpenChat,
  });

  String _generateSubtitle({int maxLength = 20}) {
    final String subtitle;

    if (chat.events.isNotEmpty) {
      final event = chat.events.last;

      if (event.isImage) {
        subtitle = 'Image Entry';
      } else {
        final content = event.content;
        subtitle = content
            .replaceAll('\n', ' ')
            .substring(0, min(content.length, maxLength));
      }
    } else {
      subtitle = 'No events. Click to create one.';
    }

    return subtitle;
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onLongPress: onOpenManagePanel,
        onTap: onOpenChat,
        child: ListTile(
          leading: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.background,
                ),
                child: Icon(chat.icon),
              ),
              if (chat.isPinned)
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.push_pin,
                    size: 20,
                  ),
                ),
            ],
          ),
          title: Text(chat.name),
          subtitle: Text(_generateSubtitle()),
        ),
      ),
    );
  }
}
