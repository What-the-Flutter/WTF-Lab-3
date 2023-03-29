import 'package:equatable/equatable.dart';

import '../../../constants/statistics_title.dart';
import '../../../domain/entities/chart_data.dart';
import '../../../domain/entities/event.dart';

class StatisticsState extends Equatable {
  final String period;
  final List<Event> totalList;
  final List<Event> favoritesList;
  final List<Event> labelList;
  final List<ChartData> chartDataList;

  const StatisticsState({
    this.period = StatisticsTitle.month,
    this.totalList = const [],
    this.favoritesList = const [],
    this.labelList = const [],
    this.chartDataList = const [],
  });

  StatisticsState copyWith({
    String? period,
    List<Event>? totalList,
    List<Event>? favoritesList,
    List<Event>? labelList,
    List<ChartData>? chartDataList,
  }) {
    return StatisticsState(
      period: period ?? this.period,
      totalList: totalList ?? this.totalList,
      favoritesList: favoritesList ?? this.favoritesList,
      labelList: labelList ?? this.labelList,
      chartDataList: chartDataList ?? this.chartDataList,
    );
  }

  @override
  List<Object?> get props =>
      [period, totalList, favoritesList, labelList, chartDataList];
}
