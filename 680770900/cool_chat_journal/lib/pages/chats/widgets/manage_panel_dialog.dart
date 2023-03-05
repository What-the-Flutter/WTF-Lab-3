import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/chat.dart';
import '../../edit_chat/edit_chat.dart';
import '../cubit/chats_cubit.dart';
import 'delete_dialog.dart';
import 'info_dialog.dart';

class ManagePanelDialog extends StatelessWidget {
  final Chat chat;

  const ManagePanelDialog({
    super.key,
    required this.chat,
  });

  void _createDeleteDialog(BuildContext context) async {
    final isDelete = await showModalBottomSheet<bool>(
      context: context,
      builder: (context) => const DeleteDialog(),
    );

    if (isDelete == true) {
      context.read<ChatsCubit>().deleteChat(chat.id);
    }
  }

  void _showInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => InfoDialog(chat: chat),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
            context.read<ChatsCubit>().switchChatPinning(chat.id);
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
          onTap: () async {
            Navigator.pop(context);

            final newChat = await Navigator.push<Chat>(
              context,
              MaterialPageRoute(
                builder: (_) => EditChat(oldChat: chat),
              ),
            );

            if (newChat != null) {
              context.read<ChatsCubit>().editChat(chat.id, newChat);
            }
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
    );
  }
}
