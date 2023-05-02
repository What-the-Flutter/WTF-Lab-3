import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repos/event_repository.dart';
import 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  final EventRepositoryImpl _eventRepository;

  StatisticsCubit({required eventRepository})
      : _eventRepository = eventRepository,
        super(StatisticsState(isLoaded: false));

  Future<void> loadEvents() async {
    final events = await _eventRepository.getEventsForTimeLine();
    emit(
      state.copyWith(
        events: events,
        isLoaded: true,
      ),
    );
  }

  Future<Map<int, List<int>>> getMapForSummaryChart() async {
    final events = state.events;
    final eventsPerDay = List.generate(30, (_) => [0, 0, 0]);

    events?.forEach(
      (event) {
        final dayIndex = DateTime.now().difference(event.createTime).inDays;
        if (dayIndex >= 0 && dayIndex < 30) {
          eventsPerDay[dayIndex][0]++;
          if (event.isDone) {
            eventsPerDay[dayIndex][1]++;
          } else if (event.isFavorite) {
            eventsPerDay[dayIndex][2]++;
          }
        }
      },
    );
    return eventsPerDay.asMap();
  }

  int getTotalAmountOfEvents() {
    final events = state.events;
    var amount = 0;
    events?.forEach(
      (event) {
        final dayIndex = DateTime.now().difference(event.createTime).inDays;
        if (dayIndex >= 0 && dayIndex < 30) {
          amount++;
        }
      },
    );
    return amount;
  }

  int getAmountOfFavorites() {
    final events = state.events;
    var amount = 0;
    events?.forEach(
      (event) {
        final dayIndex = DateTime.now().difference(event.createTime).inDays;
        if (dayIndex >= 0 && dayIndex < 30) {
          if (event.isFavorite) {
            amount++;
          }
        }
      },
    );
    return amount;
  }

  int getAmountOfDone() {
    final events = state.events;
    var amount = 0;
    events?.forEach(
      (event) {
        final dayIndex = DateTime.now().difference(event.createTime).inDays;
        if (dayIndex >= 0 && dayIndex < 30) {
          if (event.isDone) {
            amount++;
          }
        }
      },
    );
    return amount;
  }
}
