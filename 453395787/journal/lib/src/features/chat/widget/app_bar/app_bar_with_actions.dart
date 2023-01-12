part of '../../../chat/widget/app_bar/chat_app_bar.dart';

class _AppBarWithActions extends StatelessWidget {
  const _AppBarWithActions({
    required this.state,
    super.key,
  });

  final MessageManageSelectionMode state;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: MessageManageScope.of(context).resetSelection,
        icon: const Icon(
          Icons.close,
        ),
      ),
      title: Text(
        state.selected.length.toString(),
      ),
      actions: [
        IconButton(
          icon: Icon(
            state.hasMoreFavoritesInSelected!
                ? Icons.bookmark_outline
                : Icons.bookmark,
          ),
          onPressed: () {
            if (state.hasMoreFavoritesInSelected!) {
              MessageManageScope.of(context).removeFromFavorites();
            } else {
              MessageManageScope.of(context).addToFavorites();
            }
          },
        ),
        if (state.selected.length == 1)
          IconButton(
            icon: const Icon(
              Icons.edit,
            ),
            onPressed: context.read<MessageManageCubit>().startEditMode,
          ),
        IconButton(
          icon: const Icon(
            Icons.copy,
          ),
          onPressed: () {
            context.read<MessageManageCubit>().copyToClipboard();
            Fluttertoast.showToast(
              msg: 'Text copied to clipboard',
            );
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.reply_outlined,
          ),
          onPressed: () {
            final id = MessageManageScope.of(context).state.id;
            showFloatingModalBottomSheet(
              context: context,
              builder: (context) => MoveMessagePage(
                fromChatId: id,
                messages: state.messages
                    .where(
                      (message) => state.selected.contains(
                        message.id,
                      ),
                    )
                    .toIList(),
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.delete_outline_outlined,
          ),
          onPressed: () async {
            final isConfirmed = await showConfirmationDialog(
              context: context,
              title: 'Delete ${state.selected.length} messages',
              content: 'Are you sure you want to delete these messages?',
            );
            if (isConfirmed != null && isConfirmed) {
              MessageManageScope.of(context).remove();
            }
          },
        ),
      ],
    );
  }
}
