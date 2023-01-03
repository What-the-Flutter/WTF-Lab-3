import 'package:flutter/material.dart';

import 'insets.dart';

Future<bool?> showConfirmationDialog({
  required String title,
  required String content,
  required BuildContext context,
}) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Ok'),
        ),
      ],
      titlePadding: const EdgeInsets.only(
        left: Insets.large,
        right: Insets.large,
        top: Insets.large,
        bottom: Insets.none,
      ),
      contentPadding: const EdgeInsets.only(
        left: Insets.large,
        right: Insets.large,
        top: Insets.medium,
        bottom: Insets.none,
      ),
      actionsPadding: const EdgeInsets.only(
        left: Insets.large,
        right: Insets.large,
        top: Insets.none,
        bottom: Insets.medium,
      ),
    ),
  );
}
