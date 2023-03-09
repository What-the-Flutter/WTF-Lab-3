import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../../../core/domain/models/local/chat/chat_model.dart';
import '../../../../../core/util/resources/dimensions.dart';
import '../../../../cubit/timeline/timeline_cubit.dart';
import '../../scope/timeline_scope.dart';
import 'filter_chatter_card.dart';

class FilterChatterList extends StatelessWidget {
  FilterChatterList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineCubit, TimelineState>(
      builder: (context, state) {
        return Center(
          child: GroupedListView<ChatModel, DateTime>(
            elements: state.chats.toList(),
            groupBy: (chat) => DateTime(
              chat.creationDate.year,
            ),
            groupHeaderBuilder: (context) => Container(
              width: Insets.none,
              height: Insets.none,
            ),
            indexedItemBuilder: (context, chat, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FilterChatterCard(chat: chat),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
