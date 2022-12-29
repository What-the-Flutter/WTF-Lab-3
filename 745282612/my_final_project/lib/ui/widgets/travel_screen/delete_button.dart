import 'package:flutter/material.dart';

import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/entities/provider_chat.dart';
import 'package:my_final_project/ui/screens/travel_screen.dart';
import 'package:provider/provider.dart';

class DeleteButton extends StatefulWidget {
  final List<Event> listMessage;

  const DeleteButton({
    super.key,
    required this.listMessage,
  });

  @override
  State<DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  void deleteMessage() {
    setState(
      () {
        widget.listMessage.removeWhere((element) => element.isSelected);
        TravelScreen.of(context).isSelected();
        Provider.of<ChatProvider>(context, listen: false).isUpdate();
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
