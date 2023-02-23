import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../core/domain/models/local/chat/chat_model.dart';
import '../../../../../core/util/resources/dimensions.dart';
import '../../../general/custom_dialog.dart';
import '../../../../../core/util/resources/strings.dart';
import '../../../../../core/data/repository/chat/chat_repository.dart';
import 'chatter_list_item.dart';

class ChatterSlidableItems extends StatelessWidget {
  final ChatModel chat;

  const ChatterSlidableItems({
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
            onPressed: (context) => showDialog(
              context: context,
              builder: (context) => CustomDialog(
                dialogTitle: Strings.deleteChatTitle,
                dialogDescription: const Text(Strings.deleteChatDescription),
                completeAction: () {
                  RepositoryProvider.of<ChatRepository>(context).remove(chat);
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
              RepositoryProvider.of<ChatRepository>(context).update(chat);
              Fluttertoast.showToast(
                msg: 'Chat was archived',
              );
            },
            icon: Icons.archive,
            label: 'Archive',
          ),
        ],
      ),
      child: ChatterListItem(chat: chat),
    );
  }
}
