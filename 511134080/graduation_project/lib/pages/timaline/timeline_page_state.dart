part of 'timeline_page_cubit.dart';

class TimelinePageState {
  final List<Event> _events;
  final List<Chat> _chats;
  final Set<String> tags;
  final bool isShowingFavourites;

  TimelinePageState({
    List<Event> events = const [],
    List<Chat> chats = const [],
    this.tags = const {},
    this.isShowingFavourites = false,
  })  : _events = events,
        _chats = chats;

  List<Event> get events => isShowingFavourites
      ? List<Event>.from(
          _events.reversed.where((event) => event.isFavourite),
        )
      : List<Event>.from(_events.reversed);

  List<Event> get allEvents => List<Event>.from(_events.reversed);

  List<Chat> get allChats => _chats;

  int get eventsLength => isShowingFavourites
      ? _events.where((event) => event.isFavourite).length
      : _events.length;

  TimelinePageState copyWith({
    List<Event>? newEvents,
    List<Chat>? newChats,
    bool? showingFavourites,
    Set<String>? newTags,
  }) =>
      TimelinePageState(
        events: newEvents ?? _events,
        chats: newChats ?? _chats,
        isShowingFavourites: showingFavourites ?? isShowingFavourites,
        tags: newTags ?? tags,
      );
}
