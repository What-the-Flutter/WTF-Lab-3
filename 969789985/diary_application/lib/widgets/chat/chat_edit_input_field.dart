import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../basic/models/message_model.dart';
import '../../basic/providers/chat_provider.dart';
import '../../basic/utils/extensions.dart';
import '../../ui/utils/dimensions.dart';

class ChatEditInputField extends StatelessWidget {
  final TextEditingController editTextFieldController;
  final ChatProvider provider;

  ChatEditInputField({
    super.key,
    required this.editTextFieldController,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(Radii.applicationConstant),
            topLeft: Radius.circular(Radii.applicationConstant),
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
              vertical: Insets.applicationConstantLarge,
              horizontal: Insets.applicationConstantMedium,
            ),
            prefixIcon: _prefixIcon(),
            suffixIcon: _suffixIcon(),
          ),
        ),
      );

  Widget _prefixIcon() => Padding(
        padding: const EdgeInsets.only(
          left: Insets.small,
          right: Insets.small,
        ),
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.new_label_outlined),
        ),
      );

  Widget _suffixIcon() {
    return Padding(
      padding: const EdgeInsets.only(right: Insets.medium),
      child: IconButton(
        onPressed: () {
          final index = provider.selectedItems.keys
              .firstWhere((index) => provider.selectedItems[index] == true);
          final message = provider.messages[index];
          provider.add(
            MessageModel(
              id: index,
              messageText: editTextFieldController.text.excludeEmptyLines(),
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
    );
  }
}
