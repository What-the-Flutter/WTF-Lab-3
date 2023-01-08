part of 'chat_message_list.dart';

Future<void> _showActionMenu(
  BuildContext context,
  Message message,
) async {
  return await showMenu(
    context: context,
    position: const RelativeRect.fromLTRB(0, 200, 0, 0),
    color: Theme.of(context).colorScheme.surfaceVariant,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        Radius.large,
      ),
    ),
    items: [
      PopupMenuItem(
        child: const ListTile(
          leading: Icon(
            Icons.copy_outlined,
          ),
          title: Text('Copy'),
        ),
        onTap: () {
          context.read<MessageManageCubit>().copyToClipboard(message);
          Fluttertoast.showToast(
            msg: 'Text copied to clipboard',
          );
        },
      ),
      PopupMenuItem(
        child: const ListTile(
          leading: Icon(
            Icons.reply_outlined,
          ),
          title: Text('Move'),
        ),
        onTap: () {
          print('hello');
          showFloatingModalBottomSheet(
            context: context,
            builder: (context) => ChooseColorSheet(),
          );
        },
      ),
      PopupMenuItem(
        child: ListTile(
          leading: Icon(
            message.isFavorite ? Icons.star_outline : Icons.star,
          ),
          title: Text(
            message.isFavorite ? 'Unstar' : 'Star',
          ),
        ),
        onTap: () {
          if (message.isFavorite) {
            context.read<MessageManageCubit>().removeFromFavorites(message);
          } else {
            context.read<MessageManageCubit>().addToFavorites(message);
          }
        },
      ),
      PopupMenuItem(
        child: const ListTile(
          leading: Icon(
            Icons.edit_outlined,
          ),
          title: Text(
            'Edit',
          ),
        ),
        onTap: () => context.read<MessageManageCubit>().startEditMode(message),
      ),
      PopupMenuItem(
        child: const ListTile(
          leading: Icon(
            Icons.delete_outline,
          ),
          title: Text(
            'Delete',
          ),
        ),
        onTap: () => context.read<MessageManageCubit>().remove(message),
      ),
    ],
  );
}
