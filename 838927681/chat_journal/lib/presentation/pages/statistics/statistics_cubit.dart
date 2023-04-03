import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../constants/statistics_title.dart';
import '../../../domain/entities/chart_data.dart';
import '../../../domain/repositories/api_event_repository.dart';
import 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  final ApiEventRepository eventRepository;

  StatisticsCubit(this.eventRepository) : super(const StatisticsState()) {
    getStatisticsData();
  }

  void changePeriod(String? value) {
    emit(state.copyWith(period: value ?? StatisticsTitle.year));
    getStatisticsData();
  }

  void getStatisticsData() {
    switch (state.period) {
      case StatisticsTitle.today:
        {
          _getDataForToday();
          break;
        }
      case StatisticsTitle.week:
        {
          _getDataForWeek();
          break;
        }
      case StatisticsTitle.month:
        {
          _getDataForMonth();
          break;
        }
      case StatisticsTitle.year:
        {
          _getDataForYear();
          break;
        }
    }
  }

  void _getDataForToday() async {
    final today = DateTime.now();
    final events = (await eventRepository.getAllEvents())
        .where((event) =>
            DateFormat.yMd().format(event.dateTime) ==
            DateFormat.yMd().format(today))
        .toList();
    final favorites = events.where((event) => event.isFavorite).toList();
    final labels = events.where((event) => event.iconIndex != 0).toList();
    final chartListDate = <ChartData>[
      ChartData(
        dateX: 'Today',
        favoritesY: favorites.length,
        labelY: labels.length,
        totalY: events.length,
      ),
    ];
    emit(
      state.copyWith(
        totalList: events,
        favoritesList: favorites,
        labelList: labels,
        chartDataList: chartListDate,
      ),
    );
  }

  void _getDataForWeek() async {
    final today = DateTime.now();
    var weekAgo = today.subtract(const Duration(days: 7));
    final events = (await eventRepository.getAllEvents())
        .where((event) => event.dateTime.isAfter(weekAgo))
        .toList();
    final favorites = events.where((event) => event.isFavorite).toList();
    final labels = events.where((event) => event.iconIndex != 0).toList();
    final chartDataList = <ChartData>[];
    while (weekAgo.isBefore(today)) {
      chartDataList.add(
        ChartData(
          dateX: weekAgo.day.toString(),
          favoritesY: state.favoritesList
              .where((event) =>
                  DateFormat.yMMMMd().format(event.dateTime) ==
                  DateFormat.yMMMMd().format(weekAgo))
              .length,
          labelY: state.labelList
              .where((event) =>
                  DateFormat.yMMMMd().format(event.dateTime) ==
                  DateFormat.yMMMMd().format(weekAgo))
              .length,
          totalY: state.totalList
              .where((event) =>
                  DateFormat.yMMMMd().format(event.dateTime) ==
                  DateFormat.yMMMMd().format(weekAgo))
              .length,
        ),
      );
      weekAgo = weekAgo.add(const Duration(days: 1));
    }
    emit(state.copyWith(
      totalList: events,
      favoritesList: favorites,
      labelList: labels,
      chartDataList: chartDataList,
    ));
  }

  void _getDataForMonth() async {
    final today = DateTime.now();
    var monthAgo = today.subtract(const Duration(days: 30));
    final events = (await eventRepository.getAllEvents())
        .where((event) => event.dateTime.isAfter(monthAgo))
        .toList();
    final favorites = events.where((event) => event.isFavorite).toList();
    final labels = events.where((event) => event.iconIndex != 0).toList();
    final chartDataList = <ChartData>[];
    while (monthAgo.isBefore(today)) {
      chartDataList.add(
        ChartData(
          dateX: monthAgo.day.toString(),
          favoritesY: state.favoritesList
              .where((event) =>
                  DateFormat.yMMMMd().format(event.dateTime) ==
                  DateFormat.yMMMMd().format(monthAgo))
              .length,
          labelY: state.labelList
              .where((event) =>
                  DateFormat.yMMMMd().format(event.dateTime) ==
                  DateFormat.yMMMMd().format(monthAgo))
              .length,
          totalY: state.totalList
              .where((event) =>
                  DateFormat.yMMMMd().format(event.dateTime) ==
                  DateFormat.yMMMMd().format(monthAgo))
              .length,
        ),
      );
      monthAgo = monthAgo.add(const Duration(days: 1));
    }
    emit(state.copyWith(
      totalList: events,
      favoritesList: favorites,
      labelList: labels,
      chartDataList: chartDataList,
    ));
  }

  void _getDataForYear() async {
    final today = DateTime.now();
    var thisYear = DateTime(today.year, 1, 1);
    final events = (await eventRepository.getAllEvents())
        .where((event) => event.dateTime.isAfter(thisYear))
        .toList();
    final favorites = events.where((event) => event.isFavorite).toList();
    final labels = events.where((event) => event.iconIndex != 0).toList();
    final chartDataList = <ChartData>[];
    while (thisYear.isBefore(today)) {
      chartDataList.add(
        ChartData(
          dateX: thisYear.month.toString(),
          favoritesY: state.favoritesList
              .where((event) =>
                  DateFormat.yMMMMd().format(event.dateTime) ==
                  DateFormat.yMMMMd().format(thisYear))
              .length,
          labelY: state.labelList
              .where((event) =>
                  DateFormat.yMMMMd().format(event.dateTime) ==
                  DateFormat.yMMMMd().format(thisYear))
              .length,
          totalY: state.totalList
              .where((event) =>
                  DateFormat.yMMMMd().format(event.dateTime) ==
                  DateFormat.yMMMMd().format(thisYear))
              .length,
        ),
      );
      thisYear = thisYear.add(const Duration(days: 1));
    }
    emit(state.copyWith(
      totalList: events,
      favoritesList: favorites,
      labelList: labels,
      chartDataList: chartDataList,
    ));
  }
}
