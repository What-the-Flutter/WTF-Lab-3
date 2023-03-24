import 'package:diary_application/domain/models/event.dart';
import 'package:equatable/equatable.dart';

class SearchState extends Equatable {
  final List<Event> events;
  final List<Event> fullEvents;

  SearchState(this.events, this.fullEvents);

  SearchState copyWith(List<Event>? events) {
    return SearchState(events ?? this.events, fullEvents);
  }

  @override
  List<Object?> get props => [events];
}
