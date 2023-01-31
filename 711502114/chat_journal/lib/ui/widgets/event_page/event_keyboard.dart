import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import 'keyboard_icon.dart';

class EventKeyboard extends StatelessWidget {
  final double width;
  final TextEditingController fieldText;
  final String fieldHint;
  final IconData rightIcon;
  final void Function() openDialog;
  final void Function() action;

  const EventKeyboard({
    Key? key,
    required this.width,
    required this.fieldText,
    required this.fieldHint,
    required this.rightIcon,
    required this.openDialog,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: messageBlocColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          KeyBoardIcon(
            icon: Icons.attach_file,
            onPressed: openDialog,
          ),
          Expanded(
            child: TextField(
              controller: fieldText,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              textInputAction: TextInputAction.newline,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: fieldHint,
                hintStyle: TextStyle(
                  fontSize: 20,
                  color: secondaryMessageTextColor,
                ),
              ),
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          KeyBoardIcon(icon: rightIcon, onPressed: action),
        ],
      ),
    );
  }
}
