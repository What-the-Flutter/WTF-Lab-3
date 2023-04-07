part of 'label_statistics_cubit.dart';

class LabelStatisticsState {
  final List<Event> events;

  LabelStatisticsState({
    this.events = const [],
  });

  List<int> labelStatistics(String timeOption) {
    final labelStat = [0, 0, 0, 0, 0, 0];

    final date = StatisticsUtil.calculateFilteredDate(timeOption);

    for (final event in events) {
      if (event.time.isAfter(date)) {
        if (event.categoryIndex > 1) {
          labelStat[event.categoryIndex - 2] += 1;
        }
      }
    }

    return labelStat;
  }

  LabelStatisticsState copyWith({
    List<Event>? newEvents,
  }) =>
      LabelStatisticsState(
        events: newEvents ?? events,
      );
}
