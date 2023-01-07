import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/utils/insets.dart';
import '../../messages_manage/widget/message_list/items/message_item.dart';
import '../cubit/chat_search_cubit.dart';
import '../cubit/chat_search_state.dart';

class MessageItems extends StatelessWidget {
  const MessageItems({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatSearchCubit, ChatSearchState>(
      builder: (context, state) {
        return state.map(
          initial: (initial) => const Center(
            child: Text('Initial state'),
          ),
          empty: (empty) => const Center(
            child: Text('Empty page'),
          ),
          withResults: (withResults) {
            final items = withResults.messages.reversed.toList();

            return ListView.builder(
              reverse: true,
              shrinkWrap: true,
              padding: const EdgeInsets.only(
                bottom: Insets.small,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return MessageItem(
                  message: items[index],
                );
              },
            );
          },
        );
      },
    );
  }
}
