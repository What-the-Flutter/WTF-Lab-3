import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../../core/domain/models/local/message/message_model.dart';
import '../../../../core/util/extension/datetime_extension.dart';
import '../../../../core/util/resources/dimensions.dart';
import '../../theme/theme_scope.dart';
import 'timeline_message_list_item.dart';

class TimelineMessageList extends StatelessWidget {
  final IList<MessageModel> messages;
  final bool isFilter;

  const TimelineMessageList({
    super.key,
    required this.messages,
    required this.isFilter,
  });

  @override
  Widget build(BuildContext context) {
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
              elements: messages.toList(),
              groupBy: (message) => DateTime(
                message.sendDate.year,
                message.sendDate.month,
                message.sendDate.day,
              ),
              groupHeaderBuilder: (message) =>
                  ThemeScope.of(context).state.dateBubbleVisible
                      ? SizedBox(
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
                        )
                      : const SizedBox(height: Insets.none),
              indexedItemBuilder: (context, message, index) {
                if (isFilter) {
                  return TimelineMessageListItem(
                    message: message,
                    index: index,
                  );
                } else {
                  if (index == 0) {
                    return Column(
                      children: [
                        TimelineMessageListItem(
                          message: message,
                          index: index,
                        ),
                        Container(
                          height: Insets.superDuperUltraMegaExtraLarge,
                        ),
                      ],
                    );
                  } else {
                    return TimelineMessageListItem(
                      message: message,
                      index: index,
                    );
                  }
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
