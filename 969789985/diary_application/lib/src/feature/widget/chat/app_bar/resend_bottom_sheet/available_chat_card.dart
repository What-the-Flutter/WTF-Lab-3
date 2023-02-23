import 'package:flutter/material.dart';

import '../../../../../core/util/resources/dimensions.dart';
import '../../../../../core/util/resources/icons.dart';
import '../../../../../core/domain/models/local/chat/chat_model.dart';
import '../../../../cubit/chat/message_resend/message_resend_cubit.dart';
import 'resend_bottom_sheet.dart';

class AvailableChatCard extends StatelessWidget {
  final MessageResendState state;
  final ChatModel chat;

  const AvailableChatCard({
    super.key,
    required this.state,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Insets.appConstantLarge,
        right: Insets.appConstantLarge,
        bottom: Insets.medium,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Material(
          borderRadius: BorderRadius.circular(Insets.appConstantExtraLarge),
          color: Theme.of(context).cardTheme.color,
          child: InkWell(
            borderRadius: BorderRadius.circular(Insets.appConstantExtraLarge),
            onTap: () =>
                ResendBottomSheet.of(context).updateChatSelection(int.tryParse(chat.id)!),
            child: Padding(
              padding: const EdgeInsets.only(
                top: Insets.appConstantLarge,
                bottom: Insets.appConstantLarge,
                left: Insets.appConstantMedium,
                right: Insets.appConstantMedium,
              ),
              child: Row(
                children: [
                  Icon(
                    IconData(
                      chat.chatIcon,
                      fontFamily: AppIcons.material,
                    ),
                    size: IconsSize.large,
                  ),
                  const SizedBox(width: Insets.medium),
                  Text(
                    chat.chatTitle,
                    style: const TextStyle(
                      fontSize: FontsSize.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
