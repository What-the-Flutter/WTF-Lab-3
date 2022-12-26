import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../chat_repository.dart';
import '../../utils/styles.dart';
import 'chat_provider.dart';

class ChatInput extends StatelessWidget {
  ChatInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chat, child) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).hoverColor,
          ),
          child: Column(
            children: [
              if (chat.message.hasImages) _buildImageList(chat),
              Row(
                children: [
                  const IconButton(
                    onPressed: null,
                    icon: Icon(Icons.add),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: chat.inputTextController,
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
                      chat.add(
                        chat.message.copyWith(
                          text: chat.inputTextController.text,
                        ),
                      );

                      chat.inputTextController.clear();
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
        padding: const EdgeInsets.symmetric(
          vertical: Insets.medium,
        ),
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
                  padding: const EdgeInsets.all(
                    Insets.small,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      Radius.medium,
                    ),
                    child: Image.file(
                      File(
                        chat.message.images[index],
                      ),
                    ),
                  ),
                ),
              );
            }
            return IconButton(
              padding: const EdgeInsets.all(
                Insets.extraLarge,
              ),
              onPressed: () async {
                final images = await ImagePicker().pickMultiImage();
                chat.message = chat.message
                  ..images.addAll(
                    images.map((e) => e.path),
                  );
              },
              icon: const Icon(
                Icons.add,
              ),
            );
          },
        ),
      ),
    );
  }
}

class ChatInputMutableButton extends StatelessWidget {
  final void Function() onSendPressed;

  const ChatInputMutableButton({
    required this.onSendPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chat, child) {
        if (!chat.isInputImagesEmpty || chat.canBeSended) {
          return IconButton(
            icon: const Icon(Icons.send),
            onPressed: onSendPressed,
          );
        } else {
          return InkWell(
            onLongPress: () async {
              final image = await ImagePicker().pickImage(
                source: ImageSource.camera,
              );
              if (image != null) {
                chat.message = chat.message.copyWith(
                  images: [image.path],
                );
              }
            },
            onTap: () async {
              final images = await ImagePicker().pickMultiImage();
              var imagePaths = images.map((e) => e.path).toList();
              imagePaths.addAll(chat.message.images);
              chat.message = chat.message.copyWith(images: imagePaths);
            },
            child: const Padding(
              padding: EdgeInsets.all(
                Insets.medium,
              ),
              child: Icon(
                Icons.photo_album_outlined,
              ),
            ),
          );
        }
      },
    );
  }
}
