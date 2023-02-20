import 'package:flutter/material.dart';

import '../../../../../../core/util/resources/dimensions.dart';
import '../../../../../../core/util/resources/icons.dart';
import '../../../../../../core/util/extension/datetime_extension.dart';
import '../../../../../../core/domain/models/local/chat/chat_model.dart';

class ChatterInformationDialog extends StatelessWidget {
  final ChatModel chat;

  const ChatterInformationDialog({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    final creationDate = chat.creationDate.dateYMMMDFormat();
    final creationTime = chat.creationDate.timeJmFormat();
    String? latestMessageDate;
    String? latestMessageTime;

    if (chat.messages.isNotEmpty) {
      latestMessageDate = chat.messages.last.sendDate.dateYMMMDFormat();
      latestMessageTime = chat.messages.last.sendDate.timeJmFormat();
    }

    return Container(
      height: chat.messages.isEmpty ? 158.0 : 184.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: Insets.none),
            child: Row(
              children: [
                Icon(
                  IconData(chat.chatIcon, fontFamily: AppIcons.material),
                  size: IconsSize.extraLarge,
                ),
                const SizedBox(width: Insets.medium),
                Text(
                  chat.chatTitle,
                  style: const TextStyle(fontSize: FontsSize.extraLarge),
                ),
              ],
            ),
          ),
          const SizedBox(height: Insets.large),
          Text(
            'Created at\n$creationDate $creationTime',
            style: const TextStyle(fontSize: FontsSize.normal),
          ),
          const SizedBox(height: Insets.large),
          Text(
            latestMessageDate != null
                ? 'Last message at\n$latestMessageDate $latestMessageTime'
                : 'Chat is currently empty',
            style: const TextStyle(fontSize: FontsSize.normal),
          ),
        ],
      ),
    );
  }
}
