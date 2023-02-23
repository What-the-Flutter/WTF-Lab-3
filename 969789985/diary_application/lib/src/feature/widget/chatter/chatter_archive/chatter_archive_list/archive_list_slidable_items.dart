import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../../core/util/resources/dimensions.dart';
import '../../../../../core/data/repository/chat/chat_repository.dart';
import '../../../../../core/domain/models/local/chat/chat_model.dart';
import '../../chatter_main/chatter_list_item/chatter_card.dart';

class ArchiveListSlidableItems extends StatelessWidget {
  final ChatModel chat;

  const ArchiveListSlidableItems({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      closeOnScroll: true,
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(Radii.appConstant),
            onPressed: (context) {
              RepositoryProvider.of<ChatRepository>(context).remove(chat);
            },
            icon: Icons.delete_outline,
            label: 'Delete',
            foregroundColor: Colors.red,
          ),
          SlidableAction(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(Radii.appConstant),
            onPressed: (context) {
              RepositoryProvider.of<ChatRepository>(context).update(
                chat.copyWith(isArchive: false),
              );
            },
            icon: Icons.archive,
            label: 'Unarchive',
          ),
        ],
      ),
      child: ChatterCard(
        chat: chat,
        isActionsVisible: true,
      ),
    );
  }
}
