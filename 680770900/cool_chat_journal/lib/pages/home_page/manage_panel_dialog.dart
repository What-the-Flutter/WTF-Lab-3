import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/chats_cubit.dart';
import '../add_chat_page/add_chat_page.dart';
import 'delete_dialog.dart';
import 'info_dialog.dart';

class ManagePanelDialog extends StatelessWidget {
  final int chatIndex;

  const ManagePanelDialog({
    super.key,
    required this.chatIndex,
  });

  void _createDeleteDialog(BuildContext context) async {
    final isDelete = await showModalBottomSheet<bool>(
      context: context,
      builder: (context) => const DeleteDialog(),
    );

    if (isDelete == true) {
      context.read<ChatsCubit>().deletedChat(chatIndex);
    }
  }

  void _showInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => InfoDialog(
        chat: context.read<ChatsCubit>().state.chats[chatIndex],
      ),
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
            context.read<ChatsCubit>().pinChat(chatIndex);
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

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddChatPage(oldChatIndex: chatIndex),
              ),
            );
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
