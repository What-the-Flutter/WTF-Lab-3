import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/screens/event_screen.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_cubit.dart';
import 'package:my_final_project/ui/widgets/home_screen/cubit/home_state.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = context.read<ThemeCubit>().state.brightness == Brightness.light;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final listChat = state.listChat;
        final stateEvent = context.read<EventCubit>().state;
        return ListView.builder(
          itemCount: listChat.length,
          itemBuilder: (context, index) {
            final itemChat = listChat[index];
            final listEvent =
                stateEvent.listEvent.where((element) => element.chatId == itemChat.id).toList();
            return GestureDetector(
              onLongPress: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return HomeScreenModal(
                      chat: itemChat,
                      index: index,
                      dateLastEvent: listEvent.isEmpty
                          ? S.of(context).no_event
                          : DateFormat.yMd().add_jm().format(listEvent.last.messageTime),
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
                              chatId: itemChat.id,
                              title: itemChat.title,
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
                                    color: isLight ? Colors.black : AppColors.colorLightYellow,
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        subtitle: Text(
                          listEvent.isEmpty
                              ? S.of(context).no_event
                              : listEvent.last.messageContent,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: listEvent.isEmpty
                            ? const SizedBox()
                            : Text(
                                DateFormat('hh:mm a').format(listEvent.last.messageTime),
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
      },
    );
  }
}
