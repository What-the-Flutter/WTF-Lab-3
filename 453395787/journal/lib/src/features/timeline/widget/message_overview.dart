import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/models/ui/message.dart';
import '../../../common/utils/insets.dart';
import '../../chat/chat.dart';
import '../cubit/message_overview_cubit.dart';

class MessageOverview extends StatelessWidget {
  const MessageOverview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WithBackgroundImage(
      child: BlocBuilder<MessageOverviewCubit, MessageOverviewState>(
          builder: (context, state) {
        return ListView.builder(
          reverse: true,
          shrinkWrap: true,
          padding: const EdgeInsets.only(
            bottom: 70,
          ),
          itemCount: state.messages.length,
          itemBuilder: (context, index) {
            // TODO get messages with dates from state
            final item = state.messages[index];

            /*
              if (item is DateTime) {
                return TimeItem(
                  dateTime: item,
                );
              }
               */

            return MessageItem(
              message: item as Message,
            );
          },
        );
      }),
    );
  }
}
