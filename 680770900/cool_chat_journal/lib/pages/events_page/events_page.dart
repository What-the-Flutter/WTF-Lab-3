import 'package:flutter/material.dart';

import '../../model/event.dart';
import '../../model/events_group.dart';
import 'bottom_panel.dart';
import 'event_view.dart';

class EventsPage extends StatefulWidget {  

  final EventsGroup eventsGroup;

  const EventsPage(this.eventsGroup);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {

  bool _showFavorites = false;

  void addEvent(String eventText) {
    setState(() {
      widget.eventsGroup.events.add(Event(eventText));
    });
  }

  Widget buildFavoriteAction() {
    Icon bookmarkIcon;
    if (_showFavorites) {
      bookmarkIcon = const Icon(Icons.bookmark, color: Colors.deepOrange);
    } else {
      bookmarkIcon = const Icon(Icons.bookmark_border);
    }

    return IconButton(
      icon: bookmarkIcon,
      onPressed: () {
        setState(() => _showFavorites = !_showFavorites);
      },
    );
  }

  Widget buildSearchAction() {
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () => {},
    );
  }

  Widget buildEventsView() {
    if (widget.eventsGroup.isNotEmpty) {
      return ListView.builder(
        itemCount: widget.eventsGroup.count,
        itemBuilder: (_, index) => EventView(
          event: widget.eventsGroup.events[index],
        ),
      ); 
    } else {
      return Align(
        alignment: Alignment.topCenter,
        child: _WelcomeMessage(title: widget.eventsGroup.groupName),
      );
    }
  }

  Widget buildScaffoldBody() {
    return Column(
      children: [
        Expanded(
          child: buildEventsView(),
        ),

        BottomPanel(
          onSendText: addEvent,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.eventsGroup.groupName),
        actions: [
          buildSearchAction(),
          buildFavoriteAction(),
        ],
      ),

      body: buildScaffoldBody(),
    );
  }
}

class _WelcomeMessage extends StatelessWidget {
  
  final String title;

  const _WelcomeMessage({required this.title});
  
  @override
  Widget build(BuildContext context) {
    var titleMessage = 'This is the page where you can track '
      'everything about "$title"';

    return Card(
      child: ListTile(
        title: Text(
          titleMessage,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}