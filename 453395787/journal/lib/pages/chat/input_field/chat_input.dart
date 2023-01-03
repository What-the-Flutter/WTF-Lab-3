import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../utils/insets.dart';
import '../../../utils/radius.dart';
import '../chat_provider.dart';

part 'input_mutable_button.dart';
part 'selected_images.dart';

class ChatInput extends StatelessWidget {
  ChatInput({super.key});

  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chat, child) {
        var initialText = chat.initialText;
        if (initialText != null) {
          _inputController.text = initialText;
        }

        return DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).hoverColor,
          ),
          child: Column(
            children: [
              if (chat.message.hasImages) _SelectedImagesList(chat: chat),
              Row(
                children: [
                  const IconButton(
                    onPressed: null,
                    icon: Icon(Icons.add),
                  ),
                  Expanded(
                    child: LimitedBox(
                      maxHeight: MediaQuery.of(context).size.width * 0.2,
                      child: Padding(
                        padding: const EdgeInsets.all(Insets.medium),
                        child: TextFormField(
                          controller: _inputController,
                          textCapitalization: TextCapitalization.sentences,
                          maxLines: null,
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
                    ),
                  ),
                  _ChatInputMutableButton(
                    onSendPressed: () {
                      chat.add(
                        chat.message.copyWith(
                          text: _inputController.text,
                        ),
                      );

                      _inputController.clear();
                      if (chat.isEditMode) {
                        chat.endEditMode();
                      } else {
                        chat.clearInputMessage();
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
}
