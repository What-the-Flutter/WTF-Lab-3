part of 'statistics_page_cubit.dart';

class StatisticsPageState {
  final int selectedIndex;
  final String timeOption;
  final bool isShowingOptions;

  StatisticsPageState({
    this.selectedIndex = 0,
    this.timeOption = 'Past 30 days',
    this.isShowingOptions = false,
  });

  StatisticsPageState copyWith({
    int? changedSelectedIndex,
    String? newTimeOption,
    bool? showingOptions,
  }) =>
      StatisticsPageState(
        selectedIndex: changedSelectedIndex ?? selectedIndex,
        timeOption: newTimeOption ?? timeOption,
        isShowingOptions: showingOptions ?? isShowingOptions,
      );
}
