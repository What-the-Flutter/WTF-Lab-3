part of 'statistic_cubit.dart';

@freezed
class StatisticState with _$StatisticState {
  const factory StatisticState.initial({
    required IList<ActivityModel> activities,
    required IList<MessageModel> messages,
    required IList<DateTime> datesRange,
    required DateTime entryTime,
    required int yMax,
    required MessageDateChartSelections dateSelection,
  }) = _Initial;
}
