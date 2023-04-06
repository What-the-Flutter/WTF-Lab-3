import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/data.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  final EventsRepository _eventsRepository;

  late final StreamSubscription<List<Event>> _eventsSubscription;

  StatisticsCubit(
    this._eventsRepository,
  ) : super(const StatisticsState()) {
    _eventsSubscription = _eventsRepository.eventsStream.listen(_setEvents);
  }

  @override
  Future<void> close() {
    _eventsSubscription.cancel();
    return super.close();
  }

  void setFilter(DateFilter filter) {
    emit(state.copyWith(currentFilter: filter));
  }

  void _setEvents(List<Event> events) {
    emit(state.copyWith(events: events));
  }
}
