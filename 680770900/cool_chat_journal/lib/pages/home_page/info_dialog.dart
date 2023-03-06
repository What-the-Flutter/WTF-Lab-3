import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/chat.dart';
import '../../themes/custom_theme.dart';
import '../add_chat_page/icon_view.dart';

class InfoDialog extends StatelessWidget {
  final Chat chat;

  const InfoDialog({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.yMd().add_jm();

    return Center(
      child: Container(
        margin: const EdgeInsets.all(40.0),
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 20.0,
        ),
        color: CustomTheme.of(context).primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconView(
                  icon: chat.icon,
                  size: 60.0,
                ),
                Text(
                  chat.name,
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Text(
              'Created',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(formatter.format(chat.createdTime)),
            if (chat.events.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Latest Event',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(formatter.format(chat.events.last.changeTime)),
                ],
              ),
            Container(
              margin: const EdgeInsets.only(top: 40.0),
              decoration: BoxDecoration(
                color: CustomTheme.of(context).backgroundColor,
              ),
              child: TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
