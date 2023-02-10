import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_final_project/entities/bar_chart.dart';
import 'package:my_final_project/generated/l10n.dart';
import 'package:my_final_project/ui/widgets/settings_screen/cubit/settings_cubit.dart';
import 'package:my_final_project/ui/widgets/statistics_screen/cubit/statistics_cubit.dart';
import 'package:my_final_project/ui/widgets/statistics_screen/cubit/statistics_state.dart';
import 'package:my_final_project/utils/constants/app_colors.dart';
import 'package:my_final_project/utils/constants/statistics_time.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SummaryStatistics extends StatefulWidget {
  const SummaryStatistics({
    super.key,
  });

  @override
  State<SummaryStatistics> createState() => _SummaryStatisticsState();
}

class _SummaryStatisticsState extends State<SummaryStatistics> {
  @override
  void initState() {
    context
        .read<StatisticsCubit>()
        .getAllDataStatistics(context.read<StatisticsCubit>().state.statisticsTime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<StatisticsCubit>().state;
    final isLight = context.read<SettingCubit>().isLight();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _dropdownButton(state, context, isLight),
          _infoStatistics(context, state),
          const SizedBox(
            height: 50,
          ),
          _chartToRun(context, state),
        ],
      ),
    );
  }
}

Widget _dropdownButton(StatisticsState state, BuildContext context, bool isLight) {
  return DropdownButton<String>(
    value: state.statisticsTime,
    isExpanded: true,
    icon: const Icon(Icons.arrow_downward),
    elevation: 16,
    style: TextStyle(
      color: isLight ? Colors.black : Colors.white,
      fontSize: context.read<SettingCubit>().state.textTheme.bodyLarge!.fontSize,
    ),
    underline: Container(
      height: 2,
      color: isLight ? Colors.black : Colors.white,
    ),
    onChanged: (value) {
      context.read<StatisticsCubit>().changeStatisticsTime(value!);
      context.read<StatisticsCubit>().getAllDataStatistics(value);
    },
    items: <String>[
      StatisticsTime.today,
      StatisticsTime.pastSevenDays,
      StatisticsTime.pastThirtyDays,
      StatisticsTime.thisYear,
    ].map<DropdownMenuItem<String>>(
      (value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      },
    ).toList(),
  );
}

Widget _infoStatistics(BuildContext context, StatisticsState state) {
  return Column(
    children: [
      Row(
        children: [
          _elementStatistics(
            context,
            AppColors.colorForTotalStatistics,
            state.listTotalStatistics.length,
            S.of(context).total,
          ),
          const SizedBox(
            width: 10,
          ),
          _elementStatistics(
            context,
            AppColors.colorForBookmarksStatistics,
            state.listBookmarksStatistics.length,
            S.of(context).bookmark,
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        children: [
          _elementStatistics(
            context,
            AppColors.colorForLabelsStatistics,
            state.listLabelsStatistics.length,
            S.of(context).labels,
          ),
          const SizedBox(
            width: 10,
          ),
          _elementStatistics(
            context,
            AppColors.colorForAnswersStatistics,
            state.listAnswerStatistics.length,
            S.of(context).answers,
          ),
        ],
      ),
    ],
  );
}

Widget _elementStatistics(
  BuildContext context,
  Color color,
  int sizeElementStatistics,
  String titleElementStatistics,
) {
  return Expanded(
    child: Container(
      height: 60,
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$sizeElementStatistics',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: context.read<SettingCubit>().state.textTheme.displayMedium!.fontSize,
            ),
          ),
          Text(
            titleElementStatistics,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: context.read<SettingCubit>().state.textTheme.bodyLarge!.fontSize,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _chartToRun(BuildContext context, StatisticsState state) {
  context.read<StatisticsCubit>().changeListBarChartData();
  return Container(
    height: 450,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          series: <ChartSeries>[
            StackedColumnSeries<BarChartData, String>(
              dataSource: state.listBarChartData,
              color: AppColors.colorForBookmarksStatistics,
              xValueMapper: (events, _) => events.dateX,
              yValueMapper: (events, _) => events.bookmarksY,
            ),
            StackedColumnSeries<BarChartData, String>(
              dataSource: state.listBarChartData,
              color: AppColors.colorForLabelsStatistics,
              xValueMapper: (events, _) => events.dateX,
              yValueMapper: (events, _) => events.labelsY,
            ),
            StackedColumnSeries<BarChartData, String>(
              dataSource: state.listBarChartData,
              color: AppColors.colorForAnswersStatistics,
              xValueMapper: (events, _) => events.dateX,
              yValueMapper: (events, _) => events.answersY,
            ),
            StackedColumnSeries<BarChartData, String>(
              dataSource: state.listBarChartData,
              color: AppColors.colorForTotalStatistics,
              xValueMapper: (events, _) => events.dateX,
              yValueMapper: (events, _) => events.totalY,
            ),
          ],
        ),
      ),
    ),
  );
}
