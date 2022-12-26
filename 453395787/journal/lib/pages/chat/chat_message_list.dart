import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../chat_repository.dart';
import 'chat_provider.dart';

class ChatMessageList extends StatelessWidget {
  ChatMessageList({Key? key}) : super(key: key);

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
              chat.hasSelected ?
                chat.toggleSelection(message) :
                _showActionMenu(context, message, chat);
            },
            onLongPress: (message, isSelected) {
              chat.toggleSelection(message);
            },
            isSelected: chat.isSelected(chat.messages[index]),
          ),
        );
      },
    );
  }

  Future<void> _showActionMenu(
      BuildContext context, 
      Message message, 
      ChatProvider chat) async {
    return await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(0, 200, 0, 0),
      color: Colors.blue[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      items: [
        PopupMenuItem(
          child: const ListTile(
            leading: Icon(Icons.copy_outlined),
            title: Text('Copy'),
          ),
          onTap: () => chat.copyToClipboard(message),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(message.isFavorite ? Icons.star_outline : Icons.star),
            title: Text(message.isFavorite ? 'Unstar' : 'Star'),
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
            leading: Icon(Icons.edit_outlined),
            title: Text('Edit'),
          ),
          onTap: () => chat.startEditMode(message),
        ),
        PopupMenuItem(
          child: const ListTile(
            leading: Icon(Icons.delete_outline),
            title: Text('Delete'),
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
      Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (message.isFavorite) 
                Icon(
                  Icons.star, color: 
                  Colors.blue[400],
                  size: 32,
                ),
              LimitedBox(
                maxWidth: MediaQuery.of(context).size.width * _widthScaleFactor,
                child: _buildMessageCard(),
              ),
            ],
          );
        }
      ),
    );
  }

  Card _buildMessageCard() {
    return Card(
      color: isSelected ? Colors.blue[200] : null,
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => onTap(message, isSelected),
        onLongPress: () => onLongPress(message, isSelected),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (message.images.isNotEmpty) _buildImages(),
              if (message.text.isNotEmpty) _buildText(),
              _buildTime(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImages() {
    if (message.hasSingleImage) {
      return _buildSingleImage(); 
    } else if (message.images.length.isEven) {
      return _buildEvenAmountOfImages();
    } else {
      return _buildOddAmountOfImages();
    }
  }

  Widget _buildSingleImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.file(
        File(message.images.first),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildEvenAmountOfImages({bool skipFirst = false}) {
    var imageAmount = message.images.length;
    if (skipFirst) imageAmount--;

    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(imageAmount, (index) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(message.images[skipFirst ? index+1 : index]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );   
      }),
    );
  }

  Widget _buildOddAmountOfImages() {
    return Column(
      children: [
        _buildSingleImage(),
        _buildEvenAmountOfImages(skipFirst: true), 
      ],
    );
  }

  Widget _buildText() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 0),
      child: Text(
        message.text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        )),
    );
  }

  Widget _buildTime() {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Text(message.time),
    );
  }
}
