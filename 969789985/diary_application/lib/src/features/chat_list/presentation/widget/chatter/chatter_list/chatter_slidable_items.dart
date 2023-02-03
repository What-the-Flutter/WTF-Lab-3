import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../../common/values/dimensions.dart';
import '../../../../../../common/widget/custom_dialog.dart';
import '../../../../../../utils/strings.dart';
import '../../../../data/repo/chat_repository.dart';
import 'chatter_list_item.dart';

class ChatterSlidableItems extends StatelessWidget {
  final int listItemIndex;

  const ChatterSlidableItems({
    super.key,
    required this.listItemIndex,
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
            onPressed: (context) => showDialog(
              context: context,
              builder: (context) => CustomDialog(
                dialogTitle: Strings.deleteChatTitle,
                dialogDescription: const Text(Strings.deleteChatDescription),
                completeAction: () {
                  RepositoryProvider.of<ChatRepository>(context).remove(
                    RepositoryProvider.of<ChatRepository>(context)
                        .chats
                        .value[listItemIndex - 1],
                  );
                },
                cancelVisible: true,
              ),
            ),
            icon: Icons.delete_outline,
            label: 'Delete',
            foregroundColor: Colors.red,
          ),
          SlidableAction(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(Radii.appConstant),
            onPressed: (context) {
              RepositoryProvider.of<ChatRepository>(context).update(
                RepositoryProvider.of<ChatRepository>(context)
                    .chats
                    .value[listItemIndex - 1]
                    .copyWith(isArchive: true),
              );
              Fluttertoast.showToast(
                msg: 'Chat was archived',
              );
            },
            icon: Icons.archive,
            label: 'Archive',
          ),
        ],
      ),
      child: ChatterListItem(listItemIndex: listItemIndex),
    );
  }
}
