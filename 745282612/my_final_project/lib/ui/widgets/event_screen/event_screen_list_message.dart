import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/entities/event.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_cubit.dart';
import 'package:my_final_project/ui/widgets/event_screen/cubit/event_state.dart';
import 'package:my_final_project/ui/widgets/event_screen/event_message.dart';

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
  if (state.isSection) {
    return MediaQuery.of(context).size.height * 0.2;
  } else if (state.isSearch) {
    return MediaQuery.of(context).size.height * 0;
  } else {
    return MediaQuery.of(context).size.height * 0.1;
  }
}

Widget listMessage(BuildContext context, EventState state, User? _user, int chatId) {
  return StreamBuilder(
    stream: FirebaseDatabase.instance.ref().child(_user?.uid ?? '').child('event').onValue,
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const CircularProgressIndicator();
      } else {
        final eventList = <Event>[];
        final Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
        for (final chatElement in map.values) {
          final map = chatElement as Map<dynamic, dynamic>;
          final chat = Event.fromJson(map);
          eventList.add(chat);
        }
        final newEventList =
            eventList.reversed.where((element) => element.chatId == chatId).toList();
        newEventList.sort(
          (a, b) => b.messageTime.compareTo(a.messageTime),
        );

        return ListView.builder(
          reverse: true,
          padding: EdgeInsets.only(bottom: sizePaddingBottom(context, state)),
          itemCount: newEventList.length,
          itemBuilder: (context, index) {
            return EventMessage(
              event: newEventList[index],
              isSelected: state.isSelected,
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
      return EventMessage(
        event: event,
        isSelected: state.isSelected,
      );
    },
  );
}
