import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../basic/models/chat_model.dart';
import '../../basic/providers/chat_list_provider.dart';
import '../../ui/utils/dimensions.dart';
import 'chat_card.dart';

class ArchiveListView extends StatefulWidget {
  final ChatListProvider provider;
  final List<ChatModel> archiveList;

  const ArchiveListView({
    super.key,
    required this.provider,
    required this.archiveList,
  });

  @override
  State<ArchiveListView> createState() => _ArchiveListViewState();
}

class _ArchiveListViewState extends State<ArchiveListView> {
  @override
  Widget build(BuildContext context) => Center(
        child: GroupedListView<ChatModel, DateTime>(
          elements: widget.provider.repository.chats
              .where((el) => el.isArchive)
              .toList(),
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
            return _slidableItems(chat);
          },
        ),
      );

  Widget _slidableItems(ChatModel chat) {
    return Slidable(
      closeOnScroll: true,
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            borderRadius:
            BorderRadius.circular(Radii.applicationConstant),
            onPressed: (context) {
              widget.provider.removeChat(chat);
              setState(() {});
            },
            icon: Icons.delete_outline,
            label: 'Delete',
            foregroundColor: Colors.red,
          ),
          SlidableAction(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            borderRadius:
            BorderRadius.circular(Radii.applicationConstant),
            onPressed: (context) {
              widget.provider.update(
                chat.copyWith(isArchive: false),
              );
              setState(() {});
            },
            icon: Icons.archive,
            label: 'Unarchive',
          ),
        ],
      ),
      child: ChatCard(
        provider: widget.provider,
        chat: chat,
        isActionsVisible: true,
      ),
    );
  }
  
}
