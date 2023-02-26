import 'package:flutter/material.dart';

import '../../theme/theme_scope.dart';
import '../../../../core/util/resources/dimensions.dart';
import '../../../../core/util/extension/datetime_extension.dart';
import '../../../../core/domain/models/local/message/message_model.dart';
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
                              Text(
                                message.messageText,
                                style: TextStyle(
                                  fontSize: ThemeScope.of(context)
                                      .state
                                      .messageFontSize,
                                ),
                              ),
                              const SizedBox(width: Insets.small),
                              Text(
                                message.sendDate.timeJmFormat(),
                                style:
                                    const TextStyle(fontSize: FontsSize.small),
                              )
                            ],
                          )
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            message.messageText,
                            style: TextStyle(
                              fontSize: ThemeScope.of(context)
                                  .state
                                  .messageFontSize,
                            ),
                          ),
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
                      Text(
                        '${message.messageText}  ',
                        style: TextStyle(
                          fontSize: ThemeScope.of(context)
                              .state
                              .messageFontSize,
                        ),
                      ),
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
