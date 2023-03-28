part of 'searching_page_cubit.dart';

class SearchingPageState {
  final String input;
  final List<bool> selectedTags;
  final Set<String> tags;
  final List<Event> events;

  const SearchingPageState({
    this.input = '',
    this.selectedTags = const [],
    this.tags = const {},
    this.events = const [],
  });

  List<Event> get foundedEvents {
    if (input == '') {
      final founded = <Event>[];
      if (selectedTags.contains(true)) {
        for (var i = 0; i < tags.length; i++) {
          if (selectedTags[i]) {
            founded.addAll(
              events.where(
                (Event event) =>
                    event.title.contains(tags.elementAt(i)) &&
                    !founded.contains(event),
              ),
            );
          }
        }
        return founded
          ..sort((event_1, event_2) => event_1.time.compareTo(event_2.time));
      } else {
        return [];
      }
    } else {
      return List<Event>.from(
          events.reversed.where((Event event) => event.title.contains(input)));
    }
  }

  SearchingPageState copyWith({
    String? newInput,
    List<bool>? newTagsSelected,
    Set<String>? newTags,
    List<Event>? newEvents,
  }) {
    return SearchingPageState(
      input: newInput ?? input,
      selectedTags: newTagsSelected ?? selectedTags,
      tags: newTags ?? tags,
      events: newEvents ?? events,
    );
  }
}
