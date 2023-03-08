import 'package:flutter/material.dart';

import '../../../../../core/domain/models/local/chat/chat_model.dart';
import '../../../../../core/util/resources/dimensions.dart';
import '../../../theme/theme_scope.dart';
import '../../scope/timeline_scope.dart';
import 'filter_chatter_card_content.dart';

class FilterChatterCard extends StatelessWidget {
  final ChatModel chat;

  FilterChatterCard({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Insets.small,
        right: Insets.small,
        bottom: Insets.small,
      ),
      child: Card(
        color: Color(ThemeScope.of(context).state.primaryItemColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            ThemeScope.of(context).state.messageBorderRadius,
          ),
        ),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              ThemeScope.of(context).state.messageBorderRadius,
            ),
          ),
          onPressed: () {
            TimelineScope.of(context).updateSelectableChats(chat.id);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Insets.large,
            ),
            child: FilterChatterCardContent(chat: chat),
          ),
        ),
      ),
    );
  }

}
