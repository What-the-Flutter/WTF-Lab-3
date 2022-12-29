import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../chat_list_provider.dart';
import '../../chat_repository.dart';
import '../../utils/styles.dart';
import '../chat/chat_app_bar.dart';
import 'add_chat_page.dart';

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
                  RichText(
                    text: TextSpan(
                      text: 'Created: ',
                      style: DefaultTextStyle.of(context)
                          .style
                          .copyWith(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: DateFormat.yMMMd('en_US')
                              .add_jm()
                              .format(chat.creationDate),
                          style: DefaultTextStyle.of(context).style,
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Active: ',
                      style: DefaultTextStyle.of(context)
                          .style
                          .copyWith(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: _durationScienceLastMessage(),
                          style: DefaultTextStyle.of(context).style,
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Messages: ',
                      style: DefaultTextStyle.of(context)
                          .style
                          .copyWith(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: chat.messages.length.toString(),
                          style: DefaultTextStyle.of(context).style,
                        ),
                      ],
                    ),
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
                  builder: (context) => AddChatPage(forEdit: chat),
                ),
              );
            },
          ),
          ListTile(
            title: Text(chat.isPinned ? 'Unpin' : 'Pin'),
            leading: const Icon(Icons.attach_file_outlined),
            onTap: () {
              Provider.of<ChatListProvider>(context, listen: false)
                  .togglePin(chat);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: const Text('Delete'),
            leading: const Icon(Icons.delete),
            onTap: () async {
              var isConfirmed = await showConfirmationDialog(
                title: 'Delete "${chat.name}" chat',
                content: 'Are you sure you want to delete this chat?',
                context: context,
              );
              if (isConfirmed != null && isConfirmed) {
                Provider.of<ChatListProvider>(context, listen: false)
                    .remove(chat);
                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
    ));
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

class FloatingModal extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  const FloatingModal({
    Key? key,
    required this.child,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Insets.large),
        child: Material(
          color: backgroundColor,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(Radius.large),
          child: child,
        ),
      ),
    );
  }
}

Future<T> showFloatingModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? backgroundColor,
}) async {
  final result = await showCustomModalBottomSheet(
      context: context,
      builder: builder,
      containerWidget: (_, animation, child) {
        return FloatingModal(
          child: child,
        );
      },
      expand: false);

  return result;
}
