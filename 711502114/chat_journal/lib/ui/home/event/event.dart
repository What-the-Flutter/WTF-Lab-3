import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import 'message_data.dart';

class Event extends StatelessWidget {
  final MessageData messageData;
  final Size size;

  const Event({Key? key, required this.messageData, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: size.width * .75,
              ),
              padding: const EdgeInsets.all(12.0),
              decoration: const BoxDecoration(
                color: circleMessageColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Text(
                messageData.message,
                style: const TextStyle(fontSize: 16),
                overflow: TextOverflow.clip,
              ),
            ),
            const SizedBox(width: 10),
            Text(_formatTime(messageData.dateTime)),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final seconds = time.second;
    final sec = seconds < 10 ? '0$seconds' : '$seconds';
    return '${time.hour}:${time.minute}:$sec';
  }
}
