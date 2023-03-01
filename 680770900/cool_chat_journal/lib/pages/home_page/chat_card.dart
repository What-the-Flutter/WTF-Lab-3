import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/chats_cubit.dart';
import '../../model/chat.dart';
import '../chat_page/chat_page.dart';
import 'manage_panel_dialog.dart';

class ChatCard extends StatelessWidget {
  final int chatIndex;
  final bool isPinned;

  ChatCard({
    super.key,
    required this.chatIndex,
    this.isPinned = false,
  });

  void _createManagePanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ManagePanelDialog(chatIndex: chatIndex),
    );
  }

  String _generateSubtitle(Chat chat, {int maxLength = 20}) {
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
    final chat = context.read<ChatsCubit>().state.chats[chatIndex];
    final subtitle = _generateSubtitle(chat);

    return Card(
      child: InkWell(
        onLongPress: () => _createManagePanel(context),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(chatIndex: chatIndex),
            ),
          );
        },
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
              if (isPinned)
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
          subtitle: Text(subtitle),
        ),
      ),
    );
  }
}
