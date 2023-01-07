part of 'chat_app_bar.dart';

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
        onPressed: context.read<MessageManageCubit>().resetSelection,
        icon: const Icon(Icons.close),
      ),
      title: Text(state.selected.length.toString()),
      actions: [
        IconButton(
          icon: Icon(
            state.selected.length < state.messages.length
                ? Icons.bookmark
                : Icons.bookmark_outline,
          ),
          onPressed: () {
            if (state.selected.length < state.messages.length) {
              context.read<MessageManageCubit>().addToFavorites();
            } else {
              context.read<MessageManageCubit>().removeFromFavorites();
            }
          },
        ),
        if (state.selected.length == 1)
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: context.read<MessageManageCubit>().startEditMode,
          ),
        IconButton(
          icon: const Icon(Icons.copy),
          onPressed: () {
            context.read<MessageManageCubit>().copyToClipboard();
            Fluttertoast.showToast(
              msg: 'Text copied to clipboard',
            );
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.delete_outline_outlined,
          ),
          onPressed: () async {
            var isConfirmed = await showConfirmationDialog(
              context: context,
              title: 'Delete ${state.selected.length} messages',
              content: 'Are you sure you want to delete these messages?',
            );
            if (isConfirmed != null && isConfirmed) {
              context.read<MessageManageCubit>().remove();
            }
          },
        ),
      ],
    );
  }
}
