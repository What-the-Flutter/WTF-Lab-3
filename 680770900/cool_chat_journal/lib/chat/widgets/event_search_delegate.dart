import 'package:chats_repository/chats_repository.dart';
import 'package:flutter/material.dart';

import 'event_view.dart';

class EventSearchDelegate extends SearchDelegate {
  final List<Event> events;

  EventSearchDelegate({
    required this.events,
  });

  List<Event> _createEventsList() {
    final fondedNotes = <Event>[];

    for (final event in events) {
      if (!event.isImage && event.content.contains(query)) {
        fondedNotes.add(event);
      }
    }

    return fondedNotes;
  }

  Widget _createSearchResult(List<Event> result) {
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (context, index) => EventView(
        event: result[index],
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _createSearchResult(_createEventsList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _createSearchResult(_createEventsList());
  }
}
