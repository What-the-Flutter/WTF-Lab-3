import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/event.dart';

class EventView extends StatefulWidget {
  
  final Event event;
  final bool isSelected;

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const EventView({
    required this.event,
    this.isSelected = false,
    this.onTap,
    this.onLongPress,  
  });

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {

  final dateFormat = DateFormat('hh:mm');

  Widget buildEventSubtitle() {
    return UnconstrainedBox(
      child: Row(
        children: [
          if (widget.isSelected)
            const Icon(
              Icons.check_circle,
              size: 15.0,
            ),

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
              size: 15.0,
            ),
        ],
      ),
    );
  }

  Widget buildEventContent() {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
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