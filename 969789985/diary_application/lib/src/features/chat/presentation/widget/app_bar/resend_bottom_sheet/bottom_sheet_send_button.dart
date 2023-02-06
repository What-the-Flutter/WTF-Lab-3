import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/values/dimensions.dart';
import '../../../cubit/message_control/message_control_cubit.dart';
import '../../../cubit/message_resend/message_resend_cubit.dart';
import 'resend_bottom_sheet.dart';

class BottomSheetSendButton extends StatelessWidget {
  final int currentChatId;
  final MessageControlState controlState;

  const BottomSheetSendButton({
    super.key,
    required this.currentChatId,
    required this.controlState,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageResendCubit, MessageResendState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(
            top: Insets.appConstantMedium,
            bottom: Insets.appConstantMedium,
            left: Insets.appConstantExtraLarge,
            right: Insets.appConstantMedium,
          ),
          child: Row(
            children: [
              const Spacer(),
              TextButton.icon(
                icon: const Icon(Icons.send),
                label: const Text('Send'),
                onPressed: () {
                  final selectedMessages = controlState.messages
                      .where((el) => controlState.selected[el.id] == true)
                      .toIList();

                  ResendBottomSheet.of(context).resendMessages(
                        currentChatId,
                        selectedMessages,
                      );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
