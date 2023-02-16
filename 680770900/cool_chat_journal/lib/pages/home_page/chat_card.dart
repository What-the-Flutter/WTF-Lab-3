import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/chat.dart';
import '../../themes/custom_theme.dart';
import '../add_chat_page/icon_view.dart';
import '../chat_page/chat_page.dart';
import 'delete_dialog.dart';

class ChatCard extends StatelessWidget {
  final Chat chat;
  final bool isPinned;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onPin;
  final DateFormat formatter = DateFormat.yMd().add_jm();

  ChatCard({
    super.key,
    required this.chat,
    this.isPinned = false,
    this.onPin,
    this.onDelete,
    this.onEdit,
  });

  void _showInfo(BuildContext context) {
    showDialog(
      context: context,
      builder:(context) => Center(
        child: Container(
          margin: const EdgeInsets.all(40.0),
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 20.0,
          ),
          color: CustomTheme.of(context).primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  IconView(
                    icon: chat.icon,
                    size: 60.0,  
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
      
              if (chat.events.isNotEmpty) 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    const Text(
                      'Latest Event',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  
                  Text(formatter.format(chat.events.last.changeTime)),
                  ],
                ),

              Container(
                margin: const EdgeInsets.only(top: 40.0),
                decoration: BoxDecoration(
                  color: CustomTheme.of(context).backgroundColor,
                ),
                child: TextButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.pop(context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

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
            onTap: () {
              Navigator.pop(context);
              _showInfo(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.attach_file),
            title: const Text('Pin/Unpin Page'),
            onTap: () {
              Navigator.pop(context);
              onPin?.call();
            },
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
          subtitle: const Text('Fix me!'),
        ),
      ),
    );
  }
}