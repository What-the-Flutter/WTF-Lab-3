import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../EventNotifier.dart';
import '../models/event.dart';

class EventWidget extends StatelessWidget {
  final Event event;

  EventWidget({
    required this.event,
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (event.isSelectionProcess) {
          Provider.of<EventsNotifier>(context, listen: false)
              .selectedEvent(event);
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
          Consumer<EventsNotifier>(
            builder: (context, provider, child) => Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: event.isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.background,
              ),
              child: Text(event.text),
            ),
          )
        ],
      ),
    );
  }
}
