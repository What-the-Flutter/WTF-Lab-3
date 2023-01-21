part of '../view/chat_overview_page.dart';

class _BottomChatActionSheet extends StatelessWidget {
  const _BottomChatActionSheet({
    super.key,
    required this.chat,
  });

  final Chat chat;

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
                    bold: locale.Hints.itemCreated.i18n(),
                    remaining: chat.creationDate.formatFullDateTime,
                  ),
                  _ChatInfoText(
                    bold: locale.Hints.itemActive.i18n(),
                    remaining: _durationScienceLastMessage(),
                  ),
                  _ChatInfoText(
                    bold: locale.Hints.itemMessages.i18n(),
                    remaining: chat.messageAmount.toString(),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text(
              locale.Actions.edit.i18n(),
            ),
            leading: const Icon(Icons.edit),
            onTap: () {
              context.pop();
              context.go(
                Navigation.editChatPagePath.withArgs(
                  {':chatId': '${chat.id}'},
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              chat.isPinned
                  ? locale.Actions.unpin.i18n()
                  : locale.Actions.pin.i18n(),
            ),
            leading: const Icon(Icons.push_pin_outlined),
            onTap: () {
              RepositoryProvider.of<ChatRepository>(context).togglePin(chat);
              context.pop();
            },
          ),
          ListTile(
            title: Text(
              locale.Actions.delete.i18n(),
              style: TextStyles.bodyRed(context),
            ),
            leading: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onTap: () async {
              final isConfirmed = await showConfirmationDialog(
                title:
                    locale.Info.chatDeleteConfirmationTitle.i18n([chat.name]),
                content: locale.Info.chatDeleteConfirmationContent.i18n(),
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
    final duration = DateTime.now().difference(
      chat.messagePreviewCreationTime,
    );

    final days = duration.inDays;
    final hours = duration.inHours - days * 24;
    if (days == 0 && hours == 0) {
      return locale.Info.lastMessageRecently.i18n();
    } else if (hours == 0) {
      return locale.Info.lastMessageWithDays.i18n([days.toString()]);
    }

    return locale.Info.lastMessageWithDaysAndHours.i18n([
      days.toString(),
      hours.toString(),
    ]);
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
