import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/chat.dart';
import '../../chat/chat_page.dart';
import '../../chat/cubit/chat_cubit.dart';
import 'manage_panel_dialog.dart';

class ChatCard extends StatelessWidget {
  final Chat chat;

  ChatCard({
    super.key,
    required this.chat,
  });

  void _createManagePanel(BuildContext context) {
    final chatCubit = context.read<ChatCubit>();

    showModalBottomSheet(
      context: context,
      builder: (context) => BlocProvider.value(
        value: chatCubit,
        child: ManagePanelDialog(chat: chat),
      ),
    );
  }

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
    final subtitle = _generateSubtitle();

    return Card(
      child: InkWell(
        onLongPress: () => _createManagePanel(context),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(chat: chat),
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
          subtitle: Text(subtitle),
        ),
      ),
    );
  }
}
