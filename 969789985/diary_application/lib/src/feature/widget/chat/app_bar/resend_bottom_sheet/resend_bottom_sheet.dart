import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../../../core/util/resources/dimensions.dart';
import '../../../../../core/util/resources/icons.dart';
import '../../../../../core/data/repository/chat/chat_repository.dart';
import '../../../../../core/domain/models/local/chat/chat_model.dart';
import '../../../../../core/util/typedefs.dart';
import '../../../../cubit/chat/message_control/message_control_cubit.dart';
import '../../../../cubit/chat/message_resend/message_resend_cubit.dart';
import 'available_chats.dart';

class ResendBottomSheet extends StatelessWidget {
  final MessageControlState state;
  final FId currentChatId;

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
              AvailableChats(state: state, currentChatId: currentChatId),
        ),
      ),
    );
  }

  static MessageResendCubit of(BuildContext context) =>
      context.read<MessageResendCubit>();
}
