import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:my_final_project/entities/provider_chat.dart';
import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/screens/travel_screen.dart';
import 'package:my_final_project/ui/widgets/home_screen/home_screen_modal.dart';
import 'package:my_final_project/ui/widgets/hovers/on_hovers_button.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

class HomeScreenChatElement extends StatelessWidget {
  const HomeScreenChatElement({super.key});

  @override
  Widget build(BuildContext context) {
    final listNew = Provider.of<ProviderChat>(context).takeListChat;
    final theme = Theme.of(context).brightness == Brightness.light;

    return ListView.builder(
      itemCount: listNew.length,
      itemBuilder: (context, index) {
        final itemChat = listNew[index];
        return GestureDetector(
          onLongPress: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return HomeScreenModal(
                  index: index,
                  icon: itemChat.icon,
                  title: itemChat.title,
                  dateCreate: itemChat.dateCreate,
                  dateLastEvent: itemChat.listEvent.isEmpty
                      ? S.of(context).no_event
                      : DateFormat.yMd()
                          .add_jm()
                          .format(itemChat.listEvent[0].messageTime),
                );
              },
            );
          },
          child: Column(
            children: [
              HoverButton(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TravelScreen(
                            listEvent: itemChat.listEvent,
                            title: itemChat.title),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: theme
                          ? AppColors.colorLightBlue
                          : AppColors.colorLightGrey,
                      foregroundColor: Colors.white,
                      radius: 40,
                      child: itemChat.icon,
                    ),
                    title: Row(
                      children: [
                        Text(
                          itemChat.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        itemChat.isPin
                            ? Icon(
                                Icons.attach_file,
                                color: theme
                                    ? Colors.black
                                    : AppColors.colorLightYellow,
                              )
                            : const SizedBox(),
                      ],
                    ),
                    subtitle: Text(
                      itemChat.listEvent.isEmpty
                          ? S.of(context).no_event
                          : itemChat.listEvent[0].messageContent,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: itemChat.listEvent.isEmpty
                        ? const SizedBox()
                        : Text(
                            DateFormat('hh:mm a')
                                .format(itemChat.listEvent[0].messageTime),
                          ),
                  ),
                ),
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }
}
