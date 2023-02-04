import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/event.dart';

class EventView extends StatefulWidget {
  final Event event;

  const EventView({required this.event});

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {

  final dateFormat = DateFormat('hh:mm');

  Widget buildEventSubtitle() {
    return UnconstrainedBox(
      child: Row(
        children: [
          Text(
            dateFormat.format(widget.event.changeTime),
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
    
          if (widget.event.isFavorite) 
            const Icon(
              Icons.bookmark,
              color: Colors.deepOrange,
            ),
        ],
      ),
    );
  }

  Widget buildEventContent() {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.event.isFavorite = !widget.event.isFavorite;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.event.text),
            const SizedBox(height: 10.0),
            buildEventSubtitle(), 
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: buildEventContent(),
        ),
      ],
    );
  }
}