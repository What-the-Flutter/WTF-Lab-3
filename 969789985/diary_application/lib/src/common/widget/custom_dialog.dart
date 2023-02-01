import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String dialogTitle;
  final Widget dialogDescription;
  final Function() completeAction;
  final bool cancelVisible;

  CustomDialog({
    super.key,
    required this.dialogTitle,
    required this.dialogDescription,
    required this.completeAction,
    required this.cancelVisible,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(dialogTitle),
      content: dialogDescription,
      actions: [
        Visibility(
            visible: cancelVisible,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            )),
        TextButton(
          onPressed: () {
            completeAction.call();
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
