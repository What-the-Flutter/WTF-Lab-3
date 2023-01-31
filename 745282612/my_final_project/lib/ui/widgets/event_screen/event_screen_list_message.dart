import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_state.dart';
import 'package:my_final_project/ui/widgets/event_screen/event_action.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';

class EventScreenListMessage extends StatefulWidget {
  final int chatId;
  final String title;
  final List<Event> listMessageFavorite;
  final bool isSelected;
  final bool isSearch;

  const EventScreenListMessage({
    super.key,
    required this.chatId,
    required this.title,
    required this.listMessageFavorite,
    required this.isSelected,
    required this.isSearch,
  });

  @override
  State<EventScreenListMessage> createState() => _EventScreenListMessageState();
}

class _EventScreenListMessageState extends State<EventScreenListMessage> {
  final _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EventCubit>().state;
    if (state.isFavorite) {
      return listFavorite(context, widget.listMessageFavorite, state);
    } else if (state.isSearch) {
      return listFavorite(context, widget.listMessageFavorite, state);
    } else {
      return listMessage(context, state, _user, widget.chatId);
    }
  }
}

double sizePaddingBottom(BuildContext context, EventState state) {
  if (state.isSection || state.isTag) {
    return MediaQuery.of(context).size.height * 0.22;
  } else if (state.isSearch) {
    return MediaQuery.of(context).size.height * 0;
  } else {
    return MediaQuery.of(context).size.height * 0.1;
  }
}

Widget listMessage(BuildContext context, EventState state, User? _user, int chatId) {
  return StreamBuilder(
    stream: context.read<EventCubit>().getStream(_user, chatId),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        final eventList = context.read<EventCubit>().getEventList(snapshot);

        return ListView.builder(
          reverse: true,
          padding: EdgeInsets.only(bottom: sizePaddingBottom(context, state)),
          itemCount: eventList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                dateEvent(context, index, eventList),
                EventAction(
                  event: eventList[index],
                  isSelected: state.isSelected,
                )
              ],
            );
          },
        );
      }
    },
  );
}

Widget listFavorite(BuildContext context, List<Event> listMessageFavorite, EventState state) {
  final listReversed = listMessageFavorite.toList();

  return ListView.builder(
    reverse: true,
    padding: EdgeInsets.only(bottom: sizePaddingBottom(context, state)),
    itemCount: listReversed.length,
    itemBuilder: (context, index) {
      final event = listReversed[index];
      return Column(
        children: [
          dateEvent(context, index, listReversed),
          EventAction(
            event: event,
            isSelected: state.isSelected,
          ),
        ],
      );
    },
  );
}

Widget dateEvent(BuildContext context, int index, List<Event> eventList) {
  final isLight = context.watch<SettingCubit>().isLight();

  return index == eventList.length - 1 ||
          DateFormat.yMMMMd().format(eventList[index].messageTime) !=
              DateFormat.yMMMMd().format(eventList[index + 1].messageTime)
      ? Container(
          alignment: context.watch<SettingCubit>().state.dateBubble == 'left'
              ? Alignment.centerLeft
              : Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Container(
            alignment: Alignment.center,
            width: 150,
            height: 30,
            decoration: BoxDecoration(
              color: isLight ? Colors.red : Colors.purple,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              DateFormat.yMMMEd().format(eventList[index].messageTime),
              style: TextStyle(
                fontSize: context.watch<SettingCubit>().state.textTheme.bodyText1!.fontSize,
              ),
            ),
          ),
        )
      : const SizedBox();
}
