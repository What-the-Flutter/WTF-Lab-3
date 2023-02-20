import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../../../core/util/resources/dimensions.dart';
import '../../../../../core/domain/models/local/chat/chat_model.dart';
import '../../../../../core/util/typedefs.dart';
import '../../../../cubit/chat/message_control/message_control_cubit.dart';
import '../../../../cubit/chat/message_resend/message_resend_cubit.dart';
import 'available_chat_card.dart';
import 'resend_text.dart';
import 'resend_button.dart';
import 'chat_selection_checkbox.dart';
import 'resend_bottom_sheet.dart';

class AvailableChats extends StatelessWidget {
  final FId currentChatId;
  final MessageControlState state;

  const AvailableChats({
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
            const ResendText(),
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
                          : AvailableChatCard(state: state, chat: chat),
                      const Spacer(),
                      currentChatId == chat.id
                          ? Container(height: Insets.none)
                          : ChatSelectionCheckbox(state: state, chat: chat),
                    ],
                  );
                },
              ),
            ),
            ResendButton(
              currentChatId: currentChatId,
              controlState: this.state,
            ),
          ],
        );
      },
    );
  }
}
