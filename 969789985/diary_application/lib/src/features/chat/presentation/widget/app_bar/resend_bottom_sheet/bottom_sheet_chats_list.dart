import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../../../../common/values/dimensions.dart';
import '../../../../../chat_list/domain/chat_model.dart';
import '../../../cubit/message_control/message_control_cubit.dart';
import '../../../cubit/message_resend/message_resend_cubit.dart';
import 'bottom_sheet_chats_list_card.dart';
import 'bottom_sheet_information.dart';
import 'bottom_sheet_send_button.dart';
import 'chat_selection_checkbox.dart';
import 'resend_bottom_sheet.dart';

class BottomSheetChatsList extends StatelessWidget {
  final int currentChatId;
  final MessageControlState state;

  const BottomSheetChatsList({
    super.key,
    required this.currentChatId,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageResendCubit, MessageResendState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BottomSheetInformation(),
            Expanded(
              child: GroupedListView<ChatModel, DateTime>(
                elements: ResendBottomSheet.of(context).state.chats.toList(),
                groupBy: (chat) => DateTime(
                  chat.creationDate.year,
                  chat.creationDate.month,
                  chat.creationDate.day,
                ),
                groupHeaderBuilder: (chat) => Container(
                  width: Insets.none,
                  height: Insets.none,
                ),
                itemBuilder: (_, chat) {
                  return Row(
                    children: [
                      currentChatId == chat.id
                          ? Container(height: Insets.none)
                          : BottomSheetChatsListCard(state: state, chat: chat),
                      const Spacer(),
                      currentChatId == chat.id
                          ? Container(height: Insets.none)
                          : ChatSelectionCheckbox(state: state, chat: chat),
                    ],
                  );
                },
              ),
            ),
            BottomSheetSendButton(
              currentChatId: currentChatId,
              controlState: this.state,
            ),
          ],
        );
      },
    );
  }
}
