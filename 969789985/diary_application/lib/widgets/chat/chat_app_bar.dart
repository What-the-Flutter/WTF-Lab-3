import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../basic/models/chat_model.dart';
import '../../basic/providers/chat_provider.dart';
import '../../basic/utils/strings.dart';
import '../../ui/utils/dimensions.dart';
import '../common/custom_dialog.dart';
import 'search_bar.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController textController;
  final TextEditingController searchTextController;
  final ChatProvider provider;
  final ChatModel chat;

  ChatAppBar({
    super.key,
    required this.textController,
    required this.provider,
    required this.chat,
    required this.searchTextController,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: !provider.isSelectMode
          ? Text(chat.chatTitle)
          : _removeButton(context),
      centerTitle: false,
      leading: _appBarLeading(context),
      actions: [
        _appBarActions(context),
      ],
    );
  }

  Widget _appBarLeading(BuildContext context) => !provider.isSelectMode
      ? IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        )
      : IconButton(
          onPressed: () {
            provider.unselectAll();
            provider.endEditMode();
          },
          icon: const Icon(Icons.close),
        );

  Widget _removeButton(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 150),
      scale: provider.isEditMode ? 0.0 : 1.0,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: provider.isEditMode ? 0 : 1,
        child: IconButton (
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => CustomDialog(
                  dialogTitle: Strings.deleteSelectedMessagesTitle,
                  dialogDescription:
                      const Text(Strings.deleteSelectedMessagesDescription),
                  completeAction: () {
                    provider.remove();
                    provider.unselectAll();
                    Navigator.pop(context);
                  },
                  cancelVisible: true,
                ),
              );
            },
            icon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.delete),
                const SizedBox(width: Insets.small),
                Text('${provider.selectedItemsCount}'),
              ],
            ),
          ),
        ),
      );
  }

  Widget _appBarActions(BuildContext context) => provider.isSelectMode
      ? _selectModeActions(context)
      : Row(
          children: [
            SearchBar(
              provider: provider,
              searchTextFieldController: searchTextController,
            ),
            IconButton(
              onPressed: () => provider.isFavoriteMode
                  ? provider.endFavoriteMode()
                  : provider.startFavoriteMode(),
              icon: provider.isFavoriteMode
                  ? const Icon(Icons.bookmark)
                  : const Icon(Icons.bookmark_border),
            ),
          ],
        );

  Widget _selectModeActions(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 150),
      scale: provider.isEditMode ? 0.0 : 1.0,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: provider.isEditMode ? 0 : 1,
        child: Row(
          children: [
            _editButton(provider),
            const SizedBox(width: Insets.small),
            IconButton(
              onPressed: () => provider.isFavoriteMode
                  ? provider.removeSelectedFromFavorites()
                  : provider.addSelectedToFavorites(),
              icon: const Icon(Icons.bookmark_border),
            ),
            const SizedBox(width: Insets.small),
            IconButton(
              onPressed: () {
                provider.copySelectedToBuffer();
                provider.unselectAll();
                Fluttertoast.showToast(msg: 'Text copied to buffer!');
              },
              icon: const Icon(Icons.content_copy),
            ),
            const SizedBox(width: Insets.small),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.turn_right),
            ),
            const SizedBox(width: Insets.small),
          ],
        ),
      ),
    );
  }

  Widget _editButton(ChatProvider provider) => AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: provider.selectedItemsCount == 1 ? 1.0 : 0.0,
        child: IconButton(
          onPressed: () {
            final index = provider.selectedItems.keys
                .firstWhere((index) => provider.selectedItems[index] == true);
            final message = provider.messages[index];
            textController.text = message.messageText;
            provider.startEditMode();
          },
          icon: const Icon(Icons.edit),
        ),
      );
}
