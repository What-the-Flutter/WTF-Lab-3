import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../common/data/chat_repository.dart';
import '../../../common/data/models/chat.dart';
import '../../../common/utils/confirmation_dialog.dart';
import '../../../common/utils/insets.dart';
import '../../../common/utils/text_styles.dart';
import '../../chat_adding_editing/view/manage_chat_page.dart';

class BottomActionSheet extends StatelessWidget {
  const BottomActionSheet({
    super.key,
    required this.chat,
  });

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Insets.large),
              child: ListTile(
                title: Text(chat.name),
                leading: Icon(chat.icon),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ChatInfoText(
                      bold: 'Created: ',
                      remaining: DateFormat.yMMMd('en_US')
                          .add_jm()
                          .format(chat.creationDate),
                    ),
                    _ChatInfoText(
                      bold: 'Active: ',
                      remaining: _durationScienceLastMessage(),
                    ),
                    _ChatInfoText(
                      bold: 'Messages: ',
                      remaining: chat.messages.length.toString(),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Text('Edit'),
              leading: const Icon(Icons.edit),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ManageChatPage(forEdit: chat),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(chat.isPinned ? 'Unpin' : 'Pin'),
              leading: const Icon(Icons.push_pin_outlined),
              onTap: () {
                RepositoryProvider.of<ChatRepository>(context).togglePin(chat);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text(
                'Delete',
                style: TextStyles.bodyRed(context),
              ),
              leading: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onTap: () async {
                var isConfirmed = await showConfirmationDialog(
                  title: 'Delete "${chat.name}" chat',
                  content: 'Are you sure you want to delete this chat?',
                  context: context,
                );
                if (isConfirmed != null && isConfirmed) {
                  RepositoryProvider.of<ChatRepository>(context)
                      .remove(chat);
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  String _durationScienceLastMessage() {
    Duration duration;
    if (chat.lastMessage != null) {
      duration = DateTime.now().difference(chat.lastMessage!.dateTime);
    } else {
      duration = DateTime.now().difference(chat.creationDate);
    }
    var days = duration.inDays;
    var hours = duration.inHours - days * 24;
    if (days == 0 && hours == 0) {
      return 'recently';
    }
    if (hours == 0) {
      return '$days ago';
    } else {
      return '$days days and $hours hours ago';
    }
  }
}

class _ChatInfoText extends StatelessWidget {
  const _ChatInfoText({
    super.key,
    required this.bold,
    required this.remaining,
  });

  final String bold;
  final String remaining;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: bold,
        style: TextStyles.defaultBold(context),
        children: [
          TextSpan(
            text: remaining,
            style: TextStyles.defaultStyle(context),
          ),
        ],
      ),
    );
  }
}
