import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../utils/insets.dart';
import '../utils/locale.dart' as locale;

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
          child: Text(
            locale.Actions.cancel.i18n(),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(
            locale.Actions.ok.i18n(),
          ),
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
