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

  List<List<int>> chartsStatistics(String timeOption) {
    late final DateTime filteredDate;
    if (timeOption == timeOptions[0]) {
      filteredDate = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      );
    } else if (timeOption == timeOptions[1]) {
      filteredDate = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ).subtract(
        const Duration(
          days: 7,
        ),
      );
    } else if (timeOption == timeOptions[2]) {
      filteredDate = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ).subtract(
        const Duration(
          days: 30,
        ),
      );
    } else if (timeOption == timeOptions[3]) {
      filteredDate = DateTime(
        DateTime.now().year,
        1,
        1,
      );
    } else {
      throw Exception('Invalid time option!');
    }

    final sortedEvents = List<Event>.from(events)
      ..sort((event_1, event_2) => event_2.time.compareTo(event_1.time));
    var chartsStat = <List<int>>[];
    if (sortedEvents.isNotEmpty) {
      var date = sortedEvents.first.time;
      var i = 0;
      var j = 0;
      chartsStat.add([0, 0, 0, 0]);

      for (final event in sortedEvents) {
        if (event.time.isAfter(filteredDate)) {
          if (DateFormat('dd-MM-yyyy').format(event.time) ==
              DateFormat('dd-MM-yyyy').format(date)) {
            chartsStat[i][0] = j;
          } else {
            j = event.time.difference(date).inDays + 1;
            i += 1;
            chartsStat.add([j, 0, 0, 0]);
            date = event.time;
          }
          chartsStat[i][1] += 1;
          if (event.isFavourite) {
            chartsStat[i][2] += 1;
          }
          if (event.categoryIndex > 1) {
            chartsStat[i][3] += 1;
          }
        }
      }
    }
    return chartsStat;
  }

  SummaryStatisticsState copyWith({
    List<Event>? newEvents,
  }) =>
      SummaryStatisticsState(
        events: newEvents ?? events,
      );
}
