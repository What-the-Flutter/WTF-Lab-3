import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/styles.dart';
import 'chat_provider.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chat, child) {
        if (chat.isEditMode) {
          return _AppBarWithCancelButton(
            chat: chat,
          );
        } else if (chat.hasSelected) {
          return _AppBarWithActions(
            chat: chat,
          );
        } else {
          return _DefaultAppBar(
            chat: chat,
          );
        }
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarWithCancelButton extends StatelessWidget {
  final ChatProvider chat;

  const _AppBarWithCancelButton({
    Key? key,
    required this.chat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: chat.endEditMode,
        icon: const Icon(Icons.close),
      ),
      title: Text(chat.name),
    );
  }
}

class _AppBarWithActions extends StatelessWidget {
  final ChatProvider chat;

  const _AppBarWithActions({
    Key? key,
    required this.chat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: chat.resetSelected,
        icon: const Icon(Icons.close),
      ),
      title: Text(chat.selected.length.toString()),
      actions: [
        IconButton(
          icon: Icon(
            chat.canAddSelectedToFavorites ? Icons.star : Icons.star_outline,
          ),
          onPressed: () {
            if (chat.canAddSelectedToFavorites) {
              chat.addSelectedToFavorites();
            } else {
              chat.removeSelectedFromFavorites();
            }
          },
        ),
        if (chat.isSingleSelected)
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: chat.startEditModeForSelected,
          ),
        IconButton(
          icon: const Icon(Icons.copy),
          onPressed: chat.copySelectedToClipboard,
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline_outlined),
          onPressed: () async {
            var isConfirmed = await showConfirmationDialog(
              context: context,
              title: 'Delete ${chat.selected.length} messages',
              content: 'Are you sure you want to delete these messages?',
            );
            if (isConfirmed != null && isConfirmed) {
              chat.removeSelected();
            }
          },
        ),
      ],
    );
  }
}

class _DefaultAppBar extends StatelessWidget {
  final ChatProvider chat;

  const _DefaultAppBar({
    Key? key,
    required this.chat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar(title: Text(chat.name));
}

Future<bool?> showConfirmationDialog({
  required String title,
  required String content,
  required BuildContext context,
}) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Ok'),
        ),
      ],
      titlePadding: const EdgeInsets.only(
        left: Insets.large,
        right: Insets.large,
        top: Insets.large,
        bottom: Insets.none,
      ),
      contentPadding: const EdgeInsets.only(
        left: Insets.large,
        right: Insets.large,
        top: Insets.medium,
        bottom: Insets.none,
      ),
      actionsPadding: const EdgeInsets.only(
        left: Insets.large,
        right: Insets.large,
        top: Insets.none,
        bottom: Insets.medium,
      ),
    ),
  );
}
