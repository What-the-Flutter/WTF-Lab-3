import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../basic/models/message_model.dart';
import '../../basic/providers/chat_provider.dart';
import '../../basic/utils/extensions.dart';

class ChatEditInputField extends StatelessWidget {
  ChatEditInputField({
    super.key,
    required this.editTextFieldController,
    required this.provider,
  });

  final TextEditingController editTextFieldController;
  final ChatProvider provider;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25.0),
            topLeft: Radius.circular(25.0),
          ),
          color: Theme.of(context).cardColor,
        ),
        duration: const Duration(milliseconds: 200),
        child: TextField(
          controller: editTextFieldController,
          autofocus: true,
          minLines: 1,
          maxLines: 5,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 25.0,
              horizontal: 15.0,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.new_label_outlined),
              ),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: IconButton(
                onPressed: () {
                  var index = provider.selectedItems.keys.firstWhere(
                      (index) => provider.selectedItems[index] == true);
                  var message = provider.messages[index];
                  provider.add(
                    MessageModel(
                      id: index,
                      messageText:
                          editTextFieldController.text.excludeEmptyLines(),
                      images: message.images,
                      sendDate: message.sendDate,
                    ),
                  );
                  editTextFieldController.clear();
                  provider.unselectAll();
                  provider.endEditMode();
                },
                icon: const Icon(Icons.check),
              ),
            ),
          ),
        ),
      );
}
