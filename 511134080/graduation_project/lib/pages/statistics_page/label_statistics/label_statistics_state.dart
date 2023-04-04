part of 'label_statistics_cubit.dart';

class LabelStatisticsState {
  final List<Event> events;

  LabelStatisticsState({
    this.events = const [],
  });

  List<int> labelStatistics(String timeOption) {
    final labelStat = [0, 0, 0, 0, 0, 0];

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
