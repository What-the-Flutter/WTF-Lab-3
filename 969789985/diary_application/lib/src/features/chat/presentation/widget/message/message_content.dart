import 'package:flutter/material.dart';

import '../../../../../common/values/dimensions.dart';
import '../../../../../extensions/datetime_extension.dart';
import '../../../domain/message_model.dart';
import 'tags_box.dart';

class MessageContent extends StatelessWidget {
  final MessageModel message;

  const MessageContent({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Container(
            child: message.tags.isEmpty
                ? message.messageText.length < 27
                    ? Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(message.messageText),
                              const SizedBox(width: Insets.small),
                              Text(
                                message.sendDate.timeJmFormat(),
                                style: const TextStyle(
                                  fontSize: FontsSize.small,
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(message.messageText),
                          Text(
                            message.sendDate.timeJmFormat(),
                            style: const TextStyle(
                              fontSize: FontsSize.small,
                            ),
                          ),
                        ],
                      )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('${message.messageText} '),
                      Padding(
                        padding: const EdgeInsets.only(top: Insets.small),
                        child: TagsBox(message: message),
                      ),
                      Text(
                        message.sendDate.timeJmFormat(),
                        style: const TextStyle(
                          fontSize: FontsSize.small,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
