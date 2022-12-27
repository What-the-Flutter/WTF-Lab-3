import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../chat_repository.dart';
import '../../utils/styles.dart';
import 'chat_provider.dart';

class ChatMessageList extends StatelessWidget {
  ChatMessageList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chat, child) {
        return ListView.builder(
          reverse: true,
          shrinkWrap: true,
          itemCount: chat.messages.length,
          itemBuilder: (context, index) => MessageItem(
            message: chat.messages[index],
            onTap: (message, isSelected) {
              chat.hasSelected
                  ? chat.toggleSelection(message)
                  : _showActionMenu(context, message, chat);
            },
            onLongPress: (message, isSelected) {
              chat.toggleSelection(message);
            },
            isSelected: chat.isSelected(
              chat.messages[index],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showActionMenu(
    BuildContext context,
    Message message,
    ChatProvider chat,
  ) async {
    return await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(0, 200, 0, 0),
      color: Colors.blue[50],
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
            chat.copyToClipboard(message);
            Fluttertoast.showToast(
              msg: 'Text copied to clipboard',
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
              chat.removeFromFavorites(message);
            } else {
              chat.addToFavorites(message);
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
          onTap: () => chat.startEditMode(message),
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
          onTap: () => chat.remove(message),
        ),
      ],
    );
  }
}

class MessageItem extends StatelessWidget {
  final Message message;
  final void Function(Message message, bool isSelected) onTap;
  final void Function(Message message, bool isSelected) onLongPress;
  final bool isSelected;

  double get _widthScaleFactor => isSelected ? 0.75 : 0.8;

  const MessageItem({
    required this.message,
    required this.onTap,
    required this.onLongPress,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: LayoutBuilder(builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (message.isFavorite)
              Icon(
                Icons.star,
                color: Colors.blue[400],
                size: 32,
              ),
            LimitedBox(
              maxWidth: MediaQuery.of(context).size.width * _widthScaleFactor,
              child: Card(
                color: isSelected ? Colors.blue[200] : null,
                margin: const EdgeInsets.symmetric(
                  vertical: Insets.extraSmall,
                  horizontal: Insets.large,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    Radius.medium,
                  ),
                ),
                child: InkWell(
                  onTap: () => onTap(
                    message,
                    isSelected,
                  ),
                  onLongPress: () => onLongPress(
                    message,
                    isSelected,
                  ),
                  borderRadius: BorderRadius.circular(
                    Radius.medium,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                      Insets.extraSmall,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (message.images.isNotEmpty)
                          _MessageImages(
                            message: message,
                          ),
                        if (message.text.isNotEmpty)
                          _MessageText(
                            text: message.text,
                          ),
                        _MessageTime(
                          time: message.time,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _MessageImages extends StatelessWidget {
  final Message message;

  const _MessageImages({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (message.hasSingleImage) {
      return _SingleImage(
        image: message.images.first,
      );
    } else if (message.images.length.isEven) {
      return _EvenAmountOfImages(
        images: message.images,
      );
    } else {
      return _OddAmountOfImages(
        images: message.images,
      );
    }
  }
}

class _SingleImage extends StatelessWidget {
  final String image;

  const _SingleImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        Radius.medium,
      ),
      child: Image.file(
        File(image),
        fit: BoxFit.cover,
      ),
    );
  }
}

class _EvenAmountOfImages extends StatelessWidget {
  final List<String> images;
  final bool skipFirst;

  const _EvenAmountOfImages({
    Key? key,
    required this.images,
    this.skipFirst = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageAmount = images.length;
    if (skipFirst) imageAmount--;

    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(imageAmount, (index) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(
              Insets.extraSmall,
            ),
            // TODO _SingleImage here?
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                Radius.medium,
              ),
              child: Image.file(
                File(
                  images[skipFirst ? index + 1 : index],
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _OddAmountOfImages extends StatelessWidget {
  final List<String> images;

  const _OddAmountOfImages({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SingleImage(image: images.first),
        _EvenAmountOfImages(
          images: images,
          skipFirst: true,
        ),
      ],
    );
  }
}

class _MessageText extends StatelessWidget {
  final String text;

  const _MessageText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Insets.medium,
        top: Insets.medium,
        right: Insets.medium,
        bottom: Insets.none,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _MessageTime extends StatelessWidget {
  final String time;

  const _MessageTime({
    Key? key,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        Insets.extraSmall,
      ),
      child: Text(time),
    );
  }
}
