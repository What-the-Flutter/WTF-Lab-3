import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../entities/message.dart';
import '../../screens/travel_screen.dart';

class CopyMessageButton extends StatefulWidget {
  const CopyMessageButton({
    super.key,
    required this.listMessage,
  });
  final List<Message> listMessage;
  @override
  State<CopyMessageButton> createState() => _CopyMessageButtonState();
}

class _CopyMessageButtonState extends State<CopyMessageButton> {
  void copyMessage() async {
    var copyText = '';
    setState(
      () {
        for (var i = 0; i < widget.listMessage.length; i++) {
          if (widget.listMessage[i].isSelected) {
            copyText = widget.listMessage[i].messageContent;
            widget.listMessage[i].isSelected =
                !widget.listMessage[i].isSelected;
          }
        }
        TravelScreen.of(context).isSelected();
      },
    );
    await Clipboard.setData(
      ClipboardData(
        text: copyText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: copyMessage,
      child: const Icon(
        Icons.copy,
        color: Colors.white,
      ),
    );
  }
}
