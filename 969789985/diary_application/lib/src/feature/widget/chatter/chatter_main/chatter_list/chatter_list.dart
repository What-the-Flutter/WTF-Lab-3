import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../../../core/domain/models/local/chat/chat_model.dart';
import '../../../../../core/util/resources/dimensions.dart';
import '../../../../cubit/chatter/chatter_cubit.dart';
import '../../chatter_archive/chatter_archive_list_item/archive_card.dart';
import '../../scope/chatter_scope.dart';
import 'chatter_slidable_items.dart';

class HomeListView extends StatelessWidget {
  HomeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChatterScope(
      child: BlocBuilder<ChatterCubit, ChatterState>(
        builder: (context, state) {
          return Center(
            child: GroupedListView<ChatModel, DateTime>(
              elements: state.chats.toList(),
              groupBy: (chat) => DateTime(
                chat.creationDate.year,
              ),
              groupHeaderBuilder: (context) => ArchiveCard(),
              indexedItemBuilder: (context, chat, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: ChatterSlidableItems(chat: chat),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
