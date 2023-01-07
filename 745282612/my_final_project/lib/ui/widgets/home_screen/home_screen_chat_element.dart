import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/screens/event_screen.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_cubit.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_state.dart';
import 'package:my_final_project/ui/widgets/home_screen/home_screen_modal.dart';
import 'package:my_final_project/ui/widgets/hovers/on_hovers_button.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';
import 'package:my_final_project/utils/theme/theme_inherited.dart';

class HomeScreenChatElement extends StatelessWidget {
  const HomeScreenChatElement({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = CustomThemeInherited.of(context).isBrightnessLight();

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final listChat = state.listChat;
        return ListView.builder(
          itemCount: listChat.length,
          itemBuilder: (context, index) {
            final itemChat = listChat[index];
            return GestureDetector(
              onLongPress: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return HomeScreenModal(
                      chat: itemChat,
                      index: index,
                      dateLastEvent: S.of(context).no_event,
                      // dateLastEvent: itemChat.listEvent!.isEmpty
                      //     ? S.of(context).no_event
                      //     : DateFormat.yMd().add_jm().format(itemChat.listEvent![0].messageTime),
                    );
                  },
                );
              },
              child: Column(
                children: [
                  HoverButton(
                    child: TextButton(
                      onPressed: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => EventScreen(
                        //       listEvent: itemChat.listEvent!,
                        //       title: itemChat.title,
                        //     ),
                        //   ),
                        // );
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              theme ? AppColors.colorLightBlue : AppColors.colorLightGrey,
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
                                    color: theme ? Colors.black : AppColors.colorLightYellow,
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        subtitle: Text(
                          S.of(context).no_event,
                        ),
                        // subtitle: Text(
                        //   itemChat.listEvent!.isEmpty
                        //       ? S.of(context).no_event
                        //       : itemChat.listEvent![0].messageContent,
                        //   maxLines: 1,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                        // trailing: itemChat.listEvent!.isEmpty
                        //     ? const SizedBox()
                        //     : Text(
                        //         DateFormat('hh:mm a').format(itemChat.listEvent![0].messageTime),
                        //       ),
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
