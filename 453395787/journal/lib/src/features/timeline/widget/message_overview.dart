import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/features/settings/settings.dart';
import '../../../common/models/ui/message.dart';
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
          final IList<Object> items;
          if (context.read<SettingsCubit>().state.isCenterDateBubbleShown) {
            items = state.messagesWithDates.reversed.toIList();
          } else {
            items = state.messages.reversed.toIList();
          }

          return ListView.builder(
            reverse: true,
            shrinkWrap: true,
            padding: const EdgeInsets.only(
              bottom: 70,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];

              if (item is DateTime) {
                return TimeItem(
                  dateTime: item,
                );
              }

              return MessageItem(
                message: item as Message,
                isChatNameShown: true,
              );
            },
          );
        },
      ),
    );
  }
}
