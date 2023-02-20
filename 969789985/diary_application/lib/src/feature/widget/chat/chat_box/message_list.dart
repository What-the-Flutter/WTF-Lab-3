import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../../core/domain/models/local/message/message_model.dart';
import '../../../../core/util/extension/datetime_extension.dart';
import '../../../../core/util/resources/dimensions.dart';
import '../../../cubit/chat/message_control/message_control_cubit.dart';
import 'message_list_item.dart';

class MessageList extends StatelessWidget {
  final IList<MessageModel> messages;

  const MessageList({
    super.key,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageControlCubit, MessageControlState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: AnimationLimiter(
                child: GroupedListView<MessageModel, DateTime>(
                  padding: const EdgeInsets.all(Insets.medium),
                  reverse: true,
                  order: GroupedListOrder.DESC,
                  useStickyGroupSeparators: true,
                  floatingHeader: true,
                  elements: state.isFavoriteMode
                      ? messages.where((mes) => mes.isFavorite).toList()
                      : messages.toList(),
                  groupBy: (message) => DateTime(
                    message.sendDate.year,
                    message.sendDate.month,
                    message.sendDate.day,
                  ),
                  groupHeaderBuilder: (message) => SizedBox(
                    height: 40.0,
                    child: Center(
                      child: Card(
                        elevation: 0,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.all(Insets.medium),
                          child: Text(
                            message.sendDate.dateYMMMDFormat(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  indexedItemBuilder: (context, message, index) =>
                      MessageListItem(message: message, index: index),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
