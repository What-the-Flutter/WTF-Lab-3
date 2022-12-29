import 'package:flutter/material.dart';

import 'package:my_final_project/entities/provider_chat.dart';
import 'package:provider/provider.dart';

class AddPageFloatingButton extends StatelessWidget {
  final bool status;
  final Icon? selected;
  final TextEditingController controller;
  final bool editStatus;

  const AddPageFloatingButton({
    super.key,
    required this.status,
    required this.selected,
    required this.controller,
    required this.editStatus,
  });

  @override
  Widget build(BuildContext context) {
    final result = editStatus
        ? editStatus && selected != null
        : status && selected != null;

    return FloatingActionButton(
      child: Icon(result ? Icons.add : Icons.close),
      onPressed: () {
        if (result) {
          editStatus
              ? Provider.of<ChatProvider>(context, listen: false)
                  .modifyChat(icon: selected!, title: controller.text)
              : Provider.of<ChatProvider>(context, listen: false)
                  .addNewChat(icon: selected!, title: controller.text);
        } else {
          Provider.of<ChatProvider>(context, listen: false).endModify();
        }
        Navigator.of(context).pop();
      },
    );
  }
}
