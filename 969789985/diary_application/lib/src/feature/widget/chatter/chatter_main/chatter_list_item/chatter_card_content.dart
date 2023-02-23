import 'package:flutter/material.dart';

import '../../../../../core/domain/models/local/chat/chat_model.dart';
import '../../../../../core/util/extension/datetime_extension.dart';
import '../../../../../core/util/resources/dimensions.dart';
import '../../../../../core/util/resources/icons.dart';
import '../../../theme/theme_scope.dart';
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
              size: IconsSize.superExtraLarge,
              color: Theme.of(context).indicatorColor,
            ),
            const SizedBox(width: Insets.appConstantMedium),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat.chatTitle,
                  style: const TextStyle(fontSize: FontsSize.large),
                ),
                const SizedBox(height: Insets.small),
                Text(
                  chat.messages.isEmpty
                      ? 'Start this chat...'
                      : chat.messages.last.messageText,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Theme.of(context).hintColor,
                  ),
                  overflow: TextOverflow.ellipsis,
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
