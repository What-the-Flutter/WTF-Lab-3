import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:my_final_project/entities/chat.dart';
import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/screens/event_screen.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_cubit.dart';
import 'package:my_final_project/ui/widgets/home_screen/home_screen_modal.dart';
import 'package:my_final_project/ui/widgets/hovers/on_hovers_button.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';
import 'package:my_final_project/utils/theme/theme_cubit.dart';

class HomeScreenChatElement extends StatefulWidget {
  const HomeScreenChatElement({super.key});

  @override
  State<HomeScreenChatElement> createState() => _HomeScreenChatElementState();
}

class _HomeScreenChatElementState extends State<HomeScreenChatElement> {
  final _user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = context.watch<ThemeCubit>().isLight();
    final stateEvent = context.watch<EventCubit>().state;

    return FirebaseAnimatedList(
      query: context.read<HomeCubit>().getQuery(_user),
      itemBuilder: (context, snapshot, animation, index) {
        final map = Map.from(snapshot.value as Map);
        final chat = Chat.fromJson(map);
        final listEvent =
            stateEvent.listEvent.where((element) => element.chatId == chat.id).toList();

        return GestureDetector(
          onLongPress: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return HomeScreenModal(
                  dateLastEvent: listEvent.isEmpty
                      ? S.of(context).no_event
                      : DateFormat.yMd().add_jm().format(listEvent.last.messageTime),
                  chat: chat,
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
                        builder: (context) => EventScreen(
                          chatId: chat.id,
                          title: chat.title,
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          isLight ? AppColors.colorLightBlue : AppColors.colorLightGrey,
                      foregroundColor: Colors.white,
                      radius: 40,
                      child: chat.icon,
                    ),
                    title: Row(
                      children: [
                        Text(
                          chat.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                context.watch<ThemeCubit>().state.textTheme.bodyText1!.fontSize,
                          ),
                        ),
                        chat.isPin
                            ? Icon(
                                Icons.attach_file,
                                color: isLight ? Colors.black : AppColors.colorLightYellow,
                              )
                            : const SizedBox(),
                      ],
                    ),
                    subtitle: Text(
                      listEvent.isEmpty ? S.of(context).no_event : listEvent.last.messageContent,
                      style: TextStyle(
                        fontSize: context.watch<ThemeCubit>().state.textTheme.bodyText2!.fontSize,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: listEvent.isEmpty
                        ? const SizedBox()
                        : Text(
                            DateFormat('hh:mm a').format(listEvent.last.messageTime),
                            style: TextStyle(
                              fontSize:
                                  context.watch<ThemeCubit>().state.textTheme.bodyText2!.fontSize,
                            ),
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
