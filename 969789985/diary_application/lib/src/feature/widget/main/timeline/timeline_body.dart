import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/resources/dimensions.dart';
import '../../../cubit/main/start_screen_cubit.dart';
import '../../../cubit/timeline/timeline_cubit.dart';
import '../../chat/chat_box/empty_message.dart';
import '../../timeline/message/timeline_message_list.dart';
import '../scope/main_scope.dart';

class TimelineBody extends StatelessWidget {
  const TimelineBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StartScreenCubit, StartScreenState>(
      builder: (context, startState) {
        return BlocBuilder<TimelineCubit, TimelineState>(
          builder: (context, state) {
            return state.messages.isEmpty
                ? const EmptyMessage(message: 'Nothing messages')
                : Padding(
                    padding: const EdgeInsets.only(
                      bottom: Insets.none,
                    ),
                    child: NotificationListener<UserScrollNotification>(
                      onNotification: (notification) {
                        if (notification.direction == ScrollDirection.forward) {
                          if (!startState.gNavVisible) {
                            StartScreenScope.of(context).gNavVisible = true;
                          }
                        } else if (notification.direction ==
                            ScrollDirection.reverse) {
                          if (startState.gNavVisible) {
                            StartScreenScope.of(context).gNavVisible = false;
                          }
                        }

                        return true;
                      },
                      child: TimelineMessageList(
                        messages: StartScreenScope.of(context)
                                .state
                                .hashtag
                                .isEmpty
                            ? state.messages
                            : state.messages
                                .where(
                                  (message) => message.messageText.contains(
                                    StartScreenScope.of(context).state.hashtag,
                                  ),
                                )
                                .toIList(),
                      ),
                    ),
                  );
          },
        );
      },
    );
  }
}
