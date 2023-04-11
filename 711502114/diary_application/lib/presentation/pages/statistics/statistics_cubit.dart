import 'package:diary_application/domain/models/chart_data.dart';
import 'package:diary_application/domain/models/event.dart';
import 'package:diary_application/domain/repository/event_repository_api.dart';
import 'package:diary_application/domain/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  final EventRepositoryApi eventRepository;

  StatisticsCubit(this.eventRepository) : super(const StatisticsState()) {
    getStatistics();
  }

  void changePeriod(String? mode) {
    emit(state.copyWith(
        period: StatisticsPeriodMode.values
            .firstWhere((m) => m.toString() == mode)));
    getStatistics();
  }

  void getStatistics() {
    final today = DateTime.now();
    switch (state.period) {
      case StatisticsPeriodMode.today:
        _getToday(today);
        break;
      case StatisticsPeriodMode.thisWeek:
        _getLastWeek(today);
        break;
      case StatisticsPeriodMode.thisMonth:
        _getLastMonth(today);
        break;
      case StatisticsPeriodMode.thisYear:
        _getLastYear(today);
        break;
    }
  }

  void _getToday(DateTime today) async {
    final events = (await eventRepository.getAllEvents())
        .where((event) =>
            DateFormat.yMd().format(event.creationTime.toDT) ==
            DateFormat.yMd().format(today))
        .toList();
    final favorites = events.where((e) => e.isFavorite).toList();
    final labels = events.where((e) => e.category != null).toList();
    emit(
      state.copyWith(
        total: events,
        favorites: favorites,
        labels: labels,
        chartDataList: [
          ChartData(
            dataX: '',
            favoritesY: favorites.length,
            labelY: labels.length,
            totalY: events.length,
          ),
        ],
      ),
    );
  }

  void _getLastWeek(DateTime today) async {
    DateTime thisWeek = today.subtract(const Duration(days: 7));
    final events = (await eventRepository.getAllEvents())
        .where((event) => event.creationTime.toDT.isAfter(thisWeek))
        .toList();
    final favorites = events.where((e) => e.isFavorite).toList();
    final labels = events.where((e) => e.category != null).toList();
    final chartDataList = <ChartData>[];
    while (thisWeek.isBefore(today)) {
      _addChartData(chartDataList, thisWeek);
      thisWeek = thisWeek.add(const Duration(days: 1));
    }
    emit(state.copyWith(
      total: events,
      favorites: favorites,
      labels: labels,
      chartDataList: chartDataList,
    ));
  }

  void _getLastMonth(DateTime today) async {
    DateTime thisMonth = today.subtract(const Duration(days: 30));
    final events = (await eventRepository.getAllEvents())
        .where((event) => event.creationTime.toDT.isAfter(thisMonth))
        .toList();
    final favorites = events.where((e) => e.isFavorite).toList();
    final labels = events.where((e) => e.category != null).toList();
    final chartDataList = <ChartData>[];
    while (thisMonth.isBefore(today)) {
      _addChartData(chartDataList, thisMonth);
      thisMonth = thisMonth.add(const Duration(days: 1));
    }
    emit(state.copyWith(
      total: events,
      favorites: favorites,
      labels: labels,
      chartDataList: chartDataList,
    ));
  }

  void _getLastYear(DateTime today) async {
    DateTime thisYear = DateTime(today.year, 1, 1);
    final events = (await eventRepository.getAllEvents())
        .where((event) => event.creationTime.toDT.isAfter(thisYear))
        .toList();
    final favorites = events.where((e) => e.isFavorite).toList();
    final labels = events.where((e) => e.category != null).toList();
    final chartDataList = <ChartData>[];
    while (thisYear.isBefore(today)) {
      _addChartData(chartDataList, thisYear);
      thisYear = thisYear.add(const Duration(days: 1));
    }
    emit(state.copyWith(
      total: events,
      favorites: favorites,
      labels: labels,
      chartDataList: chartDataList,
    ));
  }

  void _addChartData(List<ChartData> list, DateTime time) {
    list.add(
      ChartData(
        dataX: time.month.toString(),
        favoritesY: _lookForDefiniteDates(state.favorites, time),
        labelY: _lookForDefiniteDates(state.labels, time),
        totalY: _lookForDefiniteDates(state.total, time),
      ),
    );
  }

  int _lookForDefiniteDates(List<Event> list, DateTime time) {
    return list
        .where((event) =>
            DateFormat.yMMMMd().format(event.creationTime.toDT) ==
            DateFormat.yMMMMd().format(time))
        .toList()
        .length;
  }

  List<Event> getCategoryEvents() {
    return state.total.where((e) => e.category != null).toList();
  }
}
