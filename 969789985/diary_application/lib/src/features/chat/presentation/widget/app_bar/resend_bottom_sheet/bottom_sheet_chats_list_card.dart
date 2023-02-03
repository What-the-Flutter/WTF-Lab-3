import 'package:flutter/material.dart';

import '../../../../../../common/values/dimensions.dart';
import '../../../../../../common/values/icons.dart';
import '../../../../../chat_list/domain/chat_model.dart';
import '../../../cubit/message_resend/message_resend_cubit.dart';
import 'resend_bottom_sheet.dart';

class BottomSheetChatsListCard extends StatelessWidget {
  final MessageResendState state;
  final ChatModel chat;

  const BottomSheetChatsListCard({
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
                ResendBottomSheet.of(context).updateChatSelection(chat.id),
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
