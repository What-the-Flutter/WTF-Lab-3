import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../../../../common/values/dimensions.dart';
import '../../../../../../common/values/icons.dart';
import '../../../../../chat_list/data/repo/chat_repository.dart';
import '../../../../../chat_list/domain/chat_model.dart';
import '../../../cubit/message_control/message_control_cubit.dart';
import '../../../cubit/message_resend/message_resend_cubit.dart';
import 'bottom_sheet_chats_list.dart';

class ResendBottomSheet extends StatelessWidget {
  final MessageControlState state;
  final int currentChatId;

  const ResendBottomSheet({
    super.key,
    required this.currentChatId,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageResendCubit(
        repository: RepositoryProvider.of<ChatRepository>(context),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Insets.appConstantMedium),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Radii.appConstant),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child:
              BottomSheetChatsList(state: state, currentChatId: currentChatId),
        ),
      ),
    );
  }

  static MessageResendCubit of(BuildContext context) =>
      context.read<MessageResendCubit>();
}
