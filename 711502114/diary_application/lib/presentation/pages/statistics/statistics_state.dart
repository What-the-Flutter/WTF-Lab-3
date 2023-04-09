import 'package:diary_application/domain/models/chart_data.dart';
import 'package:diary_application/domain/models/event.dart';
import 'package:equatable/equatable.dart';

enum StatisticsPeriodMode {
  today, thisWeek, thisMonth, thisYear,
}

class StatisticsState extends Equatable {
  final StatisticsPeriodMode period;
  final List<Event> total;
  final List<Event> favorites;
  final List<Event> labels;
  final List<ChartData> chartDataList;

  const StatisticsState({
    this.period = StatisticsPeriodMode.today,
    this.total = const [],
    this.favorites = const [],
    this.labels = const [],
    this.chartDataList = const [],
  });

  StatisticsState copyWith({
    StatisticsPeriodMode? period,
    List<Event>? total,
    List<Event>? favorites,
    List<Event>? labels,
    List<ChartData>? chartDataList,
  }) {
    return StatisticsState(
      period: period ?? this.period,
      total: total ?? this.total,
      favorites: favorites ?? this.favorites,
      labels: labels ?? this.labels,
      chartDataList: chartDataList ?? this.chartDataList,
    );
  }

  @override
  List<Object?> get props => [period, total, favorites, labels, chartDataList];
}
