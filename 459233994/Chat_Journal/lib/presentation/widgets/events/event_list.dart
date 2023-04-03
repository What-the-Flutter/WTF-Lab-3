import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/event.dart';
import '../../screens/chat/chat_cubit.dart';
import 'event_dialog.dart';
import 'event_widget.dart';

class EventList extends StatelessWidget {
  final List<Event> _events;
  final bool _isFavoritesMode;
  final GlobalKey _globalKey = GlobalKey();

  EventList({
    required events,
    required isFavoritesMode,
  })  : _events = events,
        _isFavoritesMode = isFavoritesMode;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      key: _globalKey,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: ReadContext(context).read<ChatCubit>().getEvents().length,
        itemBuilder: (context, index) {
          final previousMessageSendTime = index != 0
              ? ReadContext(context)
                  .read<ChatCubit>()
                  .getEventByIndex(index - 1).createTime
              : DateTime(0, 0, 0, 0, 0, 0, 0, 0);
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: InkWell(
              onLongPress: () => _longPressHandler(
                  context,
                  ReadContext(context)
                      .read<ChatCubit>()
                      .getEventByIndex(index)),
              child: (() {
                if (_isFavoritesMode) {
                  if (ReadContext(context)
                      .read<ChatCubit>()
                      .getEventByIndex(index)
                      .isFavorite) {
                    return EventWidget(
                      event: ReadContext(context)
                          .read<ChatCubit>()
                          .getEventByIndex(index),
                      previousEventSendTime: previousMessageSendTime,
                    );
                  }
                } else {
                  return EventWidget(
                    event: ReadContext(context)
                        .read<ChatCubit>()
                        .getEventByIndex(index),
                    previousEventSendTime: previousMessageSendTime,
                  );
                }
              }()),
            ),
          );
        },
      ),
    );
  }

  void _longPressHandler(BuildContext context, Event event) {
    showDialog(
      context: context,
      builder: (context) {
        if (event.textData != null) {
          return EventDialog(
            event: event,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
