import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../../../common/values/dimensions.dart';
import '../../../../data/repo/chat_repository.dart';
import '../../../../domain/chat_model.dart';
import '../../chatter/chatter_card/chatter_card.dart';

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
        motion: const ScrollMotion(),
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
