import 'package:intl/intl.dart';

import '../constants.dart';
import '../models/event.dart';

class StatisticsUtil {
  static DateTime calculateFilteredDate(String timeOption) {
    if (timeOption == timeOptions[0]) {
      return DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      );
    } else if (timeOption == timeOptions[1]) {
      return DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ).subtract(
        const Duration(
          days: 7,
        ),
      );
    } else if (timeOption == timeOptions[2]) {
      return DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ).subtract(
        const Duration(
          days: 30,
        ),
      );
    } else if (timeOption == timeOptions[3]) {
      return DateTime(
        DateTime.now().year,
        1,
        1,
      );
    } else {
      throw Exception('Invalid time option!');
    }
  }

  static List<List<int>> calculateChartsStatistics(
      List<Event> events, String timeOption) {
    final filteredDate = calculateFilteredDate(timeOption);

    if (timeOption == timeOptions[3]) {
      return _calculateForThisYear(events, filteredDate);
    } else if (timeOption == timeOptions[0]) {
      return _calculateForToday(events, filteredDate);
    }

    var chartsStat = <List<int>>[];
    if (events.isNotEmpty) {
      var date = events.first.time;
      var i = 0;
      var j = 0;
      chartsStat.add([0, 0, 0, 0]);

      for (final event in events) {
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

  static List<List<int>> _calculateForThisYear(
    List<Event> events,
    DateTime filteredDate,
  ) {
    var chartsStat = <List<int>>[];
    if (events.isNotEmpty) {
      var date = events.first.time;
      var i = 0;
      var j = 0;
      chartsStat.add([0, 0, 0, 0]);

      for (final event in events) {
        if (event.time.isAfter(filteredDate)) {
          if (DateFormat('MM-yyyy').format(event.time) ==
              DateFormat('MM-yyyy').format(date)) {
            chartsStat[i][0] = j;
          } else {
            j = event.time.month - date.month + 1;
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

  static List<List<int>> _calculateForToday(
    List<Event> events,
    DateTime filteredDate,
  ) {
    var chartsStat = <List<int>>[];
    if (events.isNotEmpty) {
      var date = events.first.time;
      var i = 0;
      var j = 0;
      chartsStat.add([0, 0, 0, 0]);

      for (final event in events) {
        if (event.time.isAfter(filteredDate)) {
          if (DateFormat('H').format(event.time) ==
              DateFormat('H').format(date)) {
            chartsStat[i][0] = j;
          } else {
            j = event.time.hour - date.hour + 1;
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
}
