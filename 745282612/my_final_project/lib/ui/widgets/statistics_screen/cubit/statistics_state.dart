import 'package:equatable/equatable.dart';

import 'package:my_final_project/entities/bar_chart.dart';
import 'package:my_final_project/entities/event.dart';

class StatisticsState extends Equatable {
  final int index;
  final String statisticsTime;
  final Map<String, double> mapPopular;
  final List<Event> listTotalStatistics;
  final List<Event> listBookmarksStatistics;
  final List<Event> listLabelsStatistics;
  final List<Event> listAnswerStatistics;
  final List<BarChartData> listBarChartData;

  StatisticsState({
    required this.mapPopular,
    required this.listBarChartData,
    required this.index,
    required this.statisticsTime,
    required this.listAnswerStatistics,
    required this.listBookmarksStatistics,
    required this.listLabelsStatistics,
    required this.listTotalStatistics,
  });

  StatisticsState copyWith({
    int? index,
    String? statisticsTime,
    List<Event>? listTotalStatistics,
    List<Event>? listBookmarksStatistics,
    List<Event>? listLabelsStatistics,
    List<Event>? listAnswerStatistics,
    List<BarChartData>? listBarChartData,
    Map<String, double>? mapPopular,
  }) {
    return StatisticsState(
      index: index ?? this.index,
      statisticsTime: statisticsTime ?? this.statisticsTime,
      listTotalStatistics: listTotalStatistics ?? this.listTotalStatistics,
      listBookmarksStatistics: listBookmarksStatistics ?? this.listBookmarksStatistics,
      listLabelsStatistics: listLabelsStatistics ?? this.listLabelsStatistics,
      listAnswerStatistics: listAnswerStatistics ?? this.listAnswerStatistics,
      listBarChartData: listBarChartData ?? this.listBarChartData,
      mapPopular: mapPopular ?? this.mapPopular,
    );
  }

  @override
  List<Object?> get props => [
        listBarChartData,
        index,
        statisticsTime,
        listTotalStatistics,
        listBookmarksStatistics,
        listLabelsStatistics,
        listAnswerStatistics,
        mapPopular,
      ];
}
