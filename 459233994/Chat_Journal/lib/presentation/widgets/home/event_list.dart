import 'package:flutter/material.dart';

import '../../screens/messages.dart';

class EventList extends StatefulWidget {

  EventList({
    Key? key,
  }) : super(key: key);

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  final List _eventNames = ['Travel', 'Family', 'Sports'];

  final List _eventIcons = [
    const Icon(Icons.airplanemode_active),
    const Icon(Icons.living_outlined),
    const Icon(Icons.sports_basketball)
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _eventNames.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return ListTile(
          hoverColor: const Color(0xffD0F4EA),
          title: Text(_eventNames[index]),
          subtitle: const Text('No events'),
          leading: _eventIcons[index],
          onTap: () => {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MessagesScreen(
                  title: _eventNames[index],
                ),
              ),
            ),
          },
        );
      },
    );
  }
}
