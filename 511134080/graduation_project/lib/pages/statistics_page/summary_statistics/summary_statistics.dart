import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import 'summary_statistics_cubit.dart';

class SummaryStatistics extends StatelessWidget {
  final String timeOption;
  SummaryStatistics({
    required this.timeOption,
    Key? key,
  }) : super(key: key);

  final colors = [
    Colors.red[200],
    Colors.green[200],
    Colors.blue[200],
  ];

  Widget _totalAmount(BuildContext context, SummaryStatisticsState state) {
    return Container(
      width: 96,
      decoration: BoxDecoration(
        color: colors[0],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            'Total',
            style: TextStyle(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          Text(
            '${state.summaryStatistics(timeOption)[0]}',
            style: TextStyle(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookmarkAmount(BuildContext context, SummaryStatisticsState state) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: colors[1],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            'Bookmarks',
            style: TextStyle(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          Text(
            '${state.summaryStatistics(timeOption)[1]}',
            style: TextStyle(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _labelAmount(BuildContext context, SummaryStatisticsState state) {
    return Container(
      width: 96,
      decoration: BoxDecoration(
        color: colors[2],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            'Labels',
            style: TextStyle(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          Text(
            '${state.summaryStatistics(timeOption)[2]}',
            style: TextStyle(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryStatistics(
    BuildContext context,
    SummaryStatisticsState state,
  ) {
    return Expanded(
      child: Wrap(
        spacing: 16,
        runSpacing: 0,
        direction: Axis.horizontal,
        children: [
          _totalAmount(context, state),
          _bookmarkAmount(context, state),
          _labelAmount(context, state),
        ],
      ),
    );
  }

  FlBorderData _borderData(BuildContext context) {
    return FlBorderData(
      border: Border(
        top: BorderSide.none,
        right: BorderSide.none,
        left: BorderSide(
          width: 1,
          color: Theme.of(context).secondaryHeaderColor,
        ),
        bottom: BorderSide(
          width: 1,
          color: Theme.of(context).secondaryHeaderColor,
        ),
      ),
    );
  }

  bool _shouldShowHorizontalLine(double value, List<List<int>> charts) => charts
      .map((dayStat) =>
          dayStat.getRange(1, dayStat.length).contains(value.toInt()))
      .contains(true);

  FlGridData _gridData(BuildContext context, List<List<int>> charts) {
    return FlGridData(
      drawVerticalLine: false,
      horizontalInterval: 1,
      getDrawingHorizontalLine: (value) => FlLine(
        color: Theme.of(context).disabledColor.withAlpha(80),
        dashArray: [5, 5],
      ),
      checkToShowHorizontalLine: (value) =>
          _shouldShowHorizontalLine(value, charts),
    );
  }

  List<BarChartGroupData> _barGroups(
      BuildContext context, List<List<int>> charts) {
    return [
      for (final dayStatistics in charts)
        BarChartGroupData(
          x: dayStatistics[0],
          barRods: [
            BarChartRodData(
              toY: dayStatistics[1].toDouble(),
              width: 15,
              color: colors[0],
            ),
            BarChartRodData(
              toY: dayStatistics[2].toDouble(),
              width: 15,
              color: colors[1],
            ),
            BarChartRodData(
              toY: dayStatistics[3].toDouble(),
              width: 15,
              color: colors[2],
            ),
          ],
        ),
    ];
  }

  bool _shouldDisplay(List<List<int>> charts, double value) => charts
      .map((dayStat) =>
          dayStat.getRange(1, dayStat.length).contains(value.toInt()))
      .contains(true);

  FlTitlesData _titlesData(BuildContext context, List<List<int>> charts) {
    return FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, _) {
            return Text(
              '${_shouldDisplay(charts, value) ? value.toInt() : ''}',
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
              ),
            );
          },
        ),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
        ),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
        ),
      ),
    );
  }

  Widget _barCharts(
    BuildContext context,
    SummaryStatisticsState state,
    List<List<int>> charts,
  ) {
    return Expanded(
      flex: 5,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 400,
          child: BarChart(
            BarChartData(
              maxY: state.maxY(timeOption).toDouble(),
              borderData: _borderData(context),
              gridData: _gridData(context, charts),
              barGroups: _barGroups(context, charts),
              titlesData: _titlesData(context, charts),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SummaryStatisticsCubit, SummaryStatisticsState>(
      builder: (context, state) {
        final charts = state.chartsStatistics(timeOption);
        return Column(
          children: [
            _summaryStatistics(context, state),
            _barCharts(context, state, charts),
            Expanded(
              child: Text(
                titleAxis[timeOptions.indexOf(timeOption)],
                style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
