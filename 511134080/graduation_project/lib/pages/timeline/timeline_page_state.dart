part of 'timeline_page_cubit.dart';

class TimelinePageState {
  final List<Event> _events;
  final List<Chat> _chats;
  final Set<String> tags;
  final bool isShowingFavourites;
  final List<String> selectedPages;
  final bool isIgnoreSelectedPages;
  final List<String> _hintMessages;
  final List<String> selectedTags;

  TimelinePageState({
    List<Event> events = const [],
    List<Chat> chats = const [],
    this.tags = const {},
    this.isShowingFavourites = false,
    this.selectedPages = const [],
    this.isIgnoreSelectedPages = true,
    this.selectedTags = const [],
  })  : _events = events,
        _chats = chats,
        _hintMessages = [
          'Your timeline is empty!\n',
          'There are no events to be displayed on your timeline, or you have filtered out all your pages in the filter menu',
          'You don\'t have any bookmarked events, or none of the unfiltered pages have any bookmarked events',
        ];

  List<String> get hintMessages => isShowingFavourites
      ? [_hintMessages[0], _hintMessages[2]]
      : [_hintMessages[0], _hintMessages[1]];

  List<Event> get events => isShowingFavourites
      ? List<Event>.from(
          _filteredEvents().where((event) => event.isFavourite),
        )
      : _filteredEvents();

  List<Event> get allEvents => List<Event>.from(_events.reversed);

  List<Chat> get allChats => _chats;

  int get eventsLength => isShowingFavourites
      ? _filteredEvents().where((event) => event.isFavourite).length
      : _filteredEvents().length;

  TimelinePageState copyWith({
    List<Event>? newEvents,
    List<Chat>? newChats,
    bool? showingFavourites,
    Set<String>? newTags,
    List<String>? changedSelectedPages,
    bool? ignoreSelectedPages,
    List<String>? changesSelectedTags,
  }) =>
      TimelinePageState(
        events: newEvents ?? _events,
        chats: newChats ?? _chats,
        isShowingFavourites: showingFavourites ?? isShowingFavourites,
        tags: newTags ?? tags,
        selectedPages: changedSelectedPages ?? selectedPages,
        isIgnoreSelectedPages: ignoreSelectedPages ?? isIgnoreSelectedPages,
        selectedTags: changesSelectedTags ?? selectedTags,
      );

  List<Event> _filteredEvents() {
    var allEvents = _events;
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

    allEvents = List<Event>.from(allEvents)
      ..removeWhere((event) {
        final tags = extractHashTags(event.title);
        var notContains = true;
        for (final tag in tags) {
          if (selectedTags.contains(tag)) {
            notContains = false;
            break;
          }
        }
        return notContains;
      });

    return allEvents
      ..sort(
        (event_1, event_2) => event_2.time.compareTo(
          event_1.time,
        ),
      );
  }
}
