import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../chat_repository.dart';
import 'chat_provider.dart';

class ChatInput extends StatelessWidget {
  final _textController = TextEditingController();

  ChatInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chat, child) {
        var text = chat.inputInitialValue;
        if (text != null) {
          _textController.text = text;
        }

        return DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).hoverColor,
          ),
          child: Column(
            children: [
              if (chat.message.hasImages) _buildImageList(chat),
              Row(
                children: [
                  const IconButton(onPressed: null, icon: Icon(Icons.add)),
                  Expanded(
                    child: TextFormField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        isCollapsed: true,
                        hintText: 'Message',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (text) {
                        if (chat.canBeSended != text.isNotEmpty) {
                          chat.canBeSended = text.isNotEmpty;
                        }
                      },
                    ),
                  ),
                  ChatInputMutableButton(
                    onSendPressed: () {
                        chat.add(chat.message.copyWith(
                          text: _textController.text
                        ));

                        _textController.clear();
                        if (chat.isEditMode) {
                          chat.endEditMode();
                        } else {
                          chat.message = Message();
                        }
                        chat.canBeSended = false;
                    }, 
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageList(ChatProvider chat) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: chat.message.images.length + 1,
          itemBuilder: (_, index) {
            if (index != chat.message.images.length) {
              return GestureDetector(
                  onDoubleTap: () {
                    chat.message = chat.message..images.removeAt(index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(File(chat.message.images[index]))
                    ),
                  )
              );
            }
            return IconButton(
              padding: const EdgeInsets.all(40),
                onPressed: () async {
                  final images = await ImagePicker().pickMultiImage();
                  chat.message = chat.message..images.addAll(images.map((e) => e.path));
                },
                icon: const Icon(Icons.add),
            );
          }
        ),
      ),
    );
  }
}

class ChatInputMutableButton extends StatelessWidget {
  final void Function() onSendPressed;

  const ChatInputMutableButton({
    required this.onSendPressed, 
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: ((context, chat, child) {
        if (!chat.isInputImagesEmpty || chat.canBeSended) {
          return IconButton(
            icon: const Icon(Icons.send),
            onPressed: onSendPressed,
          );
        } else {
          return IconButton(
            icon: const Icon(Icons.photo_album_outlined),
            onPressed: () async {
              final images = await ImagePicker().pickMultiImage();
              chat.message = chat.message..images.addAll(images.map((e) => e.path));
            },
          );
        }   
      }),
    );
  }
}
