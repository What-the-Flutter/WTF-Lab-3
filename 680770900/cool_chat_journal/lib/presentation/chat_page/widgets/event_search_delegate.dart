import 'package:flutter/material.dart';

import '../../../../data/models/models.dart';
import 'event_view.dart';

class EventSearchDelegate extends SearchDelegate {
  final List<Event> events;

  EventSearchDelegate({
    required this.events,
  });

  List<Event> _eventsList() {
    final fondedNotes = <Event>[];

    for (final event in events) {
      final content = event.content;
      if (content != null && content.contains(query)) {
        fondedNotes.add(event);
      }
    }

    return fondedNotes;
  }

  Widget _searchResult() {
    final result = _eventsList();
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (context, index) => EventView(
        chatName: null,
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
  Widget buildResults(BuildContext context) => _searchResult();

  @override
  Widget buildSuggestions(BuildContext context) => _searchResult();
}
