part of 'filter_page_cubit.dart';

class FilterPageState {
  final List<Event> _events;
  final List<Chat> chats;
  final Set<String> tags;
  final List<String> selectedPages;
  final bool isIgnoreSelectedPages;
  final List<String> selectedTags;
  final List<String> selectedCategories;
  final String input;

  FilterPageState({
    List<Event> events = const [],
    this.chats = const [],
    this.tags = const {},
    this.selectedPages = const [],
    this.isIgnoreSelectedPages = true,
    this.selectedTags = const [],
    this.selectedCategories = const [],
    this.input = '',
  }) : _events = events;

  FilterPageState copyWith({
    List<Event>? newEvents,
    List<Chat>? newChats,
    Set<String>? newTags,
    List<String>? changedSelectedPages,
    bool? ignoreSelectedPages,
    List<String>? changesSelectedTags,
    List<String>? changedSelectedCategories,
    String? changedInput,
  }) =>
      FilterPageState(
        events: newEvents ?? _events,
        chats: newChats ?? chats,
        tags: newTags ?? tags,
        selectedPages: changedSelectedPages ?? selectedPages,
        isIgnoreSelectedPages: ignoreSelectedPages ?? isIgnoreSelectedPages,
        selectedTags: changesSelectedTags ?? selectedTags,
        selectedCategories: changedSelectedCategories ?? selectedCategories,
        input: changedInput ?? input,
      );

  List<Event> get events => _filteredEvents();

  List<Event> _filteredEvents() {
    var allEvents = _events;

    if (selectedPages.isNotEmpty) {
      allEvents = List<Event>.from(allEvents)
        ..removeWhere(
          (event) => isIgnoreSelectedPages
              ? selectedPages.contains(
                  event.chatId,
                )
              : !selectedPages.contains(
                  event.chatId,
                ),
        );
    }

    if (selectedTags.isNotEmpty) {
      allEvents = List<Event>.from(allEvents)
        ..removeWhere(
          (event) {
            final tags = extractHashTags(event.title);
            var notContains = true;
            for (final tag in tags) {
              if (selectedTags.contains(tag)) {
                notContains = false;
                break;
              }
            }
            return notContains;
          },
        );
    }

    if (selectedCategories.isNotEmpty) {
      allEvents = List<Event>.from(allEvents)
        ..removeWhere(
          (event) => !selectedCategories.contains(
            allCategoryTitles[event.categoryIndex],
          ),
        );
    }

    if (input != '') {
      allEvents = List<Event>.from(allEvents)
        ..removeWhere(
          (event) => !event.title.contains(
            input,
          ),
        );
    }

    return List<Event>.from(allEvents)
      ..sort(
        (event_1, event_2) => event_2.time.compareTo(
          event_1.time,
        ),
      );
  }
}
