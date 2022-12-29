import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/ui/screens/travel_screen.dart';

class CopyMessageButton extends StatefulWidget {
  final List<Event> listMessage;

  const CopyMessageButton({
    super.key,
    required this.listMessage,
  });

  @override
  State<CopyMessageButton> createState() => _CopyMessageButtonState();
}

class _CopyMessageButtonState extends State<CopyMessageButton> {
  void copyMessage() async {
    var copyText = '';

    setState(
      () {
        var index =
            widget.listMessage.indexWhere((element) => element.isSelected);

        widget.listMessage[index] = widget.listMessage[index].copyWith(
          isSelected: !widget.listMessage[index].isSelected,
        );
        copyText = widget.listMessage[index].messageContent;
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
