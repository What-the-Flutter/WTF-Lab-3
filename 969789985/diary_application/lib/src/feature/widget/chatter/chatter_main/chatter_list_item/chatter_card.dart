import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/theme_scope.dart';
import '../../../../../core/util/resources/dimensions.dart';
import '../../../../page/chat/chat_page.dart';
import '../../../../../core/domain/models/local/chat/chat_model.dart';
import '../../../../cubit/chatter/chatter_cubit.dart';
import '../../scope/chatter_scope.dart';
import '../chatter_list/chatter_list_item_bottom_sheet/chatter_card_float_bottom_sheet.dart';
import 'chatter_card_content.dart';

class ChatterCard extends StatelessWidget {
  final ChatModel chat;
  final bool isActionsVisible;

  ChatterCard({
    super.key,
    required this.chat,
    required this.isActionsVisible,
  });

  @override
  Widget build(BuildContext context) {
    return ChatterScope(
      child: BlocBuilder<ChatterCubit, ChatterState>(
        builder: (context, state) {
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
                onPressed: isActionsVisible
                    ? () => _navigateToChatPage(context)
                    : null,
                onLongPress: () => isActionsVisible
                    ? chat.isArchive
                        ? null
                        : _showChatBottomSheet(context)
                    : null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Insets.large,
                  ),
                  child: ChatterCardContent(chat: chat),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showChatBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      elevation: 0,
      builder: (context) => ChatterCardFloatBottomSheet(chat: chat),
    );
  }

  void _navigateToChatPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatPage(chat: chat),
      ),
    );
  }
}
