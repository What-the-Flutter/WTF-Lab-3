import 'package:equatable/equatable.dart';

import '../../models/event.dart';

class SearchState extends Equatable {
  final List<Event> events;

  SearchState(this.events);

  SearchState copyWith(List<Event>? events) {
    return SearchState(events ?? this.events);
  }

  @override
  List<Object?> get props => [events];
}
