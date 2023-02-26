import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../../../core/util/resources/dimensions.dart';
import '../../../../../core/util/resources/icons.dart';
import '../../../../../core/domain/models/local/chat/chat_model.dart';
import '../../../../cubit/chatter/chatter_cubit.dart';
import '../../scope/chatter_scope.dart';
import 'archive_list_slidable_items.dart';

class ChatterArchiveList extends StatelessWidget {
  const ChatterArchiveList({super.key});

  @override
  Widget build(BuildContext context) {
    return ChatterScope(
      child: BlocBuilder<ChatterCubit, ChatterState>(
        builder: (context, state) {
          return state.chats.where((el) => el.isArchive).isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.archive_outlined,
                        size: IconsSize.large,
                      ),
                      Text(
                        'Archive is empty',
                        style: TextStyle(fontSize: FontsSize.large),
                      ),
                    ],
                  ),
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
