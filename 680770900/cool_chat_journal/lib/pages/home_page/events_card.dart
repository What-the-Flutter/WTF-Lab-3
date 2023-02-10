import 'package:flutter/material.dart';

import '../../model/events_group.dart';
import '../events_page/events_page.dart';

class EventsCard extends StatefulWidget {

  final Icon icon;
  final String title;
  final String subtitle;

  const EventsCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  State<EventsCard> createState() => _EventsCardState();
}

class _EventsCardState extends State<EventsCard> {
  
 late EventsGroup _eventsGroup;

  @override
  void initState() {
    super.initState();
    _eventsGroup = EventsGroup.empty(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap:() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventsPage(_eventsGroup)
            ),
          );
        },
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.background,
            ),
            child: widget.icon,
          ),
          title: Text(widget.title),
          subtitle: Text(widget.subtitle),
        ),
      ),
    );
  }
}