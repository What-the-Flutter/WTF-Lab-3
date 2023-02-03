import 'package:flutter/material.dart';

import '../../../../../../common/values/dimensions.dart';
import '../../../../../../common/values/icons.dart';
import '../../../../../../extensions/datetime_extension.dart';
import '../../../../domain/chat_model.dart';
import 'animated_pin_icon.dart';

class ChatterCardContent extends StatelessWidget {
  final ChatModel chat;

  const ChatterCardContent({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              IconData(chat.chatIcon, fontFamily: AppIcons.material),
              size: IconsSize.extraLarge,
            ),
            const SizedBox(width: Insets.appConstantMedium),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat.chatTitle,
                  style: const TextStyle(fontSize: FontsSize.normal),
                ),
                SizedBox(
                  width: 150.0,
                  child: Text(
                    chat.lastMessage == null
                        ? 'Start this chat...'
                        : chat.lastMessage!.messageText,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Theme.of(context).hintColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chat.creationDate.timeJmFormat(),
                  style: const TextStyle(fontSize: FontsSize.standard),
                ),
                AnimatedPinIcon(chat: chat),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
