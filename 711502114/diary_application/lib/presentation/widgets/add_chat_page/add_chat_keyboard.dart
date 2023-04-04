import 'package:diary_application/theme/colors.dart';
import 'package:flutter/material.dart';

class AddChatKeyboard extends StatelessWidget {
  final Function(String val) onTyping;
  final String defaultValue;
  final String pageLabel;

  const AddChatKeyboard({
    Key? key,
    required this.onTyping,
    required this.defaultValue,
    required this.pageLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextFormField(
        initialValue: defaultValue,
        onChanged: onTyping,
        keyboardType: TextInputType.multiline,
        maxLines: 1,
        textInputAction: TextInputAction.done,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          fillColor: botBackgroundColor,
          filled: true,
          border: InputBorder.none,
          labelText: pageLabel,
          hintStyle: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        style: TextStyle(fontSize: 20, color: addTextColor),
      ),
    );
  }
}
