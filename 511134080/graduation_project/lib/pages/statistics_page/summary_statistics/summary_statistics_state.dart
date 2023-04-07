part of 'summary_statistics_cubit.dart';

class SummaryStatisticsState {
  final List<Event> events;

  SummaryStatisticsState({
    this.events = const [],
  });

  List<int> summaryStatistics(String timeOption) {
    final summaryStat = [0, 0, 0];

    late final DateTime date;

    if (timeOption == timeOptions[0]) {
      date = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      );
    } else if (timeOption == timeOptions[1]) {
      date = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ).subtract(
        const Duration(
          days: 7,
        ),
      );
    } else if (timeOption == timeOptions[2]) {
      date = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ).subtract(
        const Duration(
          days: 30,
        ),
      );
    } else if (timeOption == timeOptions[3]) {
      date = DateTime(
        DateTime.now().year,
        1,
        1,
      );
    } else {
      throw Exception('Invalid time option!');
    }

    for (final event in events) {
      if (event.time.isAfter(date)) {
        if (event.isFavourite) {
          summaryStat[1] += 1;
        }
        if (event.categoryIndex > 1) {
          summaryStat[2] += 1;
        }
        summaryStat[0] += 1;
      }
    }

    return summaryStat;
  }

  int maxY(String timeOption) {
    if (chartsStatistics(timeOption).isNotEmpty) {
      final values = chartsStatistics(timeOption)
          .map((dayStat) => dayStat.getRange(1, dayStat.length).reduce(max));
      return values.reduce(max) + 1;
    }
    return 10;
  }

  List<List<int>> chartsStatistics(String timeOption) {
    final sortedEvents = List<Event>.from(events)
      ..sort((event_1, event_2) => event_1.time.compareTo(event_2.time));
    return StatisticsUtil.calculateChartsStatistics(sortedEvents, timeOption);
  }

  SummaryStatisticsState copyWith({
    List<Event>? newEvents,
  }) =>
      SummaryStatisticsState(
        events: newEvents ?? events,
      );
}
