part of 'chat_app_bar.dart';

class _AppBarWithActions extends StatelessWidget {
  const _AppBarWithActions({
    super.key,
    required this.chat,
  });

  final ChatProvider chat;

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
            chat.canAddSelectedToFavorites
                ? Icons.bookmark
                : Icons.bookmark_outline,
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
          onPressed: () {
            chat.copySelectedToClipboard();
            Fluttertoast.showToast(
              msg: 'Text copied to clipboard',
            );
          },
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
