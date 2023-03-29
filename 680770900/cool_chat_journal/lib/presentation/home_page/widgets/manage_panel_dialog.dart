import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/chat.dart';
import '../../../utils/custom_theme.dart';

class ManagePanelDialog extends StatelessWidget {
  final Chat chat;
  final VoidCallback? onDeleteChat;
  final VoidCallback? onSwitchChatPinning;
  final VoidCallback? onArchiveChat;
  final VoidCallback? onEditChat;

  const ManagePanelDialog({
    super.key,
    required this.chat,
    this.onDeleteChat,
    this.onSwitchChatPinning,
    this.onArchiveChat,
    this.onEditChat,
  });

  void _onDeleteChatDialog({
    required BuildContext context,
  }) async {
    Navigator.pop(context);

    final isDelete = await showModalBottomSheet<bool>(
      context: context,
      builder: (_) => const DeleteDialog(),
    );

    if (isDelete == true) {
      onDeleteChat?.call();
    }
  }

  void _onShowInfoDialog({
    required BuildContext context,
  }) {
    Navigator.pop(context);

    showDialog(
      context: context,
      builder: (context) => InfoDialog(chat: chat),
    );
  }

  void _onSwitchChatPinning({
    required BuildContext context,
  }) {
    Navigator.pop(context);
    onSwitchChatPinning?.call();
  }

  void _onArchiveChat({
    required BuildContext context,
  }) {
    Navigator.pop(context);
    onArchiveChat?.call();
  }

  void _onEditChat({
    required BuildContext context,
  }) {
    Navigator.pop(context);
    onEditChat?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('Info'),
          onTap: () => _onShowInfoDialog(context: context),
        ),
        ListTile(
          leading: const Icon(Icons.attach_file),
          title: const Text('Pin/Unpin Page'),
          onTap: () => _onSwitchChatPinning(context: context),
        ),
        ListTile(
          leading: const Icon(Icons.archive),
          title: const Text('Archive Page'),
          onTap: () => _onArchiveChat(context: context),
        ),
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text('Edit Page'),
          onTap: () => _onEditChat(context: context),
        ),
        ListTile(
          leading: const Icon(Icons.delete, color: Colors.red),
          title: const Text('Delete Page'),
          onTap: () => _onDeleteChatDialog(context: context),
        ),
      ],
    );
  }
}

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Delete Page?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15.0),
          const Text(
            'Are you sure you want delete this page?',
          ),
          TextButton.icon(
            onPressed: () => Navigator.pop(context, true),
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            label: const Text('Delete'),
          ),
          TextButton.icon(
            onPressed: () => Navigator.pop(context, false),
            icon: const Icon(
              Icons.cancel,
              color: Colors.blue,
            ),
            label: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}

class InfoDialog extends StatelessWidget {
  final Chat chat;

  const InfoDialog({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.yMd().add_jm();
    final theme = CustomTheme.of(context).themeData;

    return Center(
      child: Container(
        margin: const EdgeInsets.all(40.0),
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 20.0,
        ),
        color: theme.primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  margin: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: Icon(
                    IconData(chat.iconCode, fontFamily: 'MaterialIcons'),
                    color: Theme.of(context).colorScheme.onBackground,
                    size: 45.0,
                  ),
                ),
                Text(
                  chat.name,
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Text(
              'Created',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(formatter.format(chat.createdTime)),
            Container(
              margin: const EdgeInsets.only(top: 40.0),
              decoration: BoxDecoration(
                color: theme.backgroundColor,
              ),
              child: TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
