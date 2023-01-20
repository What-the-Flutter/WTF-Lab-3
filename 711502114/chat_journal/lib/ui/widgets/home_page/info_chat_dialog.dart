import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/chat.dart';
import '../../../theme/colors.dart';
import '../../../utils/utils.dart';

class InfoChatDialog extends StatelessWidget {
  final Chat chat;

  const InfoChatDialog({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return AlertDialog(
      backgroundColor: dialogBackgroundColor,
      title: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: circleMessageColor,
              shape: BoxShape.circle,
            ),
            child: Icon(chat.iconData),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              chat.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
        ],
      ),
      content: Container(
        constraints: const BoxConstraints(maxHeight: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              local?.created ?? '',
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              _useDateTimeFormat(context, chat.creationTime),
              style: TextStyle(color: secondaryMessageTextColor),
            ),
            const SizedBox(height: 20),
            Text(
              local?.latestEvent ?? '',
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              _useDateTimeFormat(context, _knowLastEvent()),
              style: TextStyle(color: secondaryMessageTextColor),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Align(
          alignment: const Alignment(0.9, 1),
          child: Container(
            width: 100,
            child: OutlinedButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                local?.ok ?? '',
              ),
              onPressed: Navigator.of(context).pop,
            ),
          ),
        ),
      ],
    );
  }

  DateTime _knowLastEvent() {
    if (chat.events.isEmpty) return chat.creationTime;

    return chat.events.last.dateTime;
  }

  String _useDateTimeFormat(BuildContext context, DateTime dateTime) {
    final data = '${formatDate(context, dateTime)}';
    final time = '${formatTime(dateTime, includeSec: false)}';
    return '$data ($time)';
  }
}
