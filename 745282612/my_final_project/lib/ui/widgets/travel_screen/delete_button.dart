import 'package:flutter/material.dart';

import '../../../entities/message.dart';
import '../../screens/travel_screen.dart';

class DeleteButton extends StatefulWidget {
  const DeleteButton({
    super.key,
    required this.listMessage,
  });
  final List<Message> listMessage;
  @override
  State<DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  void deleteMessage() {
    setState(
      () {
        widget.listMessage.removeWhere((element) => element.isSelected);
        TravelScreen.of(context).isSelected();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: deleteMessage,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }
}
