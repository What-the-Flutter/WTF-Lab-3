part of 'timeline_page_cubit.dart';

class TimelinePageState {
  final List<Event> _events;
  final List<Chat> chats;
  final Set<String> tags;
  final bool isShowingFavourites;
  final List<String> _hintMessages;

  TimelinePageState({
    List<Event> events = const [],
    this.chats = const [],
    this.tags = const {},
    this.isShowingFavourites = false,
  })  : _events = events,
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
          _events.where((event) => event.isFavourite),
        )
      : _events;

  List<Event> get allEvents => List<Event>.from(_events.reversed);

  int get eventsLength => isShowingFavourites
      ? _events.where((event) => event.isFavourite).length
      : _events.length;

  TimelinePageState copyWith({
    List<Event>? newEvents,
    List<Chat>? newChats,
    Set<String>? newTags,
    bool? showingFavourites,
  }) =>
      TimelinePageState(
        events: newEvents ?? _events,
        chats: newChats ?? chats,
        tags: newTags ?? tags,
        isShowingFavourites: showingFavourites ?? isShowingFavourites,
      );
}
