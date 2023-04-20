import 'package:flutter/material.dart';

import '../../../../domain/entities/event.dart';
import 'event_dialog.dart';
import 'event_bubble.dart';

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
        itemCount: _events.length,
        itemBuilder: (context, index) {
          final previousMessageSendTime = index != 0
              ? _events[index - 1].createTime
              : DateTime(0, 0, 0, 0, 0, 0, 0, 0);
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: InkWell(
              onLongPress: () => _longPressHandler(
                context,
                _events[index],
              ),
              child: (() {
                if (_isFavoritesMode) {
                  if (_events[index].isFavorite) {
                    return EventBubble(
                      event: _events[index],
                      previousEventSendTime: previousMessageSendTime,
                    );
                  }
                  else {
                    return Container();
                  }
                } else {
                  return EventBubble(
                    event: _events[index],
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
