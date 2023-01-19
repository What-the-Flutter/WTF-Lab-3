import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';

import '../../basic/models/chat_model.dart';
import '../../basic/models/message_model.dart';
import '../../basic/providers/chat_list_provider.dart';
import '../../basic/providers/chat_provider.dart';
import '../../basic/utils/extensions.dart';
import '../../widgets/chat/chat_edit_input_field.dart';
import '../../widgets/chat/chat_input_field.dart';
import '../../widgets/message/message_card.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.chat});

  final ChatModel chat;

  final TextEditingController _chatTextFieldController =
      TextEditingController();
  final TextEditingController _editTextFieldController =
      TextEditingController();
  final TextEditingController _searchTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatProvider>(
      create: (context) => ChatProvider(
        chatListProvider: Provider.of<ChatListProvider>(
          context,
          listen: false,
        ),
        chatId: chat.id,
      ),
      builder: (context, child) {
        return Consumer<ChatProvider>(
          builder: (context, provider, child) {
            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                title: !provider.isSelectMode
                    ? Text(chat.chatTitle)
                    : _removeButton(provider),
                centerTitle: false,
                leading: _appBarLeading(context, provider),
                actions: [
                  _appBarActions(context, provider),
                ],
              ),
              bottomNavigationBar: _bottomPanel(context, provider),
              body: _chat(context, provider),
            );
          },
        );
      },
    );
  }

  Widget _chat(BuildContext context, ChatProvider provider) =>
      provider.messages.isEmpty
          ? const Center(
              child: Text('Your chat is clear now'),
            )
          : provider.isFavoriteMode
              ? provider.hasFavorites()
                  ? _chatBox(
                      context,
                      provider,
                      provider.messages
                          .where((element) => element.isFavorite == true)
                          .toList(),
                    )
                  : const Center(
                      child: Text('Favorites is clear'),
                    )
              : _chatBox(context, provider, provider.messages.toList());

  Widget _chatBox(BuildContext context, ChatProvider provider,
          List<MessageModel> messagesList) =>
      Column(
        children: [
          Expanded(
            child: AnimationLimiter(
              child: GroupedListView<MessageModel, DateTime>(
                padding: const EdgeInsets.all(8.0),
                reverse: true,
                order: GroupedListOrder.DESC,
                useStickyGroupSeparators: true,
                floatingHeader: true,
                elements: messagesList,
                groupBy: (message) => DateTime(
                  message.sendDate.year,
                  message.sendDate.month,
                  message.sendDate.day,
                ),
                groupHeaderBuilder: (message) => SizedBox(
                  height: 40.0,
                  child: Center(
                    child: Card(
                      elevation: 0,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          message.sendDate.dateYMMMDFormat(),
                        ),
                      ),
                    ),
                  ),
                ),
                itemBuilder: (context, message) => _messageBox(
                  provider,
                  message,
                ),
              ),
            ),
          ),
        ],
      );

  Widget _messageBox(ChatProvider provider, MessageModel message) =>
      AnimationConfiguration.staggeredList(
        position: message.id,
        duration: const Duration(milliseconds: 375),
        child: SlideAnimation(
          verticalOffset: 50.0,
          child: FadeInAnimation(
            child: Align(
              alignment: Alignment.centerRight,
              child: MessageCard(
                provider: provider,
                message: message,
                selectionCheckBox: _selectionCheckbox(provider, message.id),
                longPressAction: () {
                  provider.selectMessage(message.id);
                },
                pressedAction: () => provider.isSelectMode
                    ? provider.selectMessage(message.id)
                    : {},
              ),
            ),
          ),
        ),
      );

  Widget _bottomPanel(BuildContext context, ChatProvider provider) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: provider.isEditMode
            ? ChatEditInputField(
                editTextFieldController: _editTextFieldController,
                provider: provider,
              )
            : ChatInputField(
                chatTextFieldController: _chatTextFieldController,
                provider: provider,
              ),
      );

  Widget _appBarLeading(BuildContext context, ChatProvider provider) =>
      !provider.isSelectMode
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

  Widget _removeButton(ChatProvider provider) => AnimatedScale(
        duration: const Duration(milliseconds: 150),
        scale: provider.isEditMode ? 0.0 : 1.0,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: provider.isEditMode ? 0 : 1,
          child: SizedBox(
            width: 140.0,
            height: 40.0,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              onPressed: () {
                provider.remove();
                provider.unselectAll();
              },
              child: Row(
                children: [
                  const Icon(Icons.delete),
                  const SizedBox(width: 5.0),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                    child: Text('Remove: ${provider.selectedItemsCount}'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _appBarActions(BuildContext context, ChatProvider provider) =>
      provider.isSelectMode
          ? _selectModeActions(context, provider)
          : Row(
              children: [
                AnimSearchBar(
                  width: MediaQuery.of(context).size.width * 0.7,
                  textController: _searchTextEditingController,
                  onSuffixTap: () {},
                  onSubmitted: (text) {},
                  helpText: 'Search...',
                  rtl: true,
                  autoFocus: true,
                  boxShadow: false,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  textFieldColor: Theme.of(context).scaffoldBackgroundColor,
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

  Widget _selectModeActions(BuildContext context, ChatProvider provider) =>
      AnimatedScale(
        duration: const Duration(milliseconds: 150),
        scale: provider.isEditMode ? 0.0 : 1.0,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: provider.isEditMode ? 0 : 1,
          child: Row(
            children: [
              _editButton(provider),
              const SizedBox(width: 5.0),
              IconButton(
                onPressed: () => provider.isFavoriteMode
                    ? provider.removeSelectedFromFavorites()
                    : provider.addSelectedToFavorites(),
                icon: const Icon(Icons.bookmark_border),
              ),
              const SizedBox(width: 5.0),
              IconButton(
                onPressed: () => provider.copySelectedToBuffer(),
                icon: const Icon(Icons.content_copy),
              ),
              const SizedBox(width: 5.0),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.turn_right),
              ),
              const SizedBox(width: 5.0),
            ],
          ),
        ),
      );

  Widget _editButton(ChatProvider provider) => AnimatedSlide(
        duration: const Duration(milliseconds: 150),
        offset: provider.selectedItemsCount == 1
            ? const Offset(0.0, 0)
            : const Offset(0.0, -1.5),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: provider.selectedItemsCount == 1 ? 1 : 0,
          child: IconButton(
            onPressed: () {
              var index = provider.selectedItems.keys
                  .firstWhere((index) => provider.selectedItems[index] == true);
              var message = provider.messages[index];
              _editTextFieldController.text = message.messageText;
              provider.startEditMode();
            },
            icon: const Icon(Icons.edit),
          ),
        ),
      );

  Widget _selectionCheckbox(ChatProvider provider, int index) => AnimatedSlide(
        duration: const Duration(milliseconds: 200),
        offset: provider.isSelectMode && !provider.isEditMode
            ? const Offset(0.2, 0)
            : const Offset(-1.0, 0),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: provider.isSelectMode && !provider.isEditMode ? 1 : 0,
          child: Checkbox(
            value: provider.selectedItems[index],
            onChanged: (value) {
              provider.selectMessage(index);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
        ),
      );
}
