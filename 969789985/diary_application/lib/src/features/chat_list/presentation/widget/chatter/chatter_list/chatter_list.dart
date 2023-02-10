import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../cubit/chatter_cubit.dart';
import '../../chatter_archive/chatter_archive_card/chatter_archive_card.dart';
import '../../scopes/chatter_scope.dart';
import 'chatter_slidable_items.dart';

class HomeListView extends StatelessWidget {
  HomeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChatterScope(
      child: BlocBuilder<ChatterCubit, ChatterState>(
        builder: (context, state) {
          return Center(
            child: ListView.builder(
              itemCount: state.chats.length + 1,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: index == 0
                            ? ArchiveCard(archiveList: state.chats)
                            : ChatterSlidableItems(listItemIndex: index),
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
