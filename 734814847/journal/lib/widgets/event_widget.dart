import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../EventNotifier.dart';
import '../models/event.dart';

class EventWidget extends StatelessWidget {
  Event event;

  EventWidget(
      {required String text,
      required DateTime date,
      IconData? icon,
      bool isSelected = false})
      : event = Event(
          text: text,
          date: date,
          icon: icon,
          isSelected: isSelected,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (event.selectionProcess) {
          Provider.of<EventsNotifier>(context, listen: false)
              .selectedEvent(this);
        }
      },
      onLongPress: () {
        if (!event.selectionProcess) {
          Provider.of<EventsNotifier>(context, listen: false)
              .selectionProcessHandler(this);
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
