import '../../../domain/entities/event.dart';

class ChatSearchState {
  final bool isSearched;
  final List<Event>? events;

  ChatSearchState({
    required this.isSearched,
    this.events,
  });

  ChatSearchState copyWith({
    List<Event>? events,
    bool? isSearched,
  }) {
    return ChatSearchState(
      isSearched: isSearched ?? this.isSearched,
      events: events ?? this.events,
    );
  }
}