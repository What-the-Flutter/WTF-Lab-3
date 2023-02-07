import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:my_final_project/data/db/firebase_provider.dart';
import 'package:my_final_project/entities/bar_chart.dart';
import 'package:my_final_project/ui/widgets/statistics_screen/cubit/statistics_state.dart';
import 'package:my_final_project/utils/constants/statistics_time.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  final User? user;
  late final firebase = FirebaseProvider(user: user);

  StatisticsCubit({this.user})
      : super(
          StatisticsState(
            index: 0,
            statisticsTime: 'Past 30 days',
            listTotalStatistics: [],
            listBookmarksStatistics: [],
            listLabelsStatistics: [],
            listAnswerStatistics: [],
            listBarChartData: [],
            mapPopular: {},
          ),
        );

  void changeStatisticsTime(String newTime) {
    emit(state.copyWith(statisticsTime: newTime));
  }

  void changeBodyStatistics(int index) {
    emit(state.copyWith(index: index));
  }

  void getAllDataStatistics(String newTime) {
    switch (newTime) {
      case StatisticsTime.today:
        changeDataStatisticsToday();
        break;
      case StatisticsTime.pastSevenDays:
        changeDataStatisticsPastSevenDays();
        break;
      case StatisticsTime.pastThirtyDays:
        changeDataStatisticsPastThirtyDays();
        break;
      case StatisticsTime.thisYear:
        changeDataStatisticsThisYear();
        break;
    }
  }

  Future<void> changeMapPopular() async {
    final listEvent = await firebase.getAllEvent();
    final listMap = <String, double>{};
    final listEventWithSection =
        listEvent.where((element) => element.sectionTitle != null).toList();
    final listEventWithPicture =
        listEvent.where((element) => element.messageImage != null).toList();
    final listEventWithTags = listEvent.where((element) => element.tag != null).toList();
    listMap['Section'] = listEventWithSection.length.toDouble();
    listMap['Picture'] = listEventWithPicture.length.toDouble();
    listMap['Tags'] = listEventWithTags.length.toDouble();
    emit(state.copyWith(mapPopular: listMap));
  }

  void changeListBarChartData() {
    switch (state.statisticsTime) {
      case StatisticsTime.today:
        changeListBarChartDataToday();
        break;
      case StatisticsTime.pastSevenDays:
        changeListBarChartDataPastSevenDays();
        break;
      case StatisticsTime.pastThirtyDays:
        changeListBarChartDataPastThirtyDays();
        break;
      case StatisticsTime.thisYear:
        changeListBarChartDataThisYear();
        break;
    }
  }

  void changeListBarChartDataThisYear() {
    final today = DateTime.now();
    DateTime yearAgo;
    final listChart = <BarChartData>[];
    yearAgo = DateTime(today.year, 1, 1);
    while (yearAgo.isBefore(today)) {
      listChart.add(
        BarChartData(
          labelsY: state.listLabelsStatistics
              .where((element) =>
                  element.messageTime.month == yearAgo.month &&
                  element.messageTime.year == yearAgo.year)
              .length,
          bookmarksY: state.listBookmarksStatistics
              .where((element) =>
                  element.messageTime.month == yearAgo.month &&
                  element.messageTime.year == yearAgo.year)
              .length,
          dateX: DateFormat.MMMM().format(yearAgo),
          answersY: state.listAnswerStatistics
              .where((element) =>
                  element.messageTime.month == yearAgo.month &&
                  element.messageTime.year == yearAgo.year)
              .length,
          totalY: getRemainingTotalForYear(yearAgo),
        ),
      );
      yearAgo = DateTime(yearAgo.year, yearAgo.month + 1, yearAgo.day);
    }
    emit(state.copyWith(listBarChartData: listChart));
  }

  int getRemainingTotalForYear(DateTime yearAgo) {
    return state.listTotalStatistics
            .where((element) =>
                element.messageTime.month == yearAgo.month &&
                element.messageTime.year == yearAgo.year)
            .length -
        state.listAnswerStatistics
            .where((element) =>
                element.messageTime.month == yearAgo.month &&
                element.messageTime.year == yearAgo.year)
            .length -
        state.listBookmarksStatistics
            .where((element) =>
                element.messageTime.month == yearAgo.month &&
                element.messageTime.year == yearAgo.year)
            .length -
        state.listLabelsStatistics
            .where((element) =>
                element.messageTime.month == yearAgo.month &&
                element.messageTime.year == yearAgo.year)
            .length;
  }

  void changeListBarChartDataPastThirtyDays() {
    final today = DateTime.now();
    DateTime thirtyDaysAgo;
    final listChart = <BarChartData>[];
    thirtyDaysAgo = DateTime(today.year, today.month, today.day - 30);
    while (thirtyDaysAgo.isBefore(today)) {
      listChart.add(
        BarChartData(
          labelsY: state.listLabelsStatistics
              .where((element) =>
                  DateFormat.yMMMMd().format(element.messageTime) ==
                  DateFormat.yMMMMd().format(thirtyDaysAgo))
              .length,
          bookmarksY: state.listBookmarksStatistics
              .where((element) =>
                  DateFormat.yMMMMd().format(element.messageTime) ==
                  DateFormat.yMMMMd().format(thirtyDaysAgo))
              .length,
          dateX: thirtyDaysAgo.day.toString(),
          answersY: state.listAnswerStatistics
              .where((element) =>
                  DateFormat.yMMMMd().format(element.messageTime) ==
                  DateFormat.yMMMMd().format(thirtyDaysAgo))
              .length,
          totalY: getRemainingTotalForWeekAndThirty(thirtyDaysAgo),
        ),
      );
      thirtyDaysAgo = DateTime(
        thirtyDaysAgo.year,
        thirtyDaysAgo.month,
        thirtyDaysAgo.day + 1,
      );
    }
    emit(state.copyWith(listBarChartData: listChart));
  }

  void changeListBarChartDataPastSevenDays() {
    final today = DateTime.now();
    DateTime dayWeekAgo;
    final listChart = <BarChartData>[];
    dayWeekAgo = DateTime(today.year, today.month, today.day - 7);
    while (dayWeekAgo.isBefore(today)) {
      listChart.add(
        BarChartData(
          labelsY: state.listLabelsStatistics
              .where((element) =>
                  DateFormat.yMMMMd().format(element.messageTime) ==
                  DateFormat.yMMMMd().format(dayWeekAgo))
              .length,
          bookmarksY: state.listBookmarksStatistics
              .where((element) =>
                  DateFormat.yMMMMd().format(element.messageTime) ==
                  DateFormat.yMMMMd().format(dayWeekAgo))
              .length,
          dateX: dayWeekAgo.day.toString(),
          answersY: state.listAnswerStatistics
              .where((element) =>
                  DateFormat.yMMMMd().format(element.messageTime) ==
                  DateFormat.yMMMMd().format(dayWeekAgo))
              .length,
          totalY: getRemainingTotalForWeekAndThirty(dayWeekAgo),
        ),
      );
      dayWeekAgo = DateTime(
        dayWeekAgo.year,
        dayWeekAgo.month,
        dayWeekAgo.day + 1,
      );
    }
    emit(state.copyWith(listBarChartData: listChart));
  }

  int getRemainingTotalForWeekAndThirty(DateTime dayWeekAgo) {
    return state.listTotalStatistics
            .where((element) =>
                DateFormat.yMMMMd().format(element.messageTime) ==
                DateFormat.yMMMMd().format(dayWeekAgo))
            .length -
        state.listAnswerStatistics
            .where((element) =>
                DateFormat.yMMMMd().format(element.messageTime) ==
                DateFormat.yMMMMd().format(dayWeekAgo))
            .length -
        state.listBookmarksStatistics
            .where((element) =>
                DateFormat.yMMMMd().format(element.messageTime) ==
                DateFormat.yMMMMd().format(dayWeekAgo))
            .length -
        state.listLabelsStatistics
            .where((element) =>
                DateFormat.yMMMMd().format(element.messageTime) ==
                DateFormat.yMMMMd().format(dayWeekAgo))
            .length;
  }

  void changeListBarChartDataToday() {
    final listChart = <BarChartData>[
      BarChartData(
        answersY: state.listAnswerStatistics.length,
        bookmarksY: state.listBookmarksStatistics.length,
        totalY: state.listTotalStatistics.length -
            state.listAnswerStatistics.length -
            state.listBookmarksStatistics.length -
            state.listLabelsStatistics.length,
        labelsY: state.listLabelsStatistics.length,
        dateX: 'Today',
      ),
    ];
    emit(state.copyWith(listBarChartData: listChart));
  }

  Future<void> changeDataStatisticsThisYear() async {
    final listAllEvent = await firebase.getAllEvent();
    final dateToday = DateTime.now();
    final dateYearAgo = DateTime(dateToday.year, 1, 1);
    final listTotalThisYear = listAllEvent
        .where((element) =>
            element.messageTime.isAfter(dateYearAgo) && element.messageTime.isBefore(dateToday))
        .toList();
    final listBookmarksThisYear =
        listTotalThisYear.where((element) => element.isFavorit == true).toList();
    final listLabelsThisYear =
        listTotalThisYear.where((element) => element.sectionTitle != null).toList();
    final listAnswerThisYear =
        listTotalThisYear.where((element) => element.messageType == 'recipient').toList();
    emit(
      state.copyWith(
        listTotalStatistics: listTotalThisYear,
        listAnswerStatistics: listAnswerThisYear,
        listLabelsStatistics: listLabelsThisYear,
        listBookmarksStatistics: listBookmarksThisYear,
      ),
    );
  }

  Future<void> changeDataStatisticsPastThirtyDays() async {
    final listAllEvent = await firebase.getAllEvent();
    final dateToday = DateTime.now();
    final dateThirtyDaysAgo = DateTime(dateToday.year, dateToday.month, dateToday.day - 30);
    final listTotalPastThirtyDays = listAllEvent
        .where((element) =>
            element.messageTime.isAfter(dateThirtyDaysAgo) &&
            element.messageTime.isBefore(dateToday))
        .toList();
    final listBookmarksPastThirtyDays =
        listTotalPastThirtyDays.where((element) => element.isFavorit == true).toList();
    final listLabelsPastThirtyDays =
        listTotalPastThirtyDays.where((element) => element.sectionTitle != null).toList();
    final listAnswerPastThirtyDays =
        listTotalPastThirtyDays.where((element) => element.messageType == 'recipient').toList();
    emit(
      state.copyWith(
        listTotalStatistics: listTotalPastThirtyDays,
        listAnswerStatistics: listAnswerPastThirtyDays,
        listLabelsStatistics: listLabelsPastThirtyDays,
        listBookmarksStatistics: listBookmarksPastThirtyDays,
      ),
    );
  }

  Future<void> changeDataStatisticsPastSevenDays() async {
    final listAllEvent = await firebase.getAllEvent();
    final dateToday = DateTime.now();
    final dateSevenDaysAgo = DateTime(dateToday.year, dateToday.month, dateToday.day - 7);
    final listTotalPastSevenDays = listAllEvent
        .where((element) =>
            element.messageTime.isAfter(dateSevenDaysAgo) &&
            element.messageTime.isBefore(dateToday))
        .toList();
    final listBookmarksPastSevenDays =
        listTotalPastSevenDays.where((element) => element.isFavorit == true).toList();
    final listLabelsPastSevenDays =
        listTotalPastSevenDays.where((element) => element.sectionTitle != null).toList();
    final listAnswerPastSevenDays =
        listTotalPastSevenDays.where((element) => element.messageType == 'recipient').toList();
    emit(
      state.copyWith(
        listTotalStatistics: listTotalPastSevenDays,
        listAnswerStatistics: listAnswerPastSevenDays,
        listLabelsStatistics: listLabelsPastSevenDays,
        listBookmarksStatistics: listBookmarksPastSevenDays,
      ),
    );
  }

  Future<void> changeDataStatisticsToday() async {
    final listAllEvent = await firebase.getAllEvent();
    final dateToday = DateTime.now();
    final listTotalToday = listAllEvent
        .where((element) =>
            DateFormat.yMd().format(element.messageTime) == DateFormat.yMd().format(dateToday))
        .toList();
    final listBookmarksToday =
        listTotalToday.where((element) => element.isFavorit == true).toList();
    final listLabelsToday =
        listTotalToday.where((element) => element.sectionTitle != null).toList();
    final listAnswerToday =
        listTotalToday.where((element) => element.messageType == 'recipient').toList();
    emit(
      state.copyWith(
        listTotalStatistics: listTotalToday,
        listAnswerStatistics: listAnswerToday,
        listLabelsStatistics: listLabelsToday,
        listBookmarksStatistics: listBookmarksToday,
      ),
    );
  }
}
