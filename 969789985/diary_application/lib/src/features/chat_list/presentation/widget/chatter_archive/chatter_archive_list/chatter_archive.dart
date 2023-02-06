import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../../../../common/values/dimensions.dart';
import '../../../../domain/chat_model.dart';
import '../../../cubit/chatter_cubit.dart';
import '../../scopes/chatter_scope.dart';
import 'archive_list_slidable_items.dart';

class ArchiveListView extends StatelessWidget {
  const ArchiveListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChatterScope(
      child: BlocBuilder<ChatterCubit, ChatterState>(
        builder: (context, state) {
          return state.chats.where((el) => el.isArchive).isEmpty
              ? const Center(
                  child: Text('Archive is empty'),
                )
              : Center(
                  child: GroupedListView<ChatModel, DateTime>(
                    elements: state.chats.where((el) => el.isArchive).toList(),
                    groupBy: (chat) => DateTime(
                      chat.creationDate.year,
                      chat.creationDate.month,
                      chat.creationDate.day,
                    ),
                    groupHeaderBuilder: (chat) => Container(
                      width: Insets.none,
                      height: Insets.none,
                    ),
                    itemBuilder: (_, chat) {
                      return ArchiveListSlidableItems(chat: chat);
                    },
                  ),
                );
        },
      ),
    );
  }
  
}
