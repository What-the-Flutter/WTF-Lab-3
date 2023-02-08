import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/themes/widget/theme_scope.dart';
import '../../../../../../common/values/dimensions.dart';
import '../../../../../chat/presentation/pages/chat_page.dart';
import '../../../../domain/chat_model.dart';
import '../../../cubit/chatter_cubit.dart';
import '../../scopes/chatter_scope.dart';
import 'card_bottom_sheet/chatter_card_float_bottom_sheet.dart';
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
                borderRadius: BorderRadius.circular(Radii.appConstant),
              ),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(Radii.appConstant),
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
                  padding: const EdgeInsets.only(
                    left: Insets.appConstantSmall,
                    right: Insets.appConstantSmall,
                    top: Insets.appConstantLarge,
                    bottom: Insets.appConstantLarge,
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
