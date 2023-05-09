import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../event_notifier.dart';
import '../models/event.dart';

class EventWidget extends StatelessWidget {
  final Event event;

  EventWidget({
    required this.event,
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var icon = event.isFavourite ? Icons.bookmark_outlined : null;
    return GestureDetector(
      onTap: () {
        if (event.isSelectionProcess) {
          Provider.of<EventsNotifier>(context, listen: false)
              .selectedEvent(event);
        } else {
          Provider.of<EventsNotifier>(context, listen: false)
              .favouriteEvent(event);
        }
      },
      onLongPress: () {
        if (!event.isSelectionProcess) {
          Provider.of<EventsNotifier>(context, listen: false)
              .selectionProcessHandler(event);
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: event.isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.background,
            ),
            child: Row(
              children: [
                Text(event.text),
              ],
            ),
          ),
          Icon(
            icon,
            color: Colors.amber,
          ),
        ],
      ),
    );
  }
}
