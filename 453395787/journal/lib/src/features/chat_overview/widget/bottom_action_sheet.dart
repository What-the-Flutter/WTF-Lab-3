part of '../view/chat_overview_page.dart';

class _BottomChatActionSheet extends StatelessWidget {
  const _BottomChatActionSheet({
    super.key,
    required this.chat,
  });

  final ChatView chat;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Insets.large,
            ),
            child: ListTile(
              title: Text(chat.name),
              leading: Icon(chat.icon),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ChatInfoText(
                    bold: 'Created: ',
                    remaining: chat.creationDate.formatFullDateTime,
                  ),
                  _ChatInfoText(
                    bold: 'Active: ',
                    remaining: _durationScienceLastMessage(),
                  ),
                  _ChatInfoText(
                    bold: 'Messages: ',
                    remaining: chat.messageAmount.toString(),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text('Edit'),
            leading: const Icon(Icons.edit),
            onTap: () {
              context.pop();
              context.go(
                PagePaths.chatEditing.path.withArgs(
                  {':chatId': '${chat.id}'},
                ),
              );
            },
          ),
          ListTile(
            title: Text(chat.isPinned ? 'Unpin' : 'Pin'),
            leading: const Icon(Icons.push_pin_outlined),
            onTap: () {
              RepositoryProvider.of<ChatRepository>(context).togglePin(chat);
              context.pop();
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
              final isConfirmed = await showConfirmationDialog(
                title: 'Delete "${chat.name}" chat',
                content: 'Are you sure you want to delete this chat?',
                context: context,
              );
              if (isConfirmed != null && isConfirmed) {
                RepositoryProvider.of<ChatRepository>(context).remove(chat);
                context.pop();
              }
            },
          ),
        ],
      ),
    );
  }

  String _durationScienceLastMessage() {
    final duration = DateTime.now()
        .difference(chat.messagePreviewCreationTime ?? chat.creationDate);

    final days = duration.inDays;
    final hours = duration.inHours - days * 24;
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
