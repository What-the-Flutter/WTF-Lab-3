import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../basic/models/chat_model.dart';
import '../../basic/providers/chat_list_provider.dart';
import '../../basic/utils/strings.dart';
import '../../ui/utils/dimensions.dart';
import '../common/custom_dialog.dart';
import 'archive_card.dart';
import 'chat_card.dart';

class HomeListView extends StatelessWidget {
  final IList<ChatModel> chatsList;
  final ChatListProvider provider;
  final TextEditingController searchTextEditingController;

  HomeListView({
    super.key,
    required this.chatsList,
    required this.provider,
    required this.searchTextEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: chatsList.length + 1,
        itemBuilder: _chat,
      ),
    );
  }

  Widget _chat(BuildContext context, int index) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Align(
              alignment: Alignment.centerRight,
              child: index == 0
                  ? ArchiveCard(
                      provider: provider,
                      archiveList:
                          chatsList.where((el) => el.isArchive).toIList(),
                    )
                  : _slidableActions(context, index)),
        ),
      ),
    );
  }

  Widget _slidableActions(BuildContext context, int index) {
    return Slidable(
      closeOnScroll: true,
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(Radii.applicationConstant),
            onPressed: (context) => showDialog(
              context: context,
              builder: (context) => CustomDialog(
                dialogTitle: Strings.deleteChatTitle,
                dialogDescription: const Text(Strings.deleteChatDescription),
                completeAction: () {
                  provider.removeChat(chatsList[index - 1]);
                  Navigator.pop(context);
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
            borderRadius: BorderRadius.circular(Radii.applicationConstant),
            onPressed: (context) {
              provider.update(
                chatsList[index - 1].copyWith(isArchive: true),
              );
              Fluttertoast.showToast(
                msg: 'Chat ${chatsList[index - 1].chatTitle} archived',
              );
            },
            icon: Icons.archive,
            label: 'Archive',
          ),
        ],
      ),
      child: _chatList(index),
    );
  }

  Widget _chatList(int index) {
    if (chatsList[index - 1].isArchive) {
      return Container(
        width: Insets.none,
        height: Insets.none,
      );
    } else {
      return ChatCard(
        provider: provider,
        chat: chatsList[index - 1],
        isActionsVisible: true,
      );
    }
  }
}
