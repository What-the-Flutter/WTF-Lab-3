import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../basic/models/message_model.dart';
import '../../basic/providers/chat_provider.dart';
import '../../basic/utils/extensions.dart';
import '../../basic/utils/strings.dart';
import '../../ui/utils/dimensions.dart';
import '../message/message_card.dart';
import 'empty_message.dart';

class Chat extends StatelessWidget {
  final ChatProvider provider;
  final TextEditingController searchTextController;

  Chat({
    super.key,
    required this.provider,
    required this.searchTextController,
  });

  @override
  Widget build(BuildContext context) {
    if (searchTextController.text.isNotEmpty) {
      if (provider.messages.isEmpty) {
        return const EmptyMessage(message: Strings.chatEmptyMessage);
      } else {
        return ChatBox(
          provider: provider,
          messagesList: provider.messages
              .where((element) => element.messageText
                  .toLowerCase()
                  .contains(searchTextController.text.toLowerCase()))
              .toList(),
        );
      }
    } else {
      if (provider.messages.isEmpty) {
        return const EmptyMessage(message: Strings.chatEmptyMessage);
      } else {
        if (provider.isFavoriteMode) {
          if (provider.hasFavorites()) {
            return ChatBox(
              provider: provider,
              messagesList: provider.messages
                  .where((element) => element.isFavorite == true)
                  .toList(),
            );
          } else {
            return const Center(
              child: Text('Favorites is clear'),
            );
          }
        } else {
          return ChatBox(
            provider: provider,
            messagesList: provider.messages.toList(),
          );
        }
      }
    }
  }
}

class ChatBox extends StatelessWidget {
  final ChatProvider provider;
  final List<MessageModel> messagesList;

  ChatBox({
    super.key,
    required this.provider,
    required this.messagesList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AnimationLimiter(
            child: GroupedListView<MessageModel, DateTime>(
              padding: const EdgeInsets.all(Insets.medium),
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
                      padding: const EdgeInsets.all(Insets.medium),
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
  }

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
              borderRadius: BorderRadius.circular(Radii.medium),
            ),
          ),
        ),
      );
}
