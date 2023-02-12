import 'package:flutter/material.dart';

import '../../model/chat.dart';
import '../events_page/chat_page.dart';
import 'delete_dialog.dart';

class ChatCard extends StatelessWidget {
  final Chat chat;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const ChatCard({
    super.key,
    required this.chat,
    this.onDelete,
    this.onEdit,
  });

  void _createDeleteDialog(BuildContext context) {
    showModalBottomSheet<bool>(
      context: context,
      builder: (context) => const DeleteDialog(),
    ).then((isDelete) {
      if (isDelete != true) return;

      onDelete?.call();
    });
  }

  void _createManagePanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Info'),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.attach_file),
            title: const Text('Pin/Unpin Page'),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.archive),
            title: const Text('Archive Page'),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Page'),
            onTap: () {
              Navigator.pop(context);
              onEdit?.call();
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text('Delete Page'),
            onTap: () {
              Navigator.pop(context);
              _createDeleteDialog(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onDoubleTap: onDelete,
        onLongPress: () => _createManagePanel(context),
        onTap:() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(chat)
            ),
          );
        },
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.background,
            ),
            child: chat.icon,
          ),
          title: Text(chat.name),
          subtitle: const Text('Fix me!'),
        ),
      ),
    );
  }
}